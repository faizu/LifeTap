import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/mock_data.dart';

class ExpertsScreen extends StatelessWidget {
  const ExpertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 5D): replace with ApiService.instance -> GET /experts/
    final experts = MockData.experts();

    return Scaffold(
      appBar: AppBar(title: const Text('Experts')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: experts.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final e = experts[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    e.available ? AppColors.success : Colors.grey,
                child: const Icon(Icons.medical_services, color: Colors.white),
              ),
              title: Text(e.name),
              subtitle: Text(e.specialization.replaceAll('_', ' ')),
              trailing: Chip(
                label: Text(e.available ? 'Available' : 'Unavailable'),
                backgroundColor:
                    (e.available ? AppColors.success : Colors.grey)
                        .withOpacity(0.15),
              ),
            ),
          );
        },
      ),
    );
  }
}
