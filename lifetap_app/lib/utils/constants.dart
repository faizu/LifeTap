import 'package:flutter/material.dart';

/// App-wide constants. Kept in one place so Stage 5B+ only has to
/// change [apiBaseUrl] here, not hunt through every screen.
class AppConstants {
  AppConstants._();

  /// TODO (Stage 5B): point this at your Django server.
  /// - Android emulator talking to your laptop: http://10.0.2.2:8000/api
  /// - Real phone on same Wi-Fi as your laptop: http://<laptop-lan-ip>:8000/api
  static const String apiBaseUrl = 'http://10.0.2.2:8000/api';

  static const String appName = 'LifeTap';
}

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1565C0); // calm blue - trust
  static const Color emergency = Color(0xFFD32F2F); // red - urgent action
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color background = Color(0xFFF5F7FA);

  static Color forUrgency(String urgency) {
    switch (urgency.toUpperCase()) {
      case 'CRITICAL':
        return const Color(0xFFB71C1C);
      case 'HIGH':
        return emergency;
      case 'MEDIUM':
        return warning;
      case 'LOW':
        return success;
      default:
        return Colors.grey;
    }
  }
}

class AppSpacing {
  AppSpacing._();
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}
