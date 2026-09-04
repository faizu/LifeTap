from django.db import models


class Specialization(models.TextChoices):
    EMERGENCY_MEDICINE = "EMERGENCY_MEDICINE", "Emergency Medicine"
    CARDIOLOGY = "CARDIOLOGY", "Cardiology"
    GENERAL = "GENERAL", "General / Emergency Support"


class Expert(models.Model):
    """Matches the `expert` table in the project's ER design.

    NOTE: for the student prototype these are demo contacts only. The
    app must never auto-dial a real number — it only displays this
    info with a "Call Expert" button that opens the phone dialer.
    """

    name = models.CharField(max_length=150)
    specialization = models.CharField(
        max_length=30, choices=Specialization.choices, default=Specialization.GENERAL
    )
    phone = models.CharField(max_length=20)
    latitude = models.FloatField()
    longitude = models.FloatField()
    available = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.name} ({self.specialization})"
