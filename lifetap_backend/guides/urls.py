from django.urls import path

from .views import EmergencyGuideByCategoryView, EmergencyGuideListView

urlpatterns = [
    path("", EmergencyGuideListView.as_view(), name="guide-list"),
    path("<str:category>/", EmergencyGuideByCategoryView.as_view(), name="guide-by-category"),
]
