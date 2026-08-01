class AppRoutes {
  // Batch 1: Entry & Auth
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String roleSelection = '/role-selection';
  static const String profileSetup = '/profile-setup';

  // Batch 2: Dashboards
  static const String studentDashboard = '/student-dashboard';
  static const String institutionDashboard = '/institution-dashboard';

  // Batch 3: Academic Module
  static const String courseDetails = '/course/:id';
  static const String topicBreakdown = '/topic/:id';
  static const String materialViewer = '/material/:id';

  // Batch 4: Interactive Features
  static const String aiTutor = '/ai-tutor';
  static const String quizEngine = '/quiz';
  static const String progressTracking = '/progress';
}