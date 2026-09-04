from django.contrib import admin

from .models import EmergencyGuide


@admin.register(EmergencyGuide)
class EmergencyGuideAdmin(admin.ModelAdmin):
    list_display = ["category", "step_number", "title"]
    list_filter = ["category"]
    ordering = ["category", "step_number"]
