import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/maintenance_log.dart';
import '../controllers/maintenance_log_provider.dart';
import '../../../water_parameters/domain/entities/water_parameter_log.dart';
import '../../../water_parameters/presentation/controllers/water_parameter_log_provider.dart';

/// Timeline event model for combining different log types
class _TimelineEvent {
  final DateTime timestamp;
  final String emoji;
  final IconData? iconData;
  final String title;
  final String description;
  final String timeAgo;
  final Color? color;

  _TimelineEvent({
    required this.timestamp,
    this.emoji = '',
    this.iconData,
    required this.title,
    required this.description,
    required this.timeAgo,
    this.color,
  });
}

/// Tank timeline screen showing chronological history of all activities
class TankTimelineScreen extends ConsumerWidget {
  const TankTimelineScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintenanceLogsAsync = ref.watch(
      maintenanceLogsForTankStreamProvider(tankId),
    );
    final waterParamLogsAsync = ref.watch(
      waterParameterLogsForTankStreamProvider(tankId),
    );

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Timeline')),
      body: _buildBody(context, maintenanceLogsAsync, waterParamLogsAsync),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncValue<List<MaintenanceLogEntity>> maintenanceLogsAsync,
    AsyncValue<List<WaterParameterLogEntity>> waterParamLogsAsync,
  ) {
    final isLoading =
        maintenanceLogsAsync.isLoading || waterParamLogsAsync.isLoading;
    final hasError =
        maintenanceLogsAsync.hasError || waterParamLogsAsync.hasError;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            const Text('Error loading timeline'),
          ],
        ),
      );
    }

    // Combine and sort events
    final events = <_TimelineEvent>[];

    maintenanceLogsAsync.whenData((logs) {
      for (final log in logs) {
        events.add(
          _TimelineEvent(
            timestamp: log.performedAt,
            emoji: log.maintenanceType.icon,
            title: log.title,
            description: log.infoSummary,
            timeAgo: log.timeAgoDisplay,
            color: _getMaintenanceColor(log.maintenanceType, context),
          ),
        );
      }
    });

    waterParamLogsAsync.whenData((logs) {
      for (final log in logs) {
        events.add(
          _TimelineEvent(
            timestamp: log.measuredAt,
            iconData: Icons.science,
            title: 'Water Test',
            description: log.parameterSummary,
            timeAgo: log.timeAgoDisplay,
            color: _getStatusColor(log.overallStatus, context),
          ),
        );
      }
    });

    // Sort by timestamp (most recent first)
    events.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    if (events.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildTimelineItem(
          context,
          events[index],
          isFirst: index == 0,
          isLast: index == events.length - 1,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timeline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No Activity Yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Log a water change or test to start building your tank history',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    _TimelineEvent event, {
    required bool isFirst,
    required bool isLast,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final eventColor = event.color ?? colorScheme.primary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date column
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatDate(event.timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _formatTime(event.timestamp),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Timeline line and dot
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: eventColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: eventColor, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Event card
          Expanded(
            child: Card(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (event.emoji.isNotEmpty)
                          Text(
                            event.emoji,
                            style: const TextStyle(fontSize: 18),
                          )
                        else if (event.iconData != null)
                          Icon(event.iconData, size: 18, color: eventColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.title,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          event.timeAgo,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colorScheme.outline),
                        ),
                      ],
                    ),
                    if (event.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}';
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Color _getMaintenanceColor(MaintenanceType type, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (type) {
      case MaintenanceType.waterChange:
        return Colors.blue;
      case MaintenanceType.filterCleaning:
        return Colors.orange;
      case MaintenanceType.glassCleaning:
        return Colors.cyan;
      case MaintenanceType.substrateCleaning:
        return Colors.brown;
      case MaintenanceType.trimming:
        return Colors.green;
      case MaintenanceType.equipmentMaintenance:
        return Colors.grey;
      case MaintenanceType.medicationDose:
        return Colors.red;
      case MaintenanceType.other:
        return colorScheme.primary;
    }
  }

  Color _getStatusColor(ParameterStatus status, BuildContext context) {
    switch (status) {
      case ParameterStatus.optimal:
        return Colors.green;
      case ParameterStatus.warning:
        return Colors.orange;
      case ParameterStatus.danger:
        return Colors.red;
      case ParameterStatus.unknown:
        return Theme.of(context).colorScheme.outline;
    }
  }
}
