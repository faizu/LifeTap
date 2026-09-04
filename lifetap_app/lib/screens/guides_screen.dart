import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/mock_data.dart';

class GuidesScreen extends StatefulWidget {
  const GuidesScreen({super.key});

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  String _category = 'GENERAL';
  static const _categories = ['GENERAL', 'BURN', 'BLEEDING', 'CHEST_PAIN'];

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 5D): replace with ApiService.instance -> GET /guides/<category>/
    final steps = MockData.guideFor(_category);

    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Guides')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Wrap(
              spacing: AppSpacing.sm,
              children: _categories.map((c) {
                final selected = c == _category;
                return ChoiceChip(
                  label: Text(c.replaceAll('_', ' ')),
                  selected: selected,
                  onSelected: (_) => setState(() => _category = c),
                );
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Demo content only — must be reviewed by a qualified '
              'professional before real use.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: steps.length,
              itemBuilder: (context, i) {
                final step = steps[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${step.stepNumber}')),
                    title: Text(step.title),
                    subtitle: Text(step.instruction),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
