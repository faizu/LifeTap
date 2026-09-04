from django.db import models


class EmergencyGuide(models.Model):
    """Matches the `emergency_guide` table in the project's ER design.

    IMPORTANT: content here should be reviewed by a qualified
    professional before real use — it must not be invented ad hoc by
    students and presented as medical guidance. For the prototype,
    seed this from a reputable public first-aid source and cite it.
    """

    category = models.CharField(
        max_length=50,
        help_text="e.g. CHEST_PAIN, BURN, BLEEDING, UNCONSCIOUS, CHOKING",
    )
    title = models.CharField(max_length=150)
    step_number = models.PositiveSmallIntegerField()
    instruction = models.TextField()

    class Meta:
        ordering = ["category", "step_number"]
        unique_together = ["category", "step_number"]

    def __str__(self):
        return f"{self.category} step {self.step_number}: {self.title}"
