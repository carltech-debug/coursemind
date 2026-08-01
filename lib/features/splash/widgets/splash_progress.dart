// ======================================================
// COURSEMIND
// Splash Progress Widget
// ------------------------------------------------------
// File:
// splash_progress.dart
//
// Responsibility:
// Displays the loading message and animated progress
// indicator shown near the bottom of the splash screen.
//
// Contains no navigation or startup logic.
// ======================================================

import 'package:flutter/material.dart';

// ======================================================
// SPLASH PROGRESS WIDGET
// ======================================================

class SplashProgress extends StatelessWidget {
  const SplashProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ======================================================
          // LOADING LABEL
          // ======================================================

          const Text(
            'INITIALIZING LEARNING CORE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              color: Color(0xFF76777D),
            ),
          ),

          const SizedBox(height: 12),

          // ======================================================
          // PROGRESS BAR CONTAINER
          // ======================================================

          Container(
            height: 4,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E3E5),
              borderRadius: BorderRadius.circular(9999),
            ),

            // ======================================================
            // ANIMATED PROGRESS INDICATOR
            // ======================================================

            child: const CustomIndeterminateProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// CUSTOM INDETERMINATE PROGRESS INDICATOR
// ======================================================

class CustomIndeterminateProgressIndicator extends StatefulWidget {
  const CustomIndeterminateProgressIndicator({
    super.key,
  });

  @override
  State<CustomIndeterminateProgressIndicator> createState() =>
      _CustomIndeterminateProgressIndicatorState();
}

class _CustomIndeterminateProgressIndicatorState
    extends State<CustomIndeterminateProgressIndicator>
    with SingleTickerProviderStateMixin {

  // ======================================================
  // ANIMATION CONTROLLER
  // ======================================================

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ProgressPainter(
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

// ======================================================
// PROGRESS PAINTER
// ======================================================

class ProgressPainter extends CustomPainter {
  const ProgressPainter({
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF4B41E1)
      ..style = PaintingStyle.fill;

    final double left =
        size.width * (progress * 1.35 - 0.35);

    final double right =
        size.width * (progress * 1.90 - 0.90);

    if (left < size.width && right > 0) {
      final double startX =
          left.clamp(0.0, size.width);

      final double endX =
          right.clamp(0.0, size.width);

      if (startX < endX) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(
              startX,
              0,
              endX,
              size.height,
            ),
            const Radius.circular(9999),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant ProgressPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress;
  }
}