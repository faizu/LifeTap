from django.contrib import admin

from .models import EmergencyCase


@admin.register(EmergencyCase)
class EmergencyCaseAdmin(admin.ModelAdmin):
    list_display = ["id", "patient", "urgency", "status", "expert", "created_at"]
    list_filter = ["urgency", "status"]
    search_fields = ["patient__name", "symptoms"]
    readonly_fields = ["created_at"]
