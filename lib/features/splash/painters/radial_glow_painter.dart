// ======================================================
// COURSEMIND
// Radial Glow Painter
// ------------------------------------------------------
// File:
// radial_glow_painter.dart
//
// Responsibility:
// Paints the interactive radial glow that appears behind
// the CourseMind splash screen.
// ======================================================

import 'package:flutter/material.dart';

// ======================================================
// RADIAL GLOW PAINTER
// ======================================================
//
// This painter draws a soft radial gradient that follows
// the mouse pointer on desktop/web.
//
// On mobile devices the glow remains centered.
// ======================================================

class RadialGlowPainter extends CustomPainter {
  // ======================================================
  // POINTER POSITION
  // ======================================================

  final Offset pointerPosition;

  const RadialGlowPainter({
    required this.pointerPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ======================================================
    // RADIAL GLOW PAINT
    // ======================================================

    final Paint glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF4B41E1).withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [
          0.0,
          0.65,
        ],
      ).createShader(
        Rect.fromCircle(
          center: pointerPosition,
          radius: size.width * 0.55,
        ),
      );

    // ======================================================
    // DRAW FULL SCREEN GLOW
    // ======================================================

    canvas.drawRect(
      Offset.zero & size,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant RadialGlowPainter oldDelegate,
  ) {
    return oldDelegate.pointerPosition != pointerPosition;
  }
}