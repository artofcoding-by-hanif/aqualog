import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aqualog/core/theme/app_theme.dart';
import 'package:aqualog/features/app/presentation/splash/splash_screen.dart';

void main() {
  testWidgets('Splash screen shows branding and completes after delay', (
    WidgetTester tester,
  ) async {
    var completed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: SplashScreen(onComplete: () => completed = true),
      ),
    );

    expect(find.text('TankMind'), findsOneWidget);
    expect(find.text('Smarter care for healthier aquariums.'), findsOneWidget);
    expect(completed, isFalse);

    // Splash hands off to the next screen after 2500ms
    await tester.pump(const Duration(milliseconds: 2500));
    expect(completed, isTrue);

    // Let the logo animation finish so no timers are left pending
    await tester.pumpAndSettle();
  });
}
