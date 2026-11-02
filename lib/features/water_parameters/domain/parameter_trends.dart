import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

import '../../../core/config/subscription_config.dart';
import '../../../core/theme/color_scheme.dart';
import 'entities/water_parameter_log.dart';

/// A water parameter that can be charted and exported.
///
/// Ideal ranges are general freshwater-tropical (or reef, for saltwater
/// parameters) guidance, drawn as a band behind the trend line.
enum ChartParameter {
  ph('pH', '', AquaHue.testing, 1, idealMin: 6.5, idealMax: 7.5),
  temperature(
    'Temperature',
    '°C',
    AquaHue.feeding,
    1,
    idealMin: 24,
    idealMax: 28,
  ),
  ammonia(
    'Ammonia',
    'ppm',
    AquaHue.invertebrates,
    2,
    idealMin: 0,
    idealMax: 0.05,
  ),
  nitrite('Nitrite', 'ppm', AquaHue.gallery, 2, idealMin: 0, idealMax: 0.05),
  nitrate('Nitrate', 'ppm', AquaHue.lighting, 1, idealMin: 0, idealMax: 20),
  gh('GH', 'dGH', AquaHue.substrate, 1, idealMin: 4, idealMax: 12),
  kh('KH', 'dKH', AquaHue.maintenance, 1, idealMin: 3, idealMax: 8),
  phosphate('Phosphate', 'ppm', AquaHue.plants, 2, idealMin: 0, idealMax: 1),
  tds('TDS', 'ppm', AquaHue.rocks, 0, idealMin: 100, idealMax: 300),
  co2('CO2', 'mg/L', AquaHue.filters, 1, idealMin: 15, idealMax: 30),
  oxygen('Oxygen', 'mg/L', AquaHue.water, 1, idealMin: 6, idealMax: 8),
  iron('Iron', 'ppm', AquaHue.driftwood, 2),
  copper('Copper', 'ppm', AquaHue.driftwood, 2),
  chlorine('Chlorine', 'ppm', AquaHue.rocks, 2),
  salinity('Salinity', 'ppt', AquaHue.fish, 1, idealMin: 33, idealMax: 36),
  calcium('Calcium', 'ppm', AquaHue.notes, 0, idealMin: 380, idealMax: 450),
  magnesium(
    'Magnesium',
    'ppm',
    AquaHue.timeline,
    0,
    idealMin: 1250,
    idealMax: 1400,
  ),
  alkalinity(
    'Alkalinity',
    'dKH',
    AquaHue.maintenance,
    1,
    idealMin: 7,
    idealMax: 11,
  );

  const ChartParameter(
    this.label,
    this.unit,
    this.hue,
    this.decimals, {
    this.idealMin,
    this.idealMax,
  });

  final String label;
  final String unit;
  final Color hue;

  /// Decimal places when displaying a reading
  final int decimals;
  final double? idealMin;
  final double? idealMax;

  bool get hasIdealRange => idealMin != null && idealMax != null;

  /// Label with unit, e.g. "Nitrate (ppm)"
  String get labelWithUnit => unit.isEmpty ? label : '$label ($unit)';

  String format(double value) {
    final number = value.toStringAsFixed(decimals);
    return unit.isEmpty ? number : '$number $unit';
  }

  double? valueOf(WaterParameterLogEntity log) => switch (this) {
    ChartParameter.ph => log.ph,
    ChartParameter.temperature => log.temperatureCelsius,
    ChartParameter.ammonia => log.ammoniaPpm,
    ChartParameter.nitrite => log.nitritePpm,
    ChartParameter.nitrate => log.nitratePpm,
    ChartParameter.gh => log.ghDgh,
    ChartParameter.kh => log.khDkh,
    ChartParameter.phosphate => log.phosphatePpm,
    ChartParameter.tds => log.tdsPpm,
    ChartParameter.co2 => log.co2MgL,
    ChartParameter.oxygen => log.oxygenMgL,
    ChartParameter.iron => log.ironPpm,
    ChartParameter.copper => log.copperPpm,
    ChartParameter.chlorine => log.chlorinePpm,
    ChartParameter.salinity => log.salinityPpt,
    ChartParameter.calcium => log.calciumPpm,
    ChartParameter.magnesium => log.magnesiumPpm,
    ChartParameter.alkalinity => log.alkalinityDkh,
  };

  bool isIdeal(double value) =>
      !hasIdealRange || (value >= idealMin! && value <= idealMax!);

  /// Parameters with at least one reading, in display order; the core five
  /// when there are no readings yet
  static List<ChartParameter> recordedIn(List<WaterParameterLogEntity> logs) {
    final recorded = [
      for (final p in values)
        if (logs.any((log) => p.valueOf(log) != null)) p,
    ];
    return recorded.isNotEmpty
        ? recorded
        : const [ph, temperature, ammonia, nitrite, nitrate];
  }
}

/// A time window for the trend chart
enum ChartRange {
  week('7D', 7),
  month('30D', 30),
  quarter('90D', 90),
  year('1Y', 365),
  all('All', null);

  const ChartRange(this.label, this.days);

  final String label;

  /// Length of the window; null means the whole history
  final int? days;

  /// Free accounts chart up to this many days of history
  static const freeDays = SubscriptionConfig.freeChartDays;

  bool get requiresPremium => days == null || days! > freeDays;

  bool isAvailable({required bool isPremium}) => isPremium || !requiresPremium;

  /// Earliest reading time included, or null for the whole history
  DateTime? since(DateTime now) =>
      days == null ? null : now.subtract(Duration(days: days!));

  /// Logs measured within this window, oldest first
  List<WaterParameterLogEntity> filter(
    List<WaterParameterLogEntity> logs,
    DateTime now,
  ) {
    final start = since(now);
    return [
      for (final log in logs)
        if (start == null || !log.measuredAt.isBefore(start)) log,
    ]..sort((a, b) => a.measuredAt.compareTo(b.measuredAt));
  }

  /// The range to open the chart on: the shortest available window that
  /// covers [preferredDays] (the "default trend days" setting)
  static ChartRange initial({
    required int preferredDays,
    required bool isPremium,
  }) {
    for (final range in values) {
      if (!range.isAvailable(isPremium: isPremium)) continue;
      if (range.days == null || range.days! >= preferredDays) return range;
    }
    return month;
  }
}

/// Builds a CSV of a tank's water tests, oldest first, with one column per
/// parameter that has at least one reading.
String waterParametersToCsv(List<WaterParameterLogEntity> logs) {
  final sorted = [...logs]
    ..sort((a, b) => a.measuredAt.compareTo(b.measuredAt));
  final columns = [
    for (final p in ChartParameter.values)
      if (sorted.any((log) => p.valueOf(log) != null)) p,
  ];
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  final rows = <List<String>>[
    ['Measured at', for (final p in columns) p.labelWithUnit, 'Notes'],
    for (final log in sorted)
      [
        dateFormat.format(log.measuredAt),
        for (final p in columns) _formatNumber(p.valueOf(log)),
        log.notes ?? '',
      ],
  ];
  return '${rows.map((row) => row.map(_escapeCsv).join(',')).join('\r\n')}\r\n';
}

String _formatNumber(double? value) {
  if (value == null) return '';
  // Drop a trailing ".0" so whole numbers stay whole
  return value == value.truncateToDouble()
      ? value.toStringAsFixed(0)
      : value.toString();
}

String _escapeCsv(String field) {
  final needsQuotes =
      field.contains(',') ||
      field.contains('"') ||
      field.contains('\n') ||
      field.contains('\r');
  return needsQuotes ? '"${field.replaceAll('"', '""')}"' : field;
}
