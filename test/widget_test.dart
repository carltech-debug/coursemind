import 'package:coursemind/features/auth/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Welcome screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomeScreen(),
      ),
    );

    expect(find.text('CourseMind'), findsOneWidget);

    expect(
      find.text(
        'Your courses. Your materials. Your learning companion.',
      ),
      findsOneWidget,
    );
  });
}