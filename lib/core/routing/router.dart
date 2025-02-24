import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/routing/routes.dart';
import 'package:four_you_ecommerce/modules/authentication/login_screen.dart';
import 'package:four_you_ecommerce/modules/onboarding/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final bool isFirstTime;
  AppRouter(this.isFirstTime);

  late final GoRouter router = GoRouter(
    initialLocation: isFirstTime == true ? '/' : '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: Routes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/login',
            name: Routes.login,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
          ),
        ],
      ),
    ],
  );
}
