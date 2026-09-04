import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/mock_data.dart';

class MyCasesScreen extends StatelessWidget {
  const MyCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 5D): replace with ApiService.instance -> GET /emergencies/
    final cases = MockData.myCases();

    return Scaffold(
      appBar: AppBar(title: const Text('My Emergency Cases')),
      body: cases.isEmpty
          ? const Center(child: Text('No cases yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: cases.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) {
                final c = cases[i];
                final color = AppColors.forUrgency(c.urgency);
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withOpacity(0.15),
                      child: Icon(Icons.warning_amber_rounded, color: color),
                    ),
                    title: Text('Case #${c.id} — ${c.urgency}'),
                    subtitle: Text(
                      '${c.symptoms}\nStatus: ${c.status}'
                      '${c.expert != null ? ' · ${c.expert!.name}' : ''}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
