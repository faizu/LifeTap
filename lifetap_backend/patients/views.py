from rest_framework import permissions
from rest_framework.generics import RetrieveUpdateAPIView

from .models import PatientProfile
from .serializers import PatientProfileSerializer


class MyPatientProfileView(RetrieveUpdateAPIView):
    """GET/PUT /api/patients/me/ — the logged-in patient's own profile.

    Creates an empty profile on first access so the mobile app always
    has something to fill in during onboarding.
    """

    serializer_class = PatientProfileSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        profile, _ = PatientProfile.objects.get_or_create(
            user=self.request.user,
            defaults={"name": self.request.user.get_full_name() or self.request.user.username},
        )
        return profile
