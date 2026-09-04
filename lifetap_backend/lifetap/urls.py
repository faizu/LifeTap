from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/auth/", include("accounts.urls")),
    path("api/patients/", include("patients.urls")),
    path("api/experts/", include("experts.urls")),
    path("api/emergencies/", include("emergencies.urls")),
    path("api/guides/", include("guides.urls")),
    path("api/dashboard/", include("dashboard.urls")),
]
