import 'package:flutter_test/flutter_test.dart';
import 'package:coursemind/main.dart';

void main() {
  testWidgets('CourseMind app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CourseMindApp());

    expect(find.text('CourseMind'), findsOneWidget);
    expect(find.text('Firebase connected successfully!'), findsOneWidget);
  });
}