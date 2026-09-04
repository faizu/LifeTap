import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO (Stage 5B): check stored JWT here; if valid, skip straight
    // to '/home' instead of always going to '/login'.
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.health_and_safety, size: 84, color: Colors.white),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.appName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Educational emergency-assistance prototype',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: AppSpacing.xl),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
