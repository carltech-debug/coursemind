import 'package:coursemind/app/routes/app_router.dart';
import 'package:coursemind/app/theme/app_theme.dart';
import 'package:coursemind/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseMindApp extends StatefulWidget {
  const CourseMindApp({super.key});

  @override
  State<CourseMindApp> createState() => _CourseMindAppState();
}

class _CourseMindAppState extends State<CourseMindApp> {
  late final AuthService _authService;
  late final AuthRefreshNotifier _authRefreshNotifier;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _authService = AuthService();

    _authRefreshNotifier = AuthRefreshNotifier(
      _authService,
    );

    _router = createAppRouter(
      authService: _authService,
      authRefreshNotifier: _authRefreshNotifier,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _authRefreshNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CourseMind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}