// ======================================================
// COURSEMIND
// Splash Footer Widget
// ------------------------------------------------------
// File:
// splash_footer.dart
//
// Responsibility:
// Displays the security footer shown at the bottom
// of the CourseMind splash screen.
//
// Contains branding only.
// No navigation.
// No business logic.
// ======================================================

import 'package:flutter/material.dart';

// ======================================================
// SPLASH FOOTER WIDGET
// ======================================================

class SplashFooter extends StatelessWidget {
  const SplashFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ======================================================
          // SECURITY ICON
          // ======================================================

          const Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: Colors.black,
          ),

          const SizedBox(width: 8),

          // ======================================================
          // SECURITY LABEL
          // ======================================================

          const Text(
            'SECURED BY COURSEMIND',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.4,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}