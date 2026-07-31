import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../auth/services/auth_service.dart';

class InstitutionPendingScreen extends StatelessWidget {
  const InstitutionPendingScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await AuthService().signOut();

    if (!context.mounted) {
      return;
    }

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.pending_actions_outlined,
                  size: 72,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Registration Submitted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your institution registration is currently under review. You will be able to manage programmes and courses once the institution is approved.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () => _signOut(context),
                  child: const Text(
                    'Return to CourseMind',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}