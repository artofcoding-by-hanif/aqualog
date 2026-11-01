import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/aqua_widgets.dart';
import '../../../logs/domain/entities/maintenance_log.dart';
import '../../../logs/presentation/controllers/maintenance_log_provider.dart';
import '../../../tank/presentation/controllers/tank_provider.dart';
import '../../../water_parameters/domain/entities/water_parameter_log.dart';
import '../../../water_parameters/presentation/controllers/water_parameter_log_provider.dart';

/// Activity item model for combining different log types
class _ActivityItem {
  final DateTime timestamp;
  final IconData? iconData;
  final String? emoji;
  final String title;
  final String subtitle;
  final String timeAgo;
  final int tankId;

  _ActivityItem({
    required this.timestamp,
    this.iconData,
    this.emoji,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.tankId,
  });
}

/// Recent activity widget showing maintenance logs and water parameter logs
class RecentActivity extends ConsumerWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintenanceLogsAsync = ref.watch(recentMaintenanceLogsStreamProvider);
    final waterParamLogsAsync = ref.watch(
      recentWaterParameterLogsStreamProvider,
    );
    final tanksAsync = ref.watch(tanksStreamProvider);

    // Build tank name map
    final tankNameMap = <int, String>{};
    tanksAsync.whenData((tanks) {
      for (final tank in tanks) {
        if (tank.id != null) {
          tankNameMap[tank.id!] = tank.name;
        }
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildActivityList(
          context,
          maintenanceLogsAsync,
          waterParamLogsAsync,
          tankNameMap,
        ),
      ],
    );
  }

  Widget _buildActivityList(
    BuildContext context,
    AsyncValue<List<MaintenanceLogEntity>> maintenanceLogsAsync,
    AsyncValue<List<WaterParameterLogEntity>> waterParamLogsAsync,
    Map<int, String> tankNameMap,
  ) {
    // Combine both async values
    final isLoading =
        maintenanceLogsAsync.isLoading || waterParamLogsAsync.isLoading;
    final hasError =
        maintenanceLogsAsync.hasError || waterParamLogsAsync.hasError;

    if (isLoading) {
      return const GlassCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: SizedBox(
            width: 40,
            height: 40,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          title: Text('Loading activity...'),
        ),
      );
    }

    if (hasError) {
      return GlassCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
          title: const Text('Error loading activity'),
        ),
      );
    }

    // Combine and sort activities
    final activities = <_ActivityItem>[];

    // Add maintenance logs
    maintenanceLogsAsync.whenData((logs) {
      for (final log in logs) {
        activities.add(
          _ActivityItem(
            timestamp: log.performedAt,
            emoji: log.maintenanceType.icon,
            title: log.title,
            subtitle: _getMaintenanceSubtitle(log, tankNameMap),
            timeAgo: log.timeAgoDisplay,
            tankId: log.tankId,
          ),
        );
      }
    });

    // Add water parameter logs
    waterParamLogsAsync.whenData((logs) {
      for (final log in logs) {
        activities.add(
          _ActivityItem(
            timestamp: log.measuredAt,
            iconData: Icons.science,
            title: 'Water Test',
            subtitle: _getWaterParamSubtitle(log, tankNameMap),
            timeAgo: log.timeAgoDisplay,
            tankId: log.tankId,
          ),
        );
      }
    });

    // Sort by timestamp (most recent first)
    activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // Take only the first 5
    final displayActivities = activities.take(5).toList();

    if (displayActivities.isEmpty) {
      return const GlassCard(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: ListTile(
          leading: GradientIconTile(icon: Icons.history_rounded, size: 44),
          title: Text('No recent activity'),
          subtitle: Text('Log a water change or test to get started'),
        ),
      );
    }

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (final (index, activity) in displayActivities.indexed)
            _buildActivityItem(
              context,
              iconData: activity.iconData,
              emoji: activity.emoji,
              title: activity.title,
              subtitle: activity.subtitle,
              time: activity.timeAgo,
              isLast: index == displayActivities.length - 1,
            ),
        ],
      ),
    );
  }

  String _getMaintenanceSubtitle(
    MaintenanceLogEntity log,
    Map<int, String> tankNameMap,
  ) {
    final tankName = tankNameMap[log.tankId] ?? 'Unknown Tank';
    if (log.isWaterChange && log.waterChangePercent != null) {
      return '${log.waterChangePercentDisplay} • $tankName';
    }
    return tankName;
  }

  String _getWaterParamSubtitle(
    WaterParameterLogEntity log,
    Map<int, String> tankNameMap,
  ) {
    final tankName = tankNameMap[log.tankId] ?? 'Unknown Tank';
    return '${log.parameterSummary} • $tankName';
  }

  Widget _buildActivityItem(
    BuildContext context, {
    IconData? iconData,
    String? emoji,
    required String title,
    required String subtitle,
    required String time,
    required bool isLast,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline rail: node plus connector to the next entry
          Column(
            children: [
              const SizedBox(height: 10),
              emoji != null
                  ? GradientIconTile(emoji: emoji, size: 36)
                  : GradientIconTile(icon: iconData ?? Icons.history, size: 36),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          scheme.primary.withValues(alpha: 0.5),
                          scheme.primary.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall,
                        ),
                      ),
                      Text(
                        time,
                        style: textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
