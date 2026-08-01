// ======================================================
// COURSEMIND
// Welcome Placeholder Screen
// ------------------------------------------------------
// Responsibility:
// Temporary screen used until the real Welcome Screen
// is implemented.
// ======================================================

import 'package:flutter/material.dart';

class WelcomePlaceholderScreen extends StatelessWidget {
  const WelcomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome Screen\n(Coming Soon)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}