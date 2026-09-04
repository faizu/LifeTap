from django.conf import settings
from django.db import models


class Gender(models.TextChoices):
    MALE = "MALE", "Male"
    FEMALE = "FEMALE", "Female"
    OTHER = "OTHER", "Other"
    PREFER_NOT_TO_SAY = "UNSPECIFIED", "Prefer not to say"


class PatientProfile(models.Model):
    """Matches the `patient` table in the project's ER design."""

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="patient_profile"
    )
    name = models.CharField(max_length=150)
    age = models.PositiveSmallIntegerField(null=True, blank=True)
    gender = models.CharField(
        max_length=20, choices=Gender.choices, default=Gender.PREFER_NOT_TO_SAY
    )
    blood_group = models.CharField(max_length=5, blank=True)
    medical_history = models.TextField(
        blank=True,
        help_text="Free-text known conditions/allergies/medications. Demo data only.",
    )
    emergency_contact_name = models.CharField(max_length=150, blank=True)
    emergency_contact_phone = models.CharField(max_length=20, blank=True)
    phone = models.CharField(max_length=20, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name
