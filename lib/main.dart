import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/theme/app_theme.dart';
import 'package:four_you_ecommerce/modules/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For You',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const OnboardingScreen(),
    );
  }
}
