class Expert {
  final int id;
  final String name;
  final String specialization;
  final String phone;
  final double latitude;
  final double longitude;
  final bool available;

  Expert({
    required this.id,
    required this.name,
    required this.specialization,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.available,
  });

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      id: json['id'] as int,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      available: json['available'] as bool,
    );
  }
}
