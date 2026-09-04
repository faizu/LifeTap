from rest_framework.permissions import BasePermission


class IsLifeTapAdmin(BasePermission):
    """Allows access only to users whose UserProfile.role == ADMIN.

    Kept separate from Django's `is_staff`/`is_superuser` so the LifeTap
    role system (accounts.UserRole) is the single source of truth for
    in-app permissions, per the project's role-based access design.
    """

    message = "LifeTap admin role required."

    def has_permission(self, request, view):
        profile = getattr(request.user, "profile", None)
        return bool(profile and profile.role == "ADMIN")
