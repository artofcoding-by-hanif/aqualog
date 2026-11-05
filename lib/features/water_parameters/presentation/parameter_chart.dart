import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/settings/settings_provider.dart';
import '../../../core/theme/aqua_theme.dart';
import '../../../core/theme/color_scheme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import '../../subscription/presentation/controllers/subscription_providers.dart';
import '../../subscription/presentation/paywall_screen.dart';
import '../domain/entities/water_parameter_log.dart';
import '../domain/parameter_trends.dart';
import 'controllers/water_parameter_log_provider.dart';
import 'water_parameter_export.dart';

/// Trend charts for one tank's water tests.
///
/// Free accounts see up to [ChartRange.freeDays] days of one parameter;
/// Premium unlocks longer ranges, overlays and CSV export.
class ParameterChartScreen extends ConsumerStatefulWidget {
  const ParameterChartScreen({
    super.key,
    required this.tankId,
    required this.tankName,
    this.initialParameter,
  });

  final int tankId;
  final String tankName;
  final ChartParameter? initialParameter;

  @override
  ConsumerState<ParameterChartScreen> createState() =>
      _ParameterChartScreenState();
}

class _ParameterChartScreenState extends ConsumerState<ParameterChartScreen> {
  /// Most series shown at once in compare mode
  static const _maxOverlay = 4;

  late List<ChartParameter> _selected = [
    widget.initialParameter ?? ChartParameter.ph,
  ];
  ChartRange? _range;
  bool _compare = false;

  Future<bool> _unlock() => showPaywall(context, reason: PaywallReason.charts);

  Future<void> _selectRange(ChartRange range, bool isPremium) async {
    if (!range.isAvailable(isPremium: isPremium) && !await _unlock()) return;
    setState(() => _range = range);
  }

  Future<void> _toggleCompare(bool isPremium) async {
    if (!_compare && !isPremium && !await _unlock()) return;
    setState(() {
      _compare = !_compare;
      if (!_compare) _selected = [_selected.first];
    });
  }

  void _tapParameter(ChartParameter parameter) {
    setState(() {
      if (!_compare) {
        _selected = [parameter];
      } else if (_selected.contains(parameter)) {
        if (_selected.length > 1) _selected.remove(parameter);
      } else if (_selected.length < _maxOverlay) {
        _selected.add(parameter);
      }
    });
  }

  Future<void> _export(List<WaterParameterLogEntity> logs) async {
    if (!ref.read(isPremiumProvider) && !await _unlock()) return;
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    if (logs.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No water tests to export yet')),
      );
      return;
    }
    try {
      await shareWaterParameterCsv(tankName: widget.tankName, logs: logs);
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(isPremiumProvider);
    final logsAsync = ref.watch(
      waterParameterLogsForTankStreamProvider(widget.tankId),
    );
    final trendDays =
        ref.watch(appSettingsProvider).value?.defaultTrendDays ??
        ChartRange.freeDays;

    // Losing Premium (or it expiring) falls back to the free window
    var range =
        _range ??
        ChartRange.initial(preferredDays: trendDays, isPremium: isPremium);
    if (!range.isAvailable(isPremium: isPremium)) range = ChartRange.month;
    final selected = isPremium ? _selected : [_selected.first];
    final logs = logsAsync.value ?? const <WaterParameterLogEntity>[];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tankName} Trends'),
        actions: [
          IconButton(
            tooltip: isPremium ? 'Export CSV' : 'Export CSV (Premium)',
            onPressed: logsAsync.hasValue ? () => _export(logs) : null,
            icon: Badge(
              isLabelVisible: !isPremium,
              label: const Icon(Icons.lock_rounded, size: 10),
              child: const Icon(Icons.ios_share_rounded),
            ),
          ),
        ],
      ),
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading tests: $error')),
        data: (logs) {
          final parameters = ChartParameter.recordedIn(logs);
          final windowLogs = range.filter(logs, DateTime.now());
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              _ParameterPicker(
                parameters: {...parameters, ...selected}.toList(),
                selected: selected,
                onTap: _tapParameter,
              ),
              const SizedBox(height: 12),
              _RangeBar(
                range: range,
                isPremium: isPremium,
                compare: _compare && isPremium,
                onRange: (r) => _selectRange(r, isPremium),
                onCompare: () => _toggleCompare(isPremium),
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
                child: SizedBox(
                  height: 260,
                  child: _TrendChart(
                    logs: windowLogs,
                    parameters: selected,
                    range: range,
                  ),
                ),
              ),
              if (selected.length > 1) ...[
                const SizedBox(height: 8),
                _Legend(parameters: selected),
              ],
              if (!isPremium) ...[
                const SizedBox(height: 12),
                _UpsellCard(onTap: _unlock),
              ],
              const SizedBox(height: 12),
              for (final parameter in selected)
                _StatsCard(parameter: parameter, logs: windowLogs),
            ],
          );
        },
      ),
    );
  }
}

/// Light surfaces need deeper hues for contrast (as in [GradientIconTile])
Color _tone(BuildContext context, Color color) {
  if (Theme.of(context).brightness == Brightness.dark) return color;
  final hsl = HSLColor.fromColor(color);
  return hsl.withLightness((hsl.lightness - 0.18).clamp(0.0, 1.0)).toColor();
}

class _ParameterPicker extends StatelessWidget {
  const _ParameterPicker({
    required this.parameters,
    required this.selected,
    required this.onTap,
  });

  final List<ChartParameter> parameters;
  final List<ChartParameter> selected;
  final ValueChanged<ChartParameter> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final p in parameters)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(p.label),
                selected: selected.contains(p),
                showCheckmark: false,
                avatar: CircleAvatar(
                  radius: 5,
                  backgroundColor: _tone(context, p.hue),
                ),
                selectedColor: _tone(context, p.hue).withValues(alpha: 0.22),
                side: BorderSide(
                  color: selected.contains(p)
                      ? _tone(context, p.hue)
                      : AquaTheme.of(context).glassBorder,
                ),
                onSelected: (_) => onTap(p),
              ),
            ),
        ],
      ),
    );
  }
}

class _RangeBar extends StatelessWidget {
  const _RangeBar({
    required this.range,
    required this.isPremium,
    required this.compare,
    required this.onRange,
    required this.onCompare,
  });

  final ChartRange range;
  final bool isPremium;
  final bool compare;
  final ValueChanged<ChartRange> onRange;
  final VoidCallback onCompare;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final r in ChartRange.values)
          ChoiceChip(
            key: ValueKey('range-${r.name}'),
            label: Text(r.label),
            selected: r == range,
            showCheckmark: false,
            avatar: r.isAvailable(isPremium: isPremium)
                ? null
                : Icon(
                    Icons.lock_rounded,
                    size: 14,
                    color: scheme.onSurfaceVariant,
                  ),
            onSelected: (_) => onRange(r),
          ),
        FilterChip(
          key: const ValueKey('compare'),
          label: const Text('Compare'),
          selected: compare,
          showCheckmark: false,
          avatar: Icon(
            isPremium ? Icons.stacked_line_chart_rounded : Icons.lock_rounded,
            size: 16,
          ),
          onSelected: (_) => onCompare(),
        ),
      ],
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({
    required this.logs,
    required this.parameters,
    required this.range,
  });

  /// Readings in the window, oldest first
  final List<WaterParameterLogEntity> logs;
  final List<ChartParameter> parameters;
  final ChartRange range;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final aqua = AquaTheme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    final overlay = parameters.length > 1;

    final series = [
      for (final p in parameters)
        [
          for (final log in logs)
            if (p.valueOf(log) case final value?) (log.measuredAt, value),
        ],
    ];
    if (series.every((s) => s.isEmpty)) {
      return Center(
        child: Text(
          'No ${overlay ? '' : '${parameters.first.label} '}readings '
          '${range.days == null ? 'yet' : 'in the last ${range.days} days'}',
          style: theme.textTheme.bodyMedium?.copyWith(color: muted),
          textAlign: TextAlign.center,
        ),
      );
    }

    // X axis: days since the window starts
    final now = DateTime.now();
    final start =
        range.since(now) ??
        series
            .expand((s) => s)
            .map((r) => r.$1)
            .reduce((a, b) => a.isBefore(b) ? a : b);
    double x(DateTime t) => t.difference(start).inMinutes / (60 * 24);
    final maxX = math.max(x(now), 1.0);

    // Single parameter: real units with the ideal band. Overlay: each series
    // scaled to 0–1 of its own spread so different units share one axis.
    double Function(double) scaleFor(int i) {
      if (!overlay) return (v) => v;
      final values = series[i].map((r) => r.$2);
      if (values.isEmpty) return (v) => v;
      final lo = values.reduce(math.min);
      final hi = values.reduce(math.max);
      return (v) => hi == lo ? 0.5 : (v - lo) / (hi - lo);
    }

    final scales = [for (var i = 0; i < series.length; i++) scaleFor(i)];
    final single = parameters.first;
    final (minY, maxY) = overlay
        ? (-0.08, 1.08)
        : _yBounds(series.first.map((r) => r.$2), single);

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        clipData: const FlClipData.all(),
        rangeAnnotations: RangeAnnotations(
          horizontalRangeAnnotations: [
            if (!overlay && single.hasIdealRange)
              HorizontalRangeAnnotation(
                y1: single.idealMin!,
                y2: single.idealMax!,
                color: aqua.healthy.withValues(alpha: 0.14),
              ),
          ],
        ),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: aqua.glassBorder, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: !overlay,
              reservedSize: 44,
              getTitlesWidget: (value, meta) {
                // The padded min/max land on odd values; label the grid only
                if ((value == meta.min || value == meta.max) &&
                    (value / meta.appliedInterval -
                                (value / meta.appliedInterval).round())
                            .abs() >
                        1e-6) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    meta.formattedValue,
                    style: theme.textTheme.labelSmall?.copyWith(color: muted),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: math.max(maxX / 4, 1),
              getTitlesWidget: (value, meta) {
                // Skip the label squeezed against the last one
                if (value != meta.max &&
                    meta.max - value < meta.appliedInterval / 2) {
                  return const SizedBox.shrink();
                }
                final date = start.add(
                  Duration(minutes: (value * 24 * 60).round()),
                );
                final format = maxX > 300
                    ? DateFormat("MMM ''yy")
                    : DateFormat('d MMM');
                return SideTitleWidget(
                  meta: meta,
                  fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
                  child: Text(
                    format.format(date),
                    style: theme.textTheme.labelSmall?.copyWith(color: muted),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (_) => theme.colorScheme.surfaceContainerHigh,
            getTooltipItems: (spots) => [
              for (final spot in spots)
                LineTooltipItem(
                  '${parameters[spot.barIndex].format(series[spot.barIndex][spot.spotIndex].$2)}\n',
                  TextStyle(
                    color: _tone(context, parameters[spot.barIndex].hue),
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat.MMMd().add_jm().format(
                        series[spot.barIndex][spot.spotIndex].$1,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(color: muted),
                    ),
                  ],
                ),
            ],
          ),
        ),
        lineBarsData: [
          for (var i = 0; i < series.length; i++)
            _bar(context, parameters[i], series[i], x, scales[i], overlay),
        ],
      ),
    );
  }

  LineChartBarData _bar(
    BuildContext context,
    ChartParameter parameter,
    List<(DateTime, double)> readings,
    double Function(DateTime) x,
    double Function(double) scale,
    bool overlay,
  ) {
    final aqua = AquaTheme.of(context);
    final color = _tone(context, parameter.hue);
    return LineChartBarData(
      spots: [for (final (t, v) in readings) FlSpot(x(t), scale(v))],
      isCurved: true,
      preventCurveOverShooting: true,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: readings.length <= 40,
        getDotPainter: (spot, _, _, index) => FlDotCirclePainter(
          radius: 3.5,
          // Out-of-range readings are ringed in the danger colour
          color: !overlay && !parameter.isIdeal(readings[index].$2)
              ? aqua.danger
              : color,
          strokeWidth: 1.5,
          strokeColor: Theme.of(context).colorScheme.surface,
        ),
      ),
      belowBarData: BarAreaData(
        show: !overlay,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.28), color.withValues(alpha: 0)],
        ),
      ),
    );
  }

  /// Y bounds covering the readings and the ideal band, with headroom
  static (double, double) _yBounds(
    Iterable<double> values,
    ChartParameter parameter,
  ) {
    var lo = values.reduce(math.min);
    var hi = values.reduce(math.max);
    if (parameter.hasIdealRange) {
      lo = math.min(lo, parameter.idealMin!);
      hi = math.max(hi, parameter.idealMax!);
    }
    final pad = hi == lo ? math.max(hi.abs() * 0.1, 0.5) : (hi - lo) * 0.12;
    final minY = lo - pad;
    // Concentrations can't go negative
    return (lo >= 0 && minY < 0 ? 0 : minY, hi + pad);
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.parameters});

  final List<ChartParameter> parameters;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;
    return Wrap(
      spacing: 16,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: [
        for (final p in parameters)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 3,
                decoration: BoxDecoration(
                  color: _tone(context, p.hue),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              Text(p.labelWithUnit, style: style),
            ],
          ),
        Text(
          'Each line is scaled to its own range',
          style: style?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _UpsellCard extends StatelessWidget {
  const _UpsellCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      onTap: onTap,
      glowColor: AquaHue.testing,
      child: Row(
        children: [
          const GradientIconTile(
            icon: Icons.insights_rounded,
            color: AquaHue.testing,
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'See the full history',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Premium adds 90-day, 1-year and all-time trends, '
                  'overlays and CSV export.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.parameter, required this.logs});

  final ChartParameter parameter;
  final List<WaterParameterLogEntity> logs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final aqua = AquaTheme.of(context);
    final values = [
      for (final log in logs)
        if (parameter.valueOf(log) case final v?) v,
    ];
    if (values.isEmpty) return const SizedBox.shrink();

    final latest = values.last;
    final average = values.reduce((a, b) => a + b) / values.length;
    final inRange = values.where(parameter.isIdeal).length;
    final status = parameter.isIdeal(latest)
        ? AquaStatus.healthy
        : AquaStatus.danger;

    Widget stat(String label, String value) => Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      glowColor: parameter.hasIdealRange
          ? aqua.statusColor(status, theme.colorScheme)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientIconTile(
                icon: Icons.show_chart_rounded,
                color: parameter.hue,
                size: 36,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parameter.label,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (parameter.hasIdealRange)
                      Text(
                        'Ideal ${parameter.format(parameter.idealMin!)} – '
                        '${parameter.format(parameter.idealMax!)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (parameter.hasIdealRange)
                StatusPill(
                  label: '$inRange/${values.length} in range',
                  status: inRange == values.length
                      ? AquaStatus.healthy
                      : AquaStatus.caution,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              stat('Latest', parameter.format(latest)),
              stat('Average', parameter.format(average)),
              stat('Low', parameter.format(values.reduce(math.min))),
              stat('High', parameter.format(values.reduce(math.max))),
            ],
          ),
        ],
      ),
    );
  }
}
