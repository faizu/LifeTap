from rest_framework import generics, permissions

from .models import Expert
from .serializers import ExpertSerializer


class ExpertListView(generics.ListAPIView):
    """GET /api/experts/ — all experts (any authenticated user)."""

    queryset = Expert.objects.all().order_by("name")
    serializer_class = ExpertSerializer
    permission_classes = [permissions.IsAuthenticated]


class AvailableExpertListView(generics.ListAPIView):
    """GET /api/experts/available/ — only experts currently available."""

    queryset = Expert.objects.filter(available=True).order_by("name")
    serializer_class = ExpertSerializer
    permission_classes = [permissions.IsAuthenticated]
