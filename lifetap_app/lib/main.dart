import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/emergency_screen.dart';
import 'screens/result_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/experts_screen.dart';
import 'screens/guides_screen.dart';
import 'screens/my_cases_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const LifeTapApp());
}

class LifeTapApp extends StatelessWidget {
  const LifeTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/emergency': (context) => const EmergencyScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/experts': (context) => const ExpertsScreen(),
        '/guides': (context) => const GuidesScreen(),
        '/my-cases': (context) => const MyCasesScreen(),
        // '/result' is pushed manually with arguments (see emergency_screen.dart)
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/result') {
          final result = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => ResultScreen(result: result as dynamic),
          );
        }
        return null;
      },
    );
  }
}
