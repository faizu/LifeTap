from django.conf import settings
from django.db import models


class UserRole(models.TextChoices):
    PATIENT = "PATIENT", "Patient"
    EXPERT = "EXPERT", "Expert"
    ADMIN = "ADMIN", "Admin"


class UserProfile(models.Model):
    """Extends Django's built-in User with a LifeTap role.

    Role-based access (see project plan section 22):
      - PATIENT: can create emergencies, view own cases/profile
      - EXPERT: can view cases assigned to them
      - ADMIN: full access, dashboard, user management, audit logs
    """

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="profile"
    )
    role = models.CharField(
        max_length=20, choices=UserRole.choices, default=UserRole.PATIENT
    )
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} ({self.role})"
