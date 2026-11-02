import 'dart:async';

import 'package:aqualog/features/subscription/presentation/controllers/subscription_providers.dart';
import 'package:aqualog/features/subscription/presentation/paywall_screen.dart';
import 'package:aqualog/features/subscription/presentation/tank_limit_gate.dart';
import 'package:aqualog/features/tank/domain/entities/tank.dart';
import 'package:aqualog/features/tank/presentation/controllers/tank_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

List<TankEntity> _tanks(int count) => [
  for (var i = 0; i < count; i++)
    TankEntity(
      id: i + 1,
      name: 'Tank $i',
      tankType: TankType.freshwater,
      volumeLiters: 40,
    ),
];

void main() {
  late StreamController<List<TankEntity>> tanks;

  setUp(() => tanks = StreamController<List<TankEntity>>.broadcast());
  tearDown(() => tanks.close());

  Future<void> pumpGate(WidgetTester tester, {required bool premium}) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          tanksStreamProvider.overrideWith((ref) => tanks.stream),
          isPremiumProvider.overrideWithValue(premium),
          // Keep the paywall offline in tests
          currentOfferingProvider.overrideWith((ref) async => null as Offering?),
        ],
        child: const MaterialApp(
          home: TankLimitGate(child: Text('tank form')),
        ),
      ),
    );
  }

  testWidgets('free user under the limit sees the form', (tester) async {
    await pumpGate(tester, premium: false);
    tanks.add(_tanks(1));
    await tester.pump();
    expect(find.text('tank form'), findsOneWidget);
  });

  testWidgets('free user at the limit sees the paywall', (tester) async {
    await pumpGate(tester, premium: false);
    tanks.add(_tanks(2));
    await tester.pump();
    expect(find.text('tank form'), findsNothing);
    expect(find.byType(PaywallScreen), findsOneWidget);
    expect(find.text(PaywallReason.tankLimit.title), findsOneWidget);
  });

  testWidgets('saving the tank that reaches the limit keeps the form', (
    tester,
  ) async {
    await pumpGate(tester, premium: false);
    tanks.add(_tanks(1));
    await tester.pump();
    tanks.add(_tanks(2)); // the form just saved tank #2
    await tester.pump();
    expect(find.text('tank form'), findsOneWidget);
    expect(find.byType(PaywallScreen), findsNothing);
  });

  testWidgets('premium users are never limited', (tester) async {
    await pumpGate(tester, premium: true);
    tanks.add(_tanks(12));
    await tester.pump();
    expect(find.text('tank form'), findsOneWidget);
  });
}
