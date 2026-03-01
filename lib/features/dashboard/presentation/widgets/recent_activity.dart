import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
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
      return const Card(
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
      return Card(
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
      return Card(
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          title: const Text('No recent activity'),
          subtitle: const Text('Log a water change or test to get started'),
        ),
      );
    }

    return Column(
      children: displayActivities.map((activity) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildActivityItem(
            context,
            iconData: activity.iconData,
            emoji: activity.emoji,
            title: activity.title,
            subtitle: activity.subtitle,
            time: activity.timeAgo,
          ),
        );
      }).toList(),
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
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: emoji != null
                ? Text(emoji, style: const TextStyle(fontSize: 20))
                : Icon(
                    iconData ?? Icons.history,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
          ),
        ),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Text(
          time,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
