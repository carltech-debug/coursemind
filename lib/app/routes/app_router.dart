import 'dart:async';

import 'package:coursemind/features/auth/screens/login_screen.dart';
import 'package:coursemind/features/auth/screens/signup_screen.dart';
import 'package:coursemind/features/auth/screens/welcome_screen.dart';
import 'package:coursemind/features/auth/services/auth_service.dart';
import 'package:coursemind/features/home/screens/home_screen.dart';
import 'package:coursemind/features/home/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AuthRefreshNotifier extends ChangeNotifier {
  AuthRefreshNotifier(this._authService) {
    _subscription = _authService.authStateChanges.listen((_) {
      if (!isInitialized) {
        isInitialized = true;
      }

      notifyListeners();
    });
  }

  final AuthService _authService;
  late final StreamSubscription<User?> _subscription;

  bool isInitialized = false;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createAppRouter({
  required AuthService authService,
  required AuthRefreshNotifier authRefreshNotifier,
}) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authRefreshNotifier,
    redirect: (context, state) {
      final isLoggedIn = authService.currentUser != null;
      final isInitialized = authRefreshNotifier.isInitialized;
      final location = state.matchedLocation;

      if (!isInitialized) {
        return location == '/splash' ? null : '/splash';
      }

      if (location == '/splash') {
        return isLoggedIn ? '/home' : '/';
      }

      final isAuthRoute =
          location == '/' ||
          location == '/login' ||
          location == '/signup';

      if (!isLoggedIn && !isAuthRoute) {
        return '/';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}