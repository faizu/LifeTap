from django.db.models import Count
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from emergencies.models import EmergencyCase, Urgency
from emergencies.serializers import EmergencyCaseSerializer
from experts.models import Expert

from .permissions import IsLifeTapAdmin


class StatisticsView(APIView):
    """GET /api/dashboard/statistics/ — read-only counts for the admin
    dashboard (project plan section 15). Does not change any routing
    decisions; monitoring/analytics only."""

    permission_classes = [IsAuthenticated, IsLifeTapAdmin]

    def get(self, request):
        counts_by_urgency = dict(
            EmergencyCase.objects.values("urgency")
            .annotate(count=Count("id"))
            .values_list("urgency", "count")
        )
        data = {
            "total_cases": EmergencyCase.objects.count(),
            "critical_cases": counts_by_urgency.get(Urgency.CRITICAL, 0),
            "high_priority": counts_by_urgency.get(Urgency.HIGH, 0),
            "medium": counts_by_urgency.get(Urgency.MEDIUM, 0),
            "low": counts_by_urgency.get(Urgency.LOW, 0),
            "available_experts": Expert.objects.filter(available=True).count(),
            "total_experts": Expert.objects.count(),
        }
        return Response(data)


class RecentCasesView(APIView):
    """GET /api/dashboard/recent-cases/ — most recent N emergency cases."""

    permission_classes = [IsAuthenticated, IsLifeTapAdmin]

    def get(self, request):
        limit = int(request.query_params.get("limit", 20))
        cases = EmergencyCase.objects.all()[:limit]
        return Response(EmergencyCaseSerializer(cases, many=True).data)
