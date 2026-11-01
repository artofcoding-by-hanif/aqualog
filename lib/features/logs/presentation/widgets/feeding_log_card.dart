import 'package:flutter/material.dart';

import '../../domain/entities/feeding_log.dart';
import '../../../../core/theme/color_scheme.dart';

/// Feeding log card widget for displaying log summary
class FeedingLogCard extends StatelessWidget {
  const FeedingLogCard({
    super.key,
    required this.log,
    this.tankName,
    this.onTap,
    this.onDelete,
  });

  final FeedingLogEntity log;
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
                  color: _getResponseColor(colorScheme),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    log.foodType.icon,
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
                      log.displayTitle,
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
                    if (log.response != FeedingResponse.unknown) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            log.response.icon,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            log.response.displayName,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: _getResponseTextColor(colorScheme),
                                    ),
                          ),
                        ],
                      ),
                    ],
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
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.primary,
                                    ),
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

  Color _getResponseColor(ColorScheme colorScheme) {
    switch (log.response) {
      case FeedingResponse.ateEagerly:
        return AquaPalette.healthy.withValues(alpha: 0.2);
      case FeedingResponse.ateNormally:
        return colorScheme.primaryContainer;
      case FeedingResponse.ateSome:
        return AquaPalette.caution.withValues(alpha: 0.2);
      case FeedingResponse.picky:
        return AquaPalette.caution.withValues(alpha: 0.2);
      case FeedingResponse.ignored:
        return colorScheme.errorContainer;
      case FeedingResponse.unknown:
        return colorScheme.surfaceContainerHighest;
    }
  }

  Color _getResponseTextColor(ColorScheme colorScheme) {
    switch (log.response) {
      case FeedingResponse.ateEagerly:
      case FeedingResponse.ateNormally:
        return AquaPalette.healthy;
      case FeedingResponse.ateSome:
      case FeedingResponse.picky:
        return AquaPalette.caution;
      case FeedingResponse.ignored:
        return colorScheme.error;
      case FeedingResponse.unknown:
        return colorScheme.outline;
    }
  }

  String _buildSubtitle() {
    final parts = <String>[];
    if (log.amount != null && log.amount!.isNotEmpty) {
      parts.add(log.amount!);
    }
    parts.add(log.timeAgoDisplay);
    return parts.join(' • ');
  }
}

