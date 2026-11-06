import 'package:flutter/material.dart';

import '../../domain/entities/maintenance_log.dart';

/// Maintenance log card widget for displaying log summary
class MaintenanceLogCard extends StatelessWidget {
  const MaintenanceLogCard({
    super.key,
    required this.log,
    this.tankName,
    this.onTap,
    this.onDelete,
  });

  final MaintenanceLogEntity log;
  final String? tankName;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _getTypeColor(colorScheme),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    log.maintenanceType.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _buildSubtitle(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                    if (tankName != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 14,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tankName!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(
                  icon: Icon(Icons.delete_outline, color: colorScheme.error),
                  onPressed: onDelete,
                )
              else
                const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(ColorScheme colorScheme) {
    switch (log.maintenanceType) {
      case MaintenanceType.waterChange:
        return colorScheme.primaryContainer;
      case MaintenanceType.filterCleaning:
        return colorScheme.secondaryContainer;
      case MaintenanceType.glassCleaning:
        return colorScheme.tertiaryContainer;
      case MaintenanceType.medicationDose:
        return colorScheme.errorContainer;
      default:
        return colorScheme.surfaceContainerHighest;
    }
  }

  String _buildSubtitle() {
    final parts = <String>[];
    parts.add(log.maintenanceType.displayName);
    if (log.waterChangeSummary != null) {
      parts.add(log.waterChangeSummary!);
    }
    if (log.durationDisplay != null) {
      parts.add(log.durationDisplay!);
    }
    parts.add(log.timeAgoDisplay);
    return parts.join(' • ');
  }
}
