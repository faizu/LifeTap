import 'expert.dart';
import 'guide.dart';

class EmergencyCase {
  final int id;
  final String symptoms;
  final double latitude;
  final double longitude;
  final String urgency;
  final String status;
  final Expert? expert;
  final String createdAt;

  EmergencyCase({
    required this.id,
    required this.symptoms,
    required this.latitude,
    required this.longitude,
    required this.urgency,
    required this.status,
    required this.createdAt,
    this.expert,
  });

  factory EmergencyCase.fromJson(Map<String, dynamic> json) {
    return EmergencyCase(
      id: json['id'] as int,
      symptoms: json['symptoms'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      urgency: json['urgency'] as String,
      status: json['status'] as String,
      createdAt: json['created_at'] as String? ?? '',
      expert: json['expert'] != null
          ? Expert.fromJson(json['expert'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Shape returned right after POST /api/emergencies/
/// (matches EmergencyResultSerializer on the backend).
class EmergencyResult {
  final int caseId;
  final String urgency;
  final String status;
  final bool expertAvailable;
  final Expert? expert;
  final bool fallbackAvailable;
  final List<EmergencyGuideStep> fallbackGuide;
  final String disclaimer;

  EmergencyResult({
    required this.caseId,
    required this.urgency,
    required this.status,
    required this.expertAvailable,
    required this.fallbackAvailable,
    required this.fallbackGuide,
    required this.disclaimer,
    this.expert,
  });

  factory EmergencyResult.fromJson(Map<String, dynamic> json) {
    return EmergencyResult(
      caseId: json['case_id'] as int,
      urgency: json['urgency'] as String,
      status: json['status'] as String,
      expertAvailable: json['expert_available'] as bool,
      expert: json['expert'] != null
          ? Expert.fromJson(json['expert'] as Map<String, dynamic>)
          : null,
      fallbackAvailable: json['fallback_available'] as bool,
      fallbackGuide: (json['fallback_guide'] as List<dynamic>? ?? [])
          .map((e) => EmergencyGuideStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      disclaimer: json['disclaimer'] as String? ?? '',
    );
  }
}
