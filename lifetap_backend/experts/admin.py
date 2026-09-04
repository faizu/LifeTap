from django.contrib import admin

from .models import Expert


@admin.register(Expert)
class ExpertAdmin(admin.ModelAdmin):
    list_display = ["name", "specialization", "phone", "available", "latitude", "longitude"]
    list_filter = ["specialization", "available"]
    list_editable = ["available"]
