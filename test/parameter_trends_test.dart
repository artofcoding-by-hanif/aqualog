import 'package:aqualog/features/water_parameters/domain/entities/water_parameter_log.dart';
import 'package:aqualog/features/water_parameters/domain/parameter_trends.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime(2026, 11, 2, 12);

WaterParameterLogEntity _log(
  int daysAgo, {
  double? ph,
  double? nitrate,
  String? notes,
}) => WaterParameterLogEntity(
  tankId: 1,
  measuredAt: _now.subtract(Duration(days: daysAgo)),
  ph: ph,
  nitratePpm: nitrate,
  notes: notes,
);

void main() {
  group('ChartRange gating', () {
    test('free users get ranges up to 30 days only', () {
      final free = [
        for (final r in ChartRange.values)
          if (r.isAvailable(isPremium: false)) r,
      ];
      expect(free, [ChartRange.week, ChartRange.month]);
    });

    test('premium unlocks every range', () {
      expect(
        ChartRange.values.every((r) => r.isAvailable(isPremium: true)),
        isTrue,
      );
      expect(ChartRange.quarter.requiresPremium, isTrue);
      expect(ChartRange.year.requiresPremium, isTrue);
      expect(ChartRange.all.requiresPremium, isTrue);
    });

    test('initial range never starts on a locked window', () {
      expect(
        ChartRange.initial(preferredDays: 7, isPremium: false),
        ChartRange.week,
      );
      expect(
        ChartRange.initial(preferredDays: 90, isPremium: false),
        ChartRange.month,
      );
      expect(
        ChartRange.initial(preferredDays: 90, isPremium: true),
        ChartRange.quarter,
      );
      expect(
        ChartRange.initial(preferredDays: 14, isPremium: true),
        ChartRange.month,
      );
    });

    test('filter keeps the window, oldest first', () {
      final logs = [_log(1), _log(400), _log(29), _log(31), _log(100)];
      List<int> days(ChartRange r) => [
        for (final log in r.filter(logs, _now))
          _now.difference(log.measuredAt).inDays,
      ];
      expect(days(ChartRange.month), [29, 1]);
      expect(days(ChartRange.quarter), [31, 29, 1]);
      expect(days(ChartRange.year), [100, 31, 29, 1]);
      expect(days(ChartRange.all), [400, 100, 31, 29, 1]);
    });
  });

  group('ChartParameter', () {
    test('ideal range check', () {
      expect(ChartParameter.ph.isIdeal(7.0), isTrue);
      expect(ChartParameter.ph.isIdeal(8.2), isFalse);
      // No ideal range means nothing is flagged
      expect(ChartParameter.copper.isIdeal(5), isTrue);
    });

    test('recordedIn lists parameters with readings', () {
      expect(ChartParameter.recordedIn([_log(1, nitrate: 10)]), [
        ChartParameter.nitrate,
      ]);
      expect(ChartParameter.recordedIn([]), contains(ChartParameter.ph));
    });
  });

  group('waterParametersToCsv', () {
    test('writes recorded columns, oldest first', () {
      final csv = waterParametersToCsv([
        _log(0, ph: 7.2, nitrate: 10),
        _log(2, ph: 6.8),
      ]);
      final lines = csv.trim().split('\r\n');
      expect(lines, [
        'Measured at,pH,Nitrate (ppm),Notes',
        '2026-10-31 12:00,6.8,,',
        '2026-11-02 12:00,7.2,10,',
      ]);
    });

    test('escapes commas, quotes and newlines in notes', () {
      final csv = waterParametersToCsv([
        _log(0, ph: 7, notes: 'Water change, 25%\n"cloudy"'),
      ]);
      expect(csv, contains('7,"Water change, 25%\n""cloudy"""\r\n'));
    });

    test('header only when there are no logs', () {
      expect(waterParametersToCsv([]), 'Measured at,Notes\r\n');
    });
  });
}
