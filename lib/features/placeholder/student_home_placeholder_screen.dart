// ======================================================
// COURSEMIND
// Student Home Placeholder Screen
// ------------------------------------------------------
// Responsibility:
// Temporary screen used until the real Student Home
// dashboard is implemented.
// ======================================================

import 'package:flutter/material.dart';

class StudentHomePlaceholderScreen extends StatelessWidget {
  const StudentHomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Student Home\n(Coming Soon)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}