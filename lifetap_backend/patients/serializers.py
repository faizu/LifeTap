from rest_framework import serializers

from .models import PatientProfile


class PatientProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = PatientProfile
        fields = [
            "id",
            "name",
            "age",
            "gender",
            "blood_group",
            "medical_history",
            "emergency_contact_name",
            "emergency_contact_phone",
            "phone",
            "created_at",
        ]
        read_only_fields = ["id", "created_at"]
