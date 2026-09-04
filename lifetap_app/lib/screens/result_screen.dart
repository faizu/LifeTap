import 'package:flutter/material.dart';

import '../models/emergency_case.dart';
import '../utils/constants.dart';

class ResultScreen extends StatelessWidget {
  final EmergencyResult result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final urgencyColor = AppColors.forUrgency(result.urgency);

    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: urgencyColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: urgencyColor, width: 1.5),
                ),
                child: Column(
                  children: [
                    Icon(Icons.priority_high, color: urgencyColor, size: 40),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${result.urgency} PRIORITY',
                      style: TextStyle(
                        color: urgencyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text('Case #${result.caseId} · ${result.status}'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (result.expertAvailable && result.expert != null) ...[
                const Text('Expert Available',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(result.expert!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(result.expert!.specialization
                            .replaceAll('_', ' ')),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () {
                                  // TODO (Stage 5D+): use url_launcher to
                                  // open the phone dialer with
                                  // result.expert!.phone. Never auto-dial.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Would open dialer for ${result.expert!.phone} (demo).'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.call),
                                label: const Text('CALL EXPERT'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                const Text('No Expert Available',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: AppSpacing.sm),
                const Text('Showing the fallback emergency guide instead:'),
                const SizedBox(height: AppSpacing.sm),
                ...result.fallbackGuide.map(
                  (step) => Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${step.stepNumber}')),
                      title: Text(step.title),
                      subtitle: Text(step.instruction),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO (Stage 5C): share location via the patient's
                  // saved emergency contact (share_plus package).
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Would share location with emergency contact (demo).')),
                  );
                },
                icon: const Icon(Icons.share_location),
                label: const Text('Share Location with Emergency Contact'),
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  result.disclaimer,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextButton(
                onPressed: () => Navigator.popUntil(
                    context, ModalRoute.withName('/home')),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
