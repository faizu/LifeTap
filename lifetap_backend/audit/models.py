from django.conf import settings
from django.db import models


class AuditLog(models.Model):
    """Matches the `audit_log` table in the project's ER design.

    Every meaningful action (emergency created, expert assigned,
    fallback shown, login, etc.) should write one of these rows so
    the admin dashboard has a real trail to show during the viva.
    """

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="audit_logs",
    )
    action = models.CharField(max_length=100)
    case = models.ForeignKey(
        "emergencies.EmergencyCase",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="audit_logs",
    )
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-timestamp"]

    def __str__(self):
        return f"[{self.timestamp}] {self.action}"
