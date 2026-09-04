from django.conf import settings
from django.db import models

from experts.models import Expert
from patients.models import PatientProfile


class Urgency(models.TextChoices):
    CRITICAL = "CRITICAL", "Critical"
    HIGH = "HIGH", "High"
    MEDIUM = "MEDIUM", "Medium"
    LOW = "LOW", "Low"


class CaseStatus(models.TextChoices):
    PENDING = "PENDING", "Pending"
    ROUTED = "ROUTED", "Routed to expert"
    FALLBACK = "FALLBACK", "Fallback guide shown"
    CLOSED = "CLOSED", "Closed"


class EmergencyCase(models.Model):
    """Matches the `emergency_case` table in the project's ER design."""

    patient = models.ForeignKey(
        PatientProfile, on_delete=models.CASCADE, related_name="emergency_cases"
    )
    symptoms = models.TextField()
    latitude = models.FloatField()
    longitude = models.FloatField()
    urgency = models.CharField(max_length=10, choices=Urgency.choices)
    status = models.CharField(
        max_length=10, choices=CaseStatus.choices, default=CaseStatus.PENDING
    )
    expert = models.ForeignKey(
        Expert, on_delete=models.SET_NULL, null=True, blank=True, related_name="cases"
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return f"Case #{self.id} — {self.urgency} — {self.patient.name}"
