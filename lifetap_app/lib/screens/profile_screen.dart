import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/mock_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 5C): replace MockData.demoPatient() with
    // ApiService.instance.getMyProfile(), and wire the edit button to
    // ApiService.instance.updateMyProfile().
    final patient = MockData.demoPatient();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Editing arrives in Stage 5C.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _InfoTile(label: 'Name', value: patient.name),
          _InfoTile(label: 'Age', value: patient.age?.toString() ?? '-'),
          _InfoTile(label: 'Gender', value: patient.gender),
          _InfoTile(label: 'Blood Group', value: patient.bloodGroup),
          _InfoTile(label: 'Known Conditions', value: patient.medicalHistory),
          _InfoTile(label: 'Phone', value: patient.phone),
          const Divider(height: AppSpacing.xl),
          const Text('Emergency Contact',
              style: TextStyle(fontWeight: FontWeight.bold)),
          _InfoTile(label: 'Name', value: patient.emergencyContactName),
          _InfoTile(label: 'Phone', value: patient.emergencyContactPhone),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}
