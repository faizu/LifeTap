from django.contrib import admin

from .models import PatientProfile


@admin.register(PatientProfile)
class PatientProfileAdmin(admin.ModelAdmin):
    list_display = ["name", "user", "age", "blood_group", "phone", "created_at"]
    search_fields = ["name", "user__username", "phone"]
