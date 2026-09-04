from django.urls import path

from .views import RecentCasesView, StatisticsView

urlpatterns = [
    path("statistics/", StatisticsView.as_view(), name="dashboard-statistics"),
    path("recent-cases/", RecentCasesView.as_view(), name="dashboard-recent-cases"),
]
