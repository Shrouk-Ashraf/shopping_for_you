import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/routing/routes.dart';
import 'package:four_you_ecommerce/modules/authentication/cubit/auth_cubit.dart';
import 'package:four_you_ecommerce/modules/authentication/login_screen.dart';
import 'package:four_you_ecommerce/modules/authentication/signup_screen.dart';
import 'package:four_you_ecommerce/modules/layout/home_layout.dart';
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
      ),
      GoRoute(
        path: '/login',
        name: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        name: Routes.signup,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider.value(
            value: state.extra as AuthCubit,
            child: const SignupScreen(),
          );
        },
      ),
      GoRoute(
        path: '/home',
        name: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider.value(
            value: state.extra as AuthCubit,
            child: const HomeLayout(),
          );
        },
      ),
    ],
  );
}
