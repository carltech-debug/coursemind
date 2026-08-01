// ======================================================
// COURSEMIND
// Application Widget
// ------------------------------------------------------
// File:
// app.dart
//
// Responsibility:
// Configures the root MaterialApp for CourseMind.
//
// This file is responsible ONLY for:
// • Theme
// • Router
// • Debug Banner
//
// It contains no business logic.
// ======================================================

import 'package:flutter/material.dart';

import 'routes/app_router.dart';

// ======================================================
// COURSEMIND APPLICATION
// ======================================================

class CourseMindApp extends StatelessWidget {
  const CourseMindApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      // ==================================================
      // APPLICATION TITLE
      // ==================================================

      title: 'CourseMind',

      // ==================================================
      // DEBUG BANNER
      // ==================================================

      debugShowCheckedModeBanner: false,

      // ==================================================
      // APPLICATION THEME
      // ==================================================

      theme: ThemeData(
        useMaterial3: true,
      ),

      // ==================================================
      // APPLICATION ROUTER
      // ==================================================

      routerConfig: AppRouter.router,
    );
  }
}