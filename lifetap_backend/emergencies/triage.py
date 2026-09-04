"""
Rule-based triage classifier — Stage 4 of the project plan.

*** THIS IS A STUDENT-PROJECT DEMO CLASSIFIER, NOT A MEDICAL DEVICE. ***

It is a transparent, hand-written set of keyword rules used purely to
demonstrate the client -> API -> classifier -> routing architecture.
It is NOT clinically validated, has NOT been reviewed by a medical
professional, and must never be presented to end users as real medical
triage or diagnosis. Every response returned by this module should be
shown to the user alongside a visible "prototype / not medical advice"
disclaimer, and a way to reach real emergency services directly.

Rule precedence (highest urgency wins), based on simple keyword
matching against the free-text symptom description, mirroring the
example pseudocode from the project brief:

    if unconscious:              urgency = CRITICAL
    elif severe_chest_pain:      urgency = HIGH
    elif breathing_difficulty:   urgency = HIGH
    elif minor_injury:           urgency = LOW
    else:                        urgency = MEDIUM

Real deployments would replace/extend this with a reviewed clinical
protocol (e.g. START triage, ESI) rather than ad hoc keywords.
"""
from .models import Urgency

# Keyword sets are intentionally simple and documented so students can
# explain exactly why a given input produced a given result.
CRITICAL_KEYWORDS = ["unconscious", "not breathing", "no pulse", "unresponsive", "seizure"]
HIGH_KEYWORDS = [
    "chest pain",
    "difficulty breathing",
    "breathing difficulty",
    "shortness of breath",
    "severe bleeding",
    "stroke",
    "can't breathe",
    "cannot breathe",
]
LOW_KEYWORDS = ["minor cut", "small cut", "bruise", "mild pain", "minor injury", "sprain"]


def classify(symptoms: str, profile_flags: dict | None = None) -> str:
    """Return one of Urgency.CRITICAL / HIGH / MEDIUM / LOW.

    `symptoms` is the free-text (or transcribed voice) description.
    `profile_flags` may carry extra structured signals from the mobile
    app in future (e.g. {"unconscious": true}); currently only the
    text is used, kept deliberately simple for the MVP.
    """
    text = (symptoms or "").lower()
    flags = profile_flags or {}

    if flags.get("unconscious") or any(kw in text for kw in CRITICAL_KEYWORDS):
        return Urgency.CRITICAL

    if any(kw in text for kw in HIGH_KEYWORDS):
        return Urgency.HIGH

    if any(kw in text for kw in LOW_KEYWORDS):
        return Urgency.LOW

    return Urgency.MEDIUM


def guide_category_for(urgency: str, symptoms: str) -> str:
    """Very simple mapping from symptoms/urgency to a fallback guide
    category. Extend this table as more EmergencyGuide categories are
    added (see the guides app)."""
    text = (symptoms or "").lower()
    if "burn" in text:
        return "BURN"
    if "bleed" in text:
        return "BLEEDING"
    if "choke" in text or "choking" in text:
        return "CHOKING"
    if any(kw in text for kw in CRITICAL_KEYWORDS):
        return "UNCONSCIOUS"
    if any(kw in text for kw in HIGH_KEYWORDS):
        return "CHEST_PAIN"
    return "GENERAL"
