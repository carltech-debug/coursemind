import 'package:coursemind/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CourseMind app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CourseMindApp());

    expect(find.byType(CourseMindApp), findsOneWidget);
  });
}