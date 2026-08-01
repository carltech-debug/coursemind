// ======================================================
// COURSEMIND
// Application Router
// ------------------------------------------------------
// File:
// app_router.dart
//
// Responsibility:
// Registers every application route.
//
// This file contains ONLY routing.
// No business logic.
// No Firebase.
// ======================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';

import '../../features/splash/screens/splash_screen.dart';

import '../../features/placeholder/welcome_placeholder_screen.dart';
import '../../features/placeholder/login_placeholder_screen.dart';
import '../../features/placeholder/signup_placeholder_screen.dart';
import '../../features/placeholder/student_home_placeholder_screen.dart';

// ======================================================
// APPLICATION ROUTER
// ======================================================

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(

    // ==================================================
    // INITIAL ROUTE
    // ==================================================

    initialLocation: AppRoutes.splash,

    // ==================================================
    // APPLICATION ROUTES
    // ==================================================

    routes: [

      // ==================================================
      // SPLASH SCREEN
      // ==================================================

      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) =>
            const SplashScreen(),
      ),

      // ==================================================
      // WELCOME SCREEN
      // ==================================================

      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) =>
            const WelcomePlaceholderScreen(),
      ),

      // ==================================================
      // LOGIN SCREEN
      // ==================================================

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) =>
            const LoginPlaceholderScreen(),
      ),

      // ==================================================
      // SIGNUP SCREEN
      // ==================================================

      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) =>
            const SignupPlaceholderScreen(),
      ),

      // ==================================================
      // STUDENT HOME
      // ==================================================

      GoRoute(
        path: AppRoutes.studentHome,
        builder: (context, state) =>
            const StudentHomePlaceholderScreen(),
      ),
    ],

    // ==================================================
    // UNKNOWN ROUTE
    // ==================================================

    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text(
            'Route Not Found\n\n${state.uri}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    },
  );
}