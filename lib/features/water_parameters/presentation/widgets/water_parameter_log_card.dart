import 'package:flutter/material.dart';

import '../../domain/entities/water_parameter_log.dart';
import '../../../../core/theme/color_scheme.dart';

/// Card widget for displaying a water parameter log entry
class WaterParameterLogCard extends StatelessWidget {
  const WaterParameterLogCard({
    super.key,
    required this.log,
    required this.onTap,
    this.onDelete,
  });

  final WaterParameterLogEntity log;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Status indicator
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(log.overallStatus, colorScheme)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    _getStatusIcon(log.overallStatus),
                    color: _getStatusColor(log.overallStatus, colorScheme),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.parameterSummary,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      log.infoSummary,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // Delete button
              if (onDelete != null)
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: colorScheme.error,
                  ),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ParameterStatus status, ColorScheme colorScheme) {
    switch (status) {
      case ParameterStatus.optimal:
        return AquaPalette.healthy;
      case ParameterStatus.warning:
        return AquaPalette.caution;
      case ParameterStatus.danger:
        return colorScheme.error;
      case ParameterStatus.unknown:
        return colorScheme.outline;
    }
  }

  IconData _getStatusIcon(ParameterStatus status) {
    switch (status) {
      case ParameterStatus.optimal:
        return Icons.check_circle;
      case ParameterStatus.warning:
        return Icons.warning;
      case ParameterStatus.danger:
        return Icons.error;
      case ParameterStatus.unknown:
        return Icons.help_outline;
    }
  }
}

