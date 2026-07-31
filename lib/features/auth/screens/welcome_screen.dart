import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: SafeArea(
        child: isWide
            ? _DesktopWelcome()
            : _MobileWelcome(),
      ),
    );
  }
}

class _DesktopWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            color: const Color(0xFF0F172A),
            padding: const EdgeInsets.all(64),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const _BrandMark(
                  light: true,
                ),
                const SizedBox(height: 80),
                const Text(
                  'Next Gen Learning',
                  style: TextStyle(
                    color: Color(0xFFA5B4FC),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Learn smarter.\nStudy better.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Your courses, materials, progress, and AI learning companion — all in one place.',
                  style: TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    _TrustChip(
                      icon: Icons.verified_outlined,
                      text: 'Academic Excellence',
                    ),
                    const SizedBox(width: 12),
                    _TrustChip(
                      icon: Icons.auto_awesome,
                      text: 'AI Powered',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(64),
            child: _WelcomeActions(),
          ),
        ),
      ],
    );
  }
}

class _MobileWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        40,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          const _BrandMark(),
          const SizedBox(height: 48),
          const Text(
            'Next Gen Learning',
            style: TextStyle(
              color: Color(0xFF4B41E1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Learn smarter.\nStudy better.',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your courses, materials, progress, and AI learning companion — all in one place.',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFF45464D),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 36),
          _WelcomeActions(),
        ],
      ),
    );
  }
}

class _WelcomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFEDEBFF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF4B41E1),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Tutor',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ready to assist your learning.',
                      style: TextStyle(
                        color: Color(0xFF45464D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () {
            context.push('/signup');
          },
          child: const Text('Get Started'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            context.push('/login');
          },
          child: const Text(
            'I already have an account',
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {
            context.push('/institution-signup');
          },
          icon: const Icon(
            Icons.open_in_new,
            size: 16,
          ),
          label: const Text(
            'Register your institution',
          ),
        ),
        const SizedBox(height: 32),
        const Center(
          child: Text(
            'Engineered for academic excellence.',
            style: TextStyle(
              color: Color(0xFF76777D),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({
    this.light = false,
  });

  final bool light;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: light
                ? Colors.white
                : const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.school,
            size: 22,
            color: light
                ? const Color(0xFF0F172A)
                : Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'CourseMind',
          style: TextStyle(
            color: light
                ? Colors.white
                : const Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.08,
        ),
        borderRadius:
            BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFFA5B4FC),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}