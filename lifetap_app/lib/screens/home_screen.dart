import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/emergency_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () {
              // TODO (Stage 5B): clear stored tokens here.
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'This is an educational prototype, not a medical device. '
                'In a real emergency, contact local emergency services.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: AppSpacing.lg),
              EmergencyButton(
                onPressed: () => Navigator.pushNamed(context, '/emergency'),
              ),
              const SizedBox(height: AppSpacing.xl),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.1,
                children: [
                  _MenuCard(
                    icon: Icons.person,
                    label: 'My Profile',
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                  ),
                  _MenuCard(
                    icon: Icons.medical_services,
                    label: 'Experts',
                    onTap: () => Navigator.pushNamed(context, '/experts'),
                  ),
                  _MenuCard(
                    icon: Icons.menu_book,
                    label: 'Emergency Guides',
                    onTap: () => Navigator.pushNamed(context, '/guides'),
                  ),
                  _MenuCard(
                    icon: Icons.history,
                    label: 'My Emergency Cases',
                    onTap: () => Navigator.pushNamed(context, '/my-cases'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: AppColors.primary),
            const SizedBox(height: AppSpacing.sm),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
