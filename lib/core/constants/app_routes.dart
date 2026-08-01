// ======================================================
// COURSEMIND
// Application Routes
// ------------------------------------------------------
// File:
// app_routes.dart
//
// Responsibility:
// Centralizes every route used in the application.
// No route strings should be hardcoded anywhere else.
// ======================================================

class AppRoutes {
  AppRoutes._();

  // ======================================================
  // PUBLIC ROUTES
  // ======================================================

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // ======================================================
  // STUDENT ROUTES
  // ======================================================

  static const String profileSetup = '/profile-setup';
  static const String institutionSelection = '/institution-selection';
  static const String studentHome = '/student-home';
  static const String courseDetail = '/course-detail';
  static const String topicWorkspace = '/topic-workspace';
  static const String materialViewer = '/material-viewer';
  static const String aiTutor = '/ai-tutor';

  // ======================================================
  // INSTITUTION ROUTES
  // ======================================================

  static const String institutionRegistration =
      '/institution-registration';

  static const String institutionHome =
      '/institution-home';

  // ======================================================
  // SETTINGS
  // ======================================================

  static const String settings = '/settings';
}