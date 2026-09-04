import '../models/expert.dart';
import '../models/guide.dart';
import '../models/emergency_case.dart';
import '../models/patient.dart';

/// Dummy data for Stage 5A (UI-only milestone). Every value here
/// mirrors the shape the real API already returns (see
/// emergencies/serializers.py on the backend), so swapping this out
/// for real network calls in Stage 5B-D should not require changing
/// any screen's layout code — only where the data comes from.
class MockData {
  MockData._();

  static Patient demoPatient() => Patient(
        name: 'Demo Patient',
        age: 45,
        gender: 'MALE',
        bloodGroup: 'O+',
        medicalHistory: 'None recorded',
        emergencyContactName: 'Ahmed (Brother)',
        emergencyContactPhone: '9876543210',
        phone: '9998887777',
      );

  static List<Expert> experts() => [
        Expert(
          id: 1,
          name: 'Dr. Kumar (Demo)',
          specialization: 'EMERGENCY_MEDICINE',
          phone: '9999999001',
          latitude: 12.9716,
          longitude: 77.5946,
          available: true,
        ),
        Expert(
          id: 2,
          name: 'Dr. Rao (Demo)',
          specialization: 'CARDIOLOGY',
          phone: '9999999002',
          latitude: 12.9352,
          longitude: 77.6245,
          available: false,
        ),
        Expert(
          id: 3,
          name: 'Demo Expert (General)',
          specialization: 'GENERAL',
          phone: '9999999003',
          latitude: 13.0100,
          longitude: 77.6000,
          available: true,
        ),
      ];

  static List<EmergencyGuideStep> guideFor(String category) {
    final all = <EmergencyGuideStep>[
      EmergencyGuideStep(
          id: 1,
          category: 'BURN',
          title: 'Move from heat source',
          stepNumber: 1,
          instruction: 'Move the person away from the source of heat.'),
      EmergencyGuideStep(
          id: 2,
          category: 'BURN',
          title: 'Cool the area',
          stepNumber: 2,
          instruction: 'Cool the burnt area under cool running water.'),
      EmergencyGuideStep(
          id: 3,
          category: 'BURN',
          title: 'Seek help',
          stepNumber: 3,
          instruction: 'Seek appropriate emergency medical assistance.'),
      EmergencyGuideStep(
          id: 4,
          category: 'GENERAL',
          title: 'Stay calm',
          stepNumber: 1,
          instruction: 'Stay calm and keep the patient still.'),
      EmergencyGuideStep(
          id: 5,
          category: 'GENERAL',
          title: 'Call for real help',
          stepNumber: 2,
          instruction: 'Call local emergency services immediately.'),
    ];
    final matches = all.where((g) => g.category == category).toList();
    return matches.isNotEmpty
        ? matches
        : all.where((g) => g.category == 'GENERAL').toList();
  }

  static List<EmergencyCase> myCases() => [
        EmergencyCase(
          id: 1001,
          symptoms: 'Severe chest pain and difficulty breathing',
          latitude: 12.9716,
          longitude: 77.5946,
          urgency: 'HIGH',
          status: 'ROUTED',
          createdAt: '2026-08-30T10:31:00Z',
          expert: experts().first,
        ),
        EmergencyCase(
          id: 1002,
          symptoms: 'Minor cut on finger',
          latitude: 12.9716,
          longitude: 77.5946,
          urgency: 'LOW',
          status: 'CLOSED',
          createdAt: '2026-08-28T09:10:00Z',
        ),
      ];

  /// Simulates what POST /api/emergencies/ would return, using the
  /// SAME simple keyword rules as the real backend triage.py, so the
  /// demo behaves consistently once real API calls replace this.
  static EmergencyResult classify(String symptoms) {
    final text = symptoms.toLowerCase();
    String urgency;
    if (text.contains('unconscious') || text.contains('not breathing')) {
      urgency = 'CRITICAL';
    } else if (text.contains('chest pain') ||
        text.contains('breathing') ||
        text.contains('bleeding')) {
      urgency = 'HIGH';
    } else if (text.contains('minor') || text.contains('mild')) {
      urgency = 'LOW';
    } else {
      urgency = 'MEDIUM';
    }

    final available = experts().where((e) => e.available).toList();
    final expert = available.isNotEmpty ? available.first : null;

    return EmergencyResult(
      caseId: 9999,
      urgency: urgency,
      status: expert != null ? 'ROUTED' : 'FALLBACK',
      expertAvailable: expert != null,
      expert: expert,
      fallbackAvailable: expert == null,
      fallbackGuide: expert == null ? guideFor('GENERAL') : [],
      disclaimer:
          'LifeTap is an educational prototype. This is NOT a medical diagnosis. '
          'If this is a real emergency, contact local emergency services immediately.',
    );
  }
}
