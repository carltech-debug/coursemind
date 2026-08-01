// ======================================================
// COURSEMIND
// Login Placeholder Screen
// ------------------------------------------------------
// Responsibility:
// Temporary screen used until the real Login Screen
// is implemented.
// ======================================================

import 'package:flutter/material.dart';

class LoginPlaceholderScreen extends StatelessWidget {
  const LoginPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Login Screen\n(Coming Soon)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}