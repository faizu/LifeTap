from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from audit.models import AuditLog
from experts.models import Specialization
from experts.routing import find_available_expert
from experts.serializers import ExpertSerializer
from guides.models import EmergencyGuide
from guides.serializers import EmergencyGuideSerializer
from patients.models import PatientProfile

from . import triage
from .models import CaseStatus, EmergencyCase, Urgency
from .serializers import (
    EmergencyCaseSerializer,
    EmergencyReportSerializer,
    EmergencyResultSerializer,
)

DISCLAIMER = (
    "LifeTap is an educational prototype. This is NOT a medical "
    "diagnosis. If this is a real emergency, contact local emergency "
    "services immediately."
)

# Simple urgency -> specialization mapping for routing (student MVP).
_SPECIALIZATION_FOR_URGENCY = {
    Urgency.CRITICAL: Specialization.EMERGENCY_MEDICINE,
    Urgency.HIGH: Specialization.EMERGENCY_MEDICINE,
    Urgency.MEDIUM: Specialization.GENERAL,
    Urgency.LOW: Specialization.GENERAL,
}


class EmergencyReportView(APIView):
    """POST /api/emergencies/ — the core LifeTap flow:

    validate -> classify (rule-based) -> find expert -> save case ->
    return result (matches Stage 6 of the project plan).

    GET /api/emergencies/ — list the logged-in patient's own cases
    (or every case, for admins).
    """

    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        is_admin = getattr(getattr(request.user, "profile", None), "role", None) == "ADMIN"
        if is_admin:
            cases = EmergencyCase.objects.all()
        else:
            patient, _ = PatientProfile.objects.get_or_create(
                user=request.user, defaults={"name": request.user.username}
            )
            cases = EmergencyCase.objects.filter(patient=patient)
        return Response(EmergencyCaseSerializer(cases, many=True).data)

    def post(self, request):
        payload = EmergencyReportSerializer(data=request.data)
        payload.is_valid(raise_exception=True)
        data = payload.validated_data

        patient, _ = PatientProfile.objects.get_or_create(
            user=request.user, defaults={"name": request.user.username}
        )

        # 1. Classify
        urgency = triage.classify(data["symptoms"], data.get("profile_flags"))

        # 2. Route to an expert
        specialization = _SPECIALIZATION_FOR_URGENCY.get(urgency, Specialization.GENERAL)
        expert = find_available_expert(
            data["latitude"], data["longitude"], specialization=specialization
        )
        case_status = CaseStatus.ROUTED if expert else CaseStatus.FALLBACK

        # 3. Save the case
        case = EmergencyCase.objects.create(
            patient=patient,
            symptoms=data["symptoms"],
            latitude=data["latitude"],
            longitude=data["longitude"],
            urgency=urgency,
            status=case_status,
            expert=expert,
        )

        # 4. Audit trail
        AuditLog.objects.create(
            user=request.user, action=f"EMERGENCY_CREATED:{urgency}", case=case
        )
        if expert:
            AuditLog.objects.create(
                user=request.user, action=f"ROUTED_TO_EXPERT:{expert.id}", case=case
            )
        else:
            AuditLog.objects.create(user=request.user, action="FALLBACK_SHOWN", case=case)

        # 5. Fallback guide, if no expert was available
        fallback_guide = []
        if not expert:
            category = triage.guide_category_for(urgency, data["symptoms"])
            fallback_guide = EmergencyGuide.objects.filter(category=category)

        result = {
            "case_id": case.id,
            "urgency": urgency,
            "status": case_status,
            "expert_available": expert is not None,
            "expert": ExpertSerializer(expert).data if expert else None,
            "fallback_available": not expert,
            "fallback_guide": EmergencyGuideSerializer(fallback_guide, many=True).data,
            "disclaimer": DISCLAIMER,
        }
        return Response(EmergencyResultSerializer(result).data, status=status.HTTP_201_CREATED)


class EmergencyCaseDetailView(generics.RetrieveAPIView):
    """GET /api/emergencies/<id>/ — case detail (own cases, or any case for admins)."""

    serializer_class = EmergencyCaseSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        is_admin = getattr(getattr(self.request.user, "profile", None), "role", None) == "ADMIN"
        if is_admin:
            return EmergencyCase.objects.all()
        return EmergencyCase.objects.filter(patient__user=self.request.user)
