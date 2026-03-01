import 'package:flutter/material.dart';

import '../../domain/entities/fish.dart';

/// Fish card widget for displaying fish summary
class FishCard extends StatelessWidget {
  const FishCard({
    super.key,
    required this.fish,
    this.onTap,
  });

  final FishEntity fish;
  final VoidCallback? onTap;

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
                  color: _getStatusColor(colorScheme),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('🐟', style: TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fish.displayName,
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
                    const SizedBox(height: 4),
                    _buildStatusRow(context, colorScheme),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  String _buildSubtitle() {
    final parts = <String>[];
    parts.add(fish.quantityDisplay);
    parts.add(fish.waterType.displayName);
    if (fish.temperament != null) {
      parts.add(fish.temperament!.displayName);
    }
    return parts.join(' • ');
  }

  Color _getStatusColor(ColorScheme colorScheme) {
    if (fish.isDeceased) {
      return colorScheme.surfaceContainerHighest;
    }
    if (fish.isInQuarantine) {
      return colorScheme.tertiaryContainer;
    }
    return colorScheme.primaryContainer;
  }

  Widget _buildStatusRow(BuildContext context, ColorScheme colorScheme) {
    if (fish.isDeceased) {
      return Row(
        children: [
          Icon(Icons.sentiment_very_dissatisfied, size: 14, color: colorScheme.outline),
          const SizedBox(width: 4),
          Text(
            'Deceased',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline,
                ),
          ),
        ],
      );
    }

    if (fish.isInQuarantine) {
      return Row(
        children: [
          Icon(Icons.medical_services, size: 14, color: colorScheme.tertiary),
          const SizedBox(width: 4),
          Text(
            'Quarantined${fish.quarantineDaysRemaining != null ? ' (${fish.quarantineDaysRemaining} days left)' : ''}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.tertiary,
                ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(Icons.timer_outlined, size: 14, color: colorScheme.outline),
        const SizedBox(width: 4),
        Text(
          fish.ageInTankDisplay,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.outline,
              ),
        ),
        if (fish.sizeDisplay != 'Unknown') ...[
          const SizedBox(width: 8),
          Icon(Icons.straighten, size: 14, color: colorScheme.outline),
          const SizedBox(width: 4),
          Text(
            fish.sizeDisplay,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline,
                ),
          ),
        ],
      ],
    );
  }
}

