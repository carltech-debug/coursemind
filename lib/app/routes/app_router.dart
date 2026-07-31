import 'dart:async';

import 'package:coursemind/data/repositories/user_profile_repository.dart';
import 'package:coursemind/features/auth/screens/login_screen.dart';
import 'package:coursemind/features/auth/screens/profile_setup_screen.dart';
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

final _profileRepository = UserProfileRepository();

GoRouter createAppRouter({
  required AuthService authService,
  required AuthRefreshNotifier authRefreshNotifier,
}) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authRefreshNotifier,
    redirect: (context, state) async {
      final isInitialized = authRefreshNotifier.isInitialized;
      final user = authService.currentUser;
      final isLoggedIn = user != null;
      final location = state.matchedLocation;

      // Wait until Firebase gives us the first authentication state.
      if (!isInitialized) {
        return location == '/splash' ? null : '/splash';
      }

      // Leave the splash screen once the auth state is known.
      if (location == '/splash') {
        if (!isLoggedIn) {
          return '/';
        }
      }

      // Logged-out users can only access public authentication routes.
      if (!isLoggedIn) {
        final isPublicRoute =
            location == '/' ||
            location == '/login' ||
            location == '/signup';

        if (isPublicRoute) {
          return null;
        }

        return '/';
      }

      // From this point onward, the user is authenticated.
      final profile = await _profileRepository.getProfile(user.uid);

      final hasCompletedProfile = profile != null;

      // Authenticated but profile not completed.
      if (!hasCompletedProfile) {
        if (location == '/profile-setup') {
          return null;
        }

        return '/profile-setup';
      }

      // Authenticated and profile completed.
      if (location == '/splash' ||
          location == '/' ||
          location == '/login' ||
          location == '/signup' ||
          location == '/profile-setup') {
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
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}