import 'package:aqualog/features/subscription/presentation/controllers/subscription_providers.dart';
import 'package:aqualog/features/subscription/presentation/paywall_screen.dart';
import 'package:aqualog/features/water_parameters/domain/entities/water_parameter_log.dart';
import 'package:aqualog/features/water_parameters/presentation/controllers/water_parameter_log_provider.dart';
import 'package:aqualog/features/water_parameters/presentation/parameter_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final now = DateTime.now();
  final logs = [
    for (final days in [1, 10, 25, 60, 200])
      WaterParameterLogEntity(
        tankId: 1,
        measuredAt: now.subtract(Duration(days: days)),
        ph: 7.0,
        nitratePpm: 15,
      ),
  ];

  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<void> pumpChart(WidgetTester tester, {required bool premium}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          waterParameterLogsForTankStreamProvider(
            1,
          ).overrideWith((ref) => Stream.value(logs)),
          isPremiumProvider.overrideWithValue(premium),
          // Keep the paywall offline in tests
          currentOfferingProvider.overrideWith(
            (ref) async => null as Offering?,
          ),
        ],
        child: const MaterialApp(
          home: ParameterChartScreen(tankId: 1, tankName: 'Reef'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  ChoiceChip rangeChip(WidgetTester tester, String name) =>
      tester.widget<ChoiceChip>(find.byKey(ValueKey('range-$name')));

  int spotCount(WidgetTester tester) => tester
      .widget<LineChart>(find.byType(LineChart))
      .data
      .lineBarsData
      .first
      .spots
      .length;

  testWidgets('free user charts the last 30 days', (tester) async {
    await pumpChart(tester, premium: false);
    expect(find.byType(LineChart), findsOneWidget);
    expect(spotCount(tester), lessThanOrEqualTo(3));
  });

  testWidgets('free user tapping a locked range opens the paywall', (
    tester,
  ) async {
    await pumpChart(tester, premium: false);
    await tester.tap(find.byKey(const ValueKey('range-year')));
    await tester.pumpAndSettle();
    expect(find.byType(PaywallScreen), findsOneWidget);
    expect(find.text(PaywallReason.charts.title), findsOneWidget);

    // Dismissing without buying keeps the free window
    Navigator.of(tester.element(find.byType(PaywallScreen))).pop(false);
    await tester.pumpAndSettle();
    expect(rangeChip(tester, 'year').selected, isFalse);
  });

  testWidgets('free user tapping compare or export opens the paywall', (
    tester,
  ) async {
    await pumpChart(tester, premium: false);
    await tester.tap(find.byKey(const ValueKey('compare')));
    await tester.pumpAndSettle();
    expect(find.text(PaywallReason.charts.title), findsOneWidget);
    Navigator.of(tester.element(find.byType(PaywallScreen))).pop(false);
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Export CSV (Premium)'));
    await tester.pumpAndSettle();
    expect(find.text(PaywallReason.charts.title), findsOneWidget);
  });

  testWidgets('premium user can chart all history and overlay', (tester) async {
    await pumpChart(tester, premium: true);
    await tester.tap(find.byKey(const ValueKey('range-all')));
    await tester.pumpAndSettle();
    expect(find.byType(PaywallScreen), findsNothing);
    expect(rangeChip(tester, 'all').selected, isTrue);
    expect(spotCount(tester), logs.length);

    await tester.tap(find.byKey(const ValueKey('compare')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, 'Nitrate'));
    await tester.pumpAndSettle();
    final bars = tester
        .widget<LineChart>(find.byType(LineChart))
        .data
        .lineBarsData;
    expect(bars, hasLength(2));
  });
}
