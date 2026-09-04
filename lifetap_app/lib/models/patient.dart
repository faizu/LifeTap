class Patient {
  final String name;
  final int? age;
  final String gender;
  final String bloodGroup;
  final String medicalHistory;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String phone;

  Patient({
    required this.name,
    this.age,
    this.gender = 'UNSPECIFIED',
    this.bloodGroup = '',
    this.medicalHistory = '',
    this.emergencyContactName = '',
    this.emergencyContactPhone = '',
    this.phone = '',
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'] as String? ?? '',
      age: json['age'] as int?,
      gender: json['gender'] as String? ?? 'UNSPECIFIED',
      bloodGroup: json['blood_group'] as String? ?? '',
      medicalHistory: json['medical_history'] as String? ?? '',
      emergencyContactName: json['emergency_contact_name'] as String? ?? '',
      emergencyContactPhone: json['emergency_contact_phone'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'gender': gender,
        'blood_group': bloodGroup,
        'medical_history': medicalHistory,
        'emergency_contact_name': emergencyContactName,
        'emergency_contact_phone': emergencyContactPhone,
        'phone': phone,
      };
}
