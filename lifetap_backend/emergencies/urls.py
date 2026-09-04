from django.urls import path

from .views import EmergencyCaseDetailView, EmergencyReportView

urlpatterns = [
    path("", EmergencyReportView.as_view(), name="emergency-report"),
    path("<int:pk>/", EmergencyCaseDetailView.as_view(), name="emergency-detail"),
]
