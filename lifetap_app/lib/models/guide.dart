class EmergencyGuideStep {
  final int id;
  final String category;
  final String title;
  final int stepNumber;
  final String instruction;

  EmergencyGuideStep({
    required this.id,
    required this.category,
    required this.title,
    required this.stepNumber,
    required this.instruction,
  });

  factory EmergencyGuideStep.fromJson(Map<String, dynamic> json) {
    return EmergencyGuideStep(
      id: json['id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      stepNumber: json['step_number'] as int,
      instruction: json['instruction'] as String,
    );
  }
}
