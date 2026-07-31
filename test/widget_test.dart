import 'package:coursemind/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Login screen displays core controls',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(
        find.text('Welcome back'),
        findsOneWidget,
      );

      expect(
        find.text('Email address'),
        findsOneWidget,
      );

      expect(
        find.text('Password'),
        findsOneWidget,
      );

      expect(
        find.text('Log In'),
        findsOneWidget,
      );

      expect(
        find.text("Don't have an account?"),
        findsOneWidget,
      );
    },
  );
}