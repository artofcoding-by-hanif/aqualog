// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';

import 'package:aqualog/app.dart';

void main() {
  testWidgets('App should render without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify the app renders
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
