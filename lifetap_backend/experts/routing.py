"""Expert routing logic (project plan section 9).

Algorithm (student-project version):
  1. Filter available experts
  2. Filter by required specialization (fall back to any available expert
     if none match the specialization)
  3. Calculate approximate distance to the patient
  4. Select the nearest available expert
"""
import math

from .models import Expert


def _haversine_km(lat1, lon1, lat2, lon2):
    """Approximate great-circle distance between two points, in km."""
    r = 6371.0
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    d_phi = math.radians(lat2 - lat1)
    d_lambda = math.radians(lon2 - lon1)
    a = (
        math.sin(d_phi / 2) ** 2
        + math.cos(phi1) * math.cos(phi2) * math.sin(d_lambda / 2) ** 2
    )
    return 2 * r * math.asin(math.sqrt(a))


def find_available_expert(latitude, longitude, specialization=None):
    """Return the nearest available Expert, or None if none are available.

    Tries the requested specialization first; if nobody in that
    specialization is available, falls back to any available expert
    (better to connect the patient to *someone* than nobody).
    """
    available = Expert.objects.filter(available=True)
    if not available.exists():
        return None

    candidates = available
    if specialization:
        matching = available.filter(specialization=specialization)
        if matching.exists():
            candidates = matching

    return min(
        candidates,
        key=lambda e: _haversine_km(latitude, longitude, e.latitude, e.longitude),
    )
