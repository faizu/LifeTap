from rest_framework import serializers

from experts.serializers import ExpertSerializer
from guides.models import EmergencyGuide
from guides.serializers import EmergencyGuideSerializer

from .models import EmergencyCase


class EmergencyReportSerializer(serializers.Serializer):
    """Input payload for POST /api/emergencies/ (matches the Flutter
    request shape described in the project plan)."""

    symptoms = serializers.CharField()
    latitude = serializers.FloatField()
    longitude = serializers.FloatField()
    profile_flags = serializers.DictField(required=False, default=dict)


class EmergencyCaseSerializer(serializers.ModelSerializer):
    """Output for listing/retrieving cases."""

    expert = ExpertSerializer(read_only=True)

    class Meta:
        model = EmergencyCase
        fields = [
            "id",
            "symptoms",
            "latitude",
            "longitude",
            "urgency",
            "status",
            "expert",
            "created_at",
        ]


class EmergencyResultSerializer(serializers.Serializer):
    """Shape of the response returned right after POST /api/emergencies/,
    matching the example in the project plan (case_id, urgency, expert,
    fallback_available)."""

    case_id = serializers.IntegerField()
    urgency = serializers.CharField()
    status = serializers.CharField()
    expert_available = serializers.BooleanField()
    expert = ExpertSerializer(allow_null=True)
    fallback_available = serializers.BooleanField()
    fallback_guide = EmergencyGuideSerializer(many=True, required=False)
    disclaimer = serializers.CharField()
