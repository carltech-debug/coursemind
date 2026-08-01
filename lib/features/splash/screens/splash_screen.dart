// ======================================================
// COURSEMIND
// Splash Screen
// ------------------------------------------------------
// File:
// splash_screen.dart
//
// Responsibility:
// Displays the CourseMind splash experience while the
// application initializes.
//
// This screen ONLY assembles the UI.
// Startup logic is handled by SplashService.
// ======================================================

import 'package:flutter/material.dart';

import '../painters/radial_glow_painter.dart';
import '../services/splash_service.dart';
import '../widgets/splash_footer.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_progress.dart';

// ======================================================
// SPLASH SCREEN
// ======================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  // ======================================================
  // SERVICES
  // ======================================================

  final SplashService _splashService = const SplashService();

  // ======================================================
  // ANIMATION CONTROLLERS
  // ======================================================

  late final AnimationController _animationController;

  late final Animation<double> _fadeAnimation;

  late final Animation<double> _scaleAnimation;

  // ======================================================
  // POINTER POSITION
  // ======================================================

  Offset _pointerPosition = Offset.zero;

  // ======================================================
  // INITIALIZATION
  // ======================================================

  @override
  void initState() {
    super.initState();

    _initializeAnimations();

    _startInitialization();
  }

  // ======================================================
  // INITIALIZE ANIMATIONS
  // ======================================================

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();
  }

  // ======================================================
  // START INITIALIZATION
  // ======================================================

  Future<void> _startInitialization() async {
    await _splashService.initialize();

    if (!mounted) return;

    // ======================================================
    // TO DO
    // Replace with GoRouter navigation later.
    // ======================================================

    // context.go('/welcome');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ======================================================
  // BUILD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),

      body: MouseRegion(

        // ==================================================
        // DESKTOP POINTER TRACKING
        // ==================================================

        onHover: (event) {
          setState(() {
            _pointerPosition = event.position;
          });
        },

        child: Stack(
          children: [

            // ==================================================
            // RADIAL GLOW BACKGROUND
            // ==================================================

            Positioned.fill(
              child: CustomPaint(
                painter: RadialGlowPainter(
                  pointerPosition:
                      _pointerPosition == Offset.zero
                          ? Offset(
                              screenSize.width / 2,
                              screenSize.height / 2,
                            )
                          : _pointerPosition,
                ),
              ),
            ),

            // ==================================================
            // CONTINUE IN PART 2
            // ==================================================
           // ==================================================
            // BACKGROUND IMAGE
            // ==================================================

            Positioned.fill(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Opacity(
                  opacity: 0.08,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida/AP1WRLshkMWJvsUhaZm0OaGXroy4yKUJyEXXnnWSbc0CTTVvjndXlVhG7oEamJQ5mnoRaQuNWOBSmEFWALOCUj95OYaHlZHDpj2uwruz7uK7EyTqAKyCPPdtiyV4nFtrIopvWjLVgUL33tGVYj33F5nBfOX4gG6Tgyldo5QdL9DcCiLJLy9oh-KvwoTIL-DDwIx3IjsePkfiUbKXOonI2NIeImCDBj6gpNNZFoErziB2prcaxesfprnSsI8Z6Kw',
                    fit: BoxFit.cover,
                    color: Colors.grey,
                    colorBlendMode: BlendMode.saturation,
                  ),
                ),
              ),
            ),

            // ==================================================
            // BRANDING SECTION
            // ==================================================

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: SplashLogo(
                  scaleAnimation: _scaleAnimation,
                  fadeAnimation: _fadeAnimation,
                ),
              ),
            ),

            // ==================================================
            // LOADING SECTION
            // ==================================================

            const Positioned(
              left: 0,
              right: 0,
              bottom: 64,
              child: Center(
                child: SplashProgress(),
              ),
            ),

            // ==================================================
            // FOOTER SECTION
            // ==================================================

            const Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Center(
                child: SplashFooter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}