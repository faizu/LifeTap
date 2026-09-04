from rest_framework import serializers

from .models import EmergencyGuide


class EmergencyGuideSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmergencyGuide
        fields = ["id", "category", "title", "step_number", "instruction"]
