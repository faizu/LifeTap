from django.urls import path

from .views import AvailableExpertListView, ExpertListView

urlpatterns = [
    path("", ExpertListView.as_view(), name="expert-list"),
    path("available/", AvailableExpertListView.as_view(), name="expert-available"),
]
