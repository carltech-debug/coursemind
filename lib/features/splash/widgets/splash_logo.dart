// ======================================================
// COURSEMIND
// Splash Logo Widget
// ------------------------------------------------------
// File:
// splash_logo.dart
//
// Responsibility:
// Displays the CourseMind logo, application name,
// and tagline during the splash experience.
//
// This widget contains ONLY branding.
// No navigation.
// No business logic.
// ======================================================

import 'package:flutter/material.dart';

// ======================================================
// SPLASH LOGO WIDGET
// ======================================================

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
    required this.scaleAnimation,
    required this.fadeAnimation,
  });

  // ======================================================
  // ENTRANCE ANIMATIONS
  // ======================================================

  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // ======================================================
            // COURSEMIND LOGO
            // ======================================================

            Container(
              width: 140,
              height: 140,
              margin: const EdgeInsets.only(bottom: 24),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBnWyx3WG3XNXgzPPEbQo8_HEueigoow5ICoOT3lMBmYdxwXat6Yn6vTsDo8GfEyCz5IzeNflvZNojtZAwwmM8LwPLr19AV0YcDrj1m8k-WTwHvboQT_J5YgNTk_Fu23Ppj1A1lb-hJGHno9Okk2__M2Us2slzxbgzDrRzlyV5ptUAiLe4_lXvJ1i1RhK1UDRmqLB2SJIptuQDbhgQ3x5oS5zQ9tAsBpbG7h7tx29jmzbWR_YUGB1Co2xwund_DHlv7mQ',
                fit: BoxFit.contain,
              ),
            ),

            // ======================================================
            // APPLICATION NAME
            // ======================================================

            const Text(
              'CourseMind',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.96,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // ======================================================
            // APPLICATION TAGLINE
            // ======================================================

            const Text(
              'Learn Smarter. Study Better.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF45464D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}