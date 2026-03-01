import 'package:flutter/material.dart';

import '../../domain/entities/driftwood.dart';

/// Driftwood card widget for displaying driftwood summary
class DriftwoodCard extends StatelessWidget {
  const DriftwoodCard({super.key, required this.driftwood, this.onTap});

  final DriftwoodEntity driftwood;
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
                    driftwood.driftwoodType.icon,
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
                      driftwood.fullName,
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

  Color _getStatusColor(ColorScheme colorScheme) {
    if (!driftwood.isCured) {
      return colorScheme.tertiaryContainer;
    }
    if (driftwood.isReleasingTannins) {
      return colorScheme.secondaryContainer;
    }
    return colorScheme.primaryContainer;
  }

  String _buildSubtitle() {
    final parts = <String>[];
    parts.add(driftwood.quantityDisplay);
    parts.add(driftwood.statusDisplay);
    if (driftwood.hasDimensions && driftwood.dimensionsDisplay != null) {
      parts.add(driftwood.dimensionsDisplay!);
    }
    return parts.join(' • ');
  }

  Widget _buildStatusRow(BuildContext context, ColorScheme colorScheme) {
    final widgets = <Widget>[];

    // Time in tank
    if (driftwood.timeInTankDisplay != null) {
      widgets.add(
        Icon(Icons.timer_outlined, size: 14, color: colorScheme.outline),
      );
      widgets.add(const SizedBox(width: 4));
      widgets.add(
        Text(
          driftwood.timeInTankDisplay!,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
        ),
      );
    }

    // Curing status
    if (!driftwood.isCured) {
      widgets.add(const SizedBox(width: 8));
      widgets.add(
        Icon(Icons.water_drop, size: 14, color: colorScheme.tertiary),
      );
      widgets.add(const SizedBox(width: 4));
      widgets.add(
        Text(
          'Curing',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.tertiary),
        ),
      );
    } else if (driftwood.isReleasingTannins) {
      widgets.add(const SizedBox(width: 8));
      widgets.add(Icon(Icons.opacity, size: 14, color: colorScheme.secondary));
      widgets.add(const SizedBox(width: 4));
      widgets.add(
        Text(
          'Tannins',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
        ),
      );
    }

    return Row(children: widgets);
  }
}
