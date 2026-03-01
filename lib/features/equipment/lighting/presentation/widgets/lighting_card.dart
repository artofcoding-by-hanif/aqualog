import 'package:flutter/material.dart';

import '../../domain/entities/lighting.dart';

/// Lighting card widget for displaying lighting summary
class LightingCard extends StatelessWidget {
  const LightingCard({
    super.key,
    required this.lighting,
    this.onTap,
  });

  final LightingEntity lighting;
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
                    lighting.lightingType.icon,
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
                      lighting.name,
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
                    _buildScheduleInfo(context, colorScheme),
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
    parts.add(lighting.lightingType.displayName);
    if (lighting.brand != null || lighting.model != null) {
      final brandModel = [lighting.brand, lighting.model]
          .where((s) => s != null && s.isNotEmpty)
          .join(' ');
      if (brandModel.isNotEmpty) {
        parts.add(brandModel);
      }
    }
    if (lighting.wattage != null) {
      parts.add('${lighting.wattage!.toInt()}W');
    }
    return parts.join(' • ');
  }

  Color _getStatusColor(ColorScheme colorScheme) {
    if (lighting.isReplacementDue) {
      return colorScheme.errorContainer;
    }
    return colorScheme.primaryContainer;
  }

  Widget _buildScheduleInfo(BuildContext context, ColorScheme colorScheme) {
    final schedule = lighting.photoperiodDisplay;
    final features = lighting.featuresDisplay;

    return Row(
      children: [
        Icon(
          Icons.schedule,
          size: 14,
          color: colorScheme.outline,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            schedule ?? features,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

