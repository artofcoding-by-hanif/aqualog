import 'package:flutter/material.dart';

import '../../domain/entities/plant.dart';

/// Plant card widget for displaying plant summary
class PlantCard extends StatelessWidget {
  const PlantCard({
    super.key,
    required this.plant,
    this.onTap,
  });

  final PlantEntity plant;
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
                child: Center(
                  child: Text(
                    plant.plantType.icon,
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
                      plant.displayName,
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
    parts.add(plant.quantityDisplay);
    parts.add(plant.plantType.displayName);
    if (plant.placementZone != null) {
      parts.add(plant.placementZone!.displayName);
    }
    return parts.join(' • ');
  }

  Color _getStatusColor(ColorScheme colorScheme) {
    if (plant.isRemoved) {
      return colorScheme.surfaceContainerHighest;
    }
    if (plant.isPropagated) {
      return colorScheme.tertiaryContainer;
    }
    return colorScheme.primaryContainer;
  }

  Widget _buildStatusRow(BuildContext context, ColorScheme colorScheme) {
    if (plant.isRemoved) {
      return Row(
        children: [
          Icon(Icons.remove_circle_outline, size: 14, color: colorScheme.outline),
          const SizedBox(width: 4),
          Text(
            'Removed',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline,
                ),
          ),
        ],
      );
    }

    final parts = <Widget>[];

    if (plant.daysInTank != null) {
      parts.addAll([
        Icon(Icons.timer_outlined, size: 14, color: colorScheme.outline),
        const SizedBox(width: 4),
        Text(
          '${plant.daysInTank} days',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.outline,
              ),
        ),
      ]);
    }

    if (plant.lightingRequirement != null) {
      if (parts.isNotEmpty) parts.add(const SizedBox(width: 8));
      parts.addAll([
        Text(
          plant.lightingRequirement!.icon,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(width: 4),
        Text(
          plant.lightingRequirement!.displayName,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.outline,
              ),
        ),
      ]);
    }

    if (parts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(children: parts);
  }
}

