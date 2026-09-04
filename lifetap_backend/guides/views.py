from rest_framework import generics, permissions

from .models import EmergencyGuide
from .serializers import EmergencyGuideSerializer


class EmergencyGuideListView(generics.ListAPIView):
    """GET /api/guides/ — every guide step, across all categories."""

    queryset = EmergencyGuide.objects.all()
    serializer_class = EmergencyGuideSerializer
    permission_classes = [permissions.IsAuthenticated]


class EmergencyGuideByCategoryView(generics.ListAPIView):
    """GET /api/guides/<category>/ — ordered steps for one category."""

    serializer_class = EmergencyGuideSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        category = self.kwargs["category"].upper()
        return EmergencyGuide.objects.filter(category=category)
