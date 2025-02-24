import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/theme/app_theme.dart';
import 'package:four_you_ecommerce/modules/onboarding/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping For You',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
