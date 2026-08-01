import 'package:flutter/material.dart';
import 'package:coursemind/app/routes/app_router.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CourseMindApp());
}

class CourseMindApp extends StatelessWidget {
  const CourseMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CourseMind',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}