import 'package:flutter/material.dart';

import '../../auth/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CourseMind'),
      ),
      body: Center(
        child: Text(
          'Welcome${user?.email == null ? '' : ', ${user!.email}'}!',
        ),
      ),
    );
  }
}