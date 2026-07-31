import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'CourseMind',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your courses. Your materials. Your learning companion.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),

              // Student: Create account
              FilledButton(
                onPressed: () {
                  context.push('/signup');
                },
                child: const Text('Get Started'),
              ),

              const SizedBox(height: 12),

              // Student: Existing account
              OutlinedButton(
                onPressed: () {
                  context.push('/login');
                },
                child: const Text(
                  'I already have an account',
                ),
              ),

              const SizedBox(height: 24),

              // Institution registration
              TextButton(
                onPressed: () {
                  context.push('/institution-signup');
                },
                child: const Text(
                  'Register your institution',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}