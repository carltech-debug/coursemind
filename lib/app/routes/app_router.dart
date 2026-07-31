import 'dart:async';

import 'package:coursemind/data/repositories/institution_account_repository.dart';
import 'package:coursemind/data/repositories/institution_profile_repository.dart';
import 'package:coursemind/data/repositories/user_profile_repository.dart';
import 'package:coursemind/features/auth/screens/login_screen.dart';
import 'package:coursemind/features/auth/screens/profile_setup_screen.dart';
import 'package:coursemind/features/auth/screens/signup_screen.dart';
import 'package:coursemind/features/auth/screens/welcome_screen.dart';
import 'package:coursemind/features/auth/services/auth_service.dart';
import 'package:coursemind/features/home/screens/home_screen.dart';
import 'package:coursemind/features/home/screens/splash_screen.dart';
import 'package:coursemind/features/institution/screens/institution_home_screen.dart';
import 'package:coursemind/features/institution/screens/institution_pending_screen.dart';
import 'package:coursemind/features/institution/screens/institution_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AuthRefreshNotifier extends ChangeNotifier {
  AuthRefreshNotifier(this._authService) {
    _subscription =
        _authService.authStateChanges.listen((_) {
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

final _profileRepository =
    UserProfileRepository();

final _institutionAccountRepository =
    InstitutionAccountRepository();

final _institutionProfileRepository =
    InstitutionProfileRepository();

GoRouter createAppRouter({
  required AuthService authService,
  required AuthRefreshNotifier authRefreshNotifier,
}) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authRefreshNotifier,
    redirect: (context, state) async {
      final isInitialized =
          authRefreshNotifier.isInitialized;

      final user = authService.currentUser;
      final location = state.matchedLocation;

      if (!isInitialized) {
        return location == '/splash'
            ? null
            : '/splash';
      }

      if (location == '/splash') {
        if (user == null) {
          return '/';
        }

        final studentProfile =
            await _profileRepository
                .getProfile(user.uid);

        if (studentProfile != null) {
          return '/home';
        }

        final institutionAccount =
            await _institutionAccountRepository
                .getAccount(user.uid);

        if (institutionAccount != null) {
          final institution =
              await _institutionProfileRepository
                  .getInstitution(
            institutionAccount.institutionId,
          );

          if (institution?.status == 'approved') {
            return '/institution-home';
          }

          return '/institution-pending';
        }

        return '/profile-setup';
      }

      if (user == null) {
        final publicRoutes = {
          '/',
          '/login',
          '/signup',
          '/institution-signup',
        };

        if (publicRoutes.contains(location)) {
          return null;
        }

        return '/';
      }

      final studentProfile =
          await _profileRepository
              .getProfile(user.uid);

      if (studentProfile != null) {
        if (location.startsWith('/institution')) {
          return '/home';
        }

        if (location == '/profile-setup' ||
            location == '/' ||
            location == '/login' ||
            location == '/signup' ||
            location == '/institution-signup') {
          return '/home';
        }

        return null;
      }

      final institutionAccount =
          await _institutionAccountRepository
              .getAccount(user.uid);

      if (institutionAccount != null) {
        final institution =
            await _institutionProfileRepository
                .getInstitution(
          institutionAccount.institutionId,
        );

        final isApproved =
            institution?.status == 'approved';

        if (isApproved &&
            location != '/institution-home') {
          if (!location.startsWith('/institution')) {
            return '/institution-home';
          }
        }

        if (!isApproved &&
            location != '/institution-pending') {
          return '/institution-pending';
        }

        return null;
      }

      if (location == '/profile-setup') {
        return null;
      }

      if (location == '/' ||
          location == '/login' ||
          location == '/signup') {
        return null;
      }

      return '/profile-setup';
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) =>
            const SignupScreen(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) =>
            const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/institution-signup',
        builder: (context, state) =>
            const InstitutionSignupScreen(),
      ),
      GoRoute(
        path: '/institution-pending',
        builder: (context, state) =>
            const InstitutionPendingScreen(),
      ),
      GoRoute(
        path: '/institution-home',
        builder: (context, state) =>
            const InstitutionHomeScreen(),
      ),
    ],
  );
}