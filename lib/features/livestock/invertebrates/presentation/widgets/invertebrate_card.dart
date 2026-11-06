import 'package:flutter/material.dart';

import '../../domain/entities/invertebrate.dart';

/// Invertebrate card widget for displaying invertebrate summary
class InvertebrateCard extends StatelessWidget {
  const InvertebrateCard({super.key, required this.invertebrate, this.onTap});

  final InvertebrateEntity invertebrate;
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
                    invertebrate.invertebrateType.icon,
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
                      invertebrate.displayName,
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
    parts.add(invertebrate.quantityDisplay);
    parts.add(invertebrate.waterType.displayName);
    return parts.join(' • ');
  }

  Color _getStatusColor(ColorScheme colorScheme) {
    if (invertebrate.isDeceased) {
      return colorScheme.surfaceContainerHighest;
    }
    if (invertebrate.isInQuarantine) {
      return colorScheme.tertiaryContainer;
    }
    if (invertebrate.isBreedingColony) {
      return colorScheme.secondaryContainer;
    }
    return colorScheme.primaryContainer;
  }

  Widget _buildStatusRow(BuildContext context, ColorScheme colorScheme) {
    if (invertebrate.isDeceased) {
      return Row(
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied,
            size: 14,
            color: colorScheme.outline,
          ),
          const SizedBox(width: 4),
          Text(
            'Deceased',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
          ),
        ],
      );
    }

    if (invertebrate.isInQuarantine) {
      return Row(
        children: [
          Icon(Icons.medical_services, size: 14, color: colorScheme.tertiary),
          const SizedBox(width: 4),
          Text(
            'Quarantined${invertebrate.quarantineDaysRemaining != null ? ' (${invertebrate.quarantineDaysRemaining} days left)' : ''}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.tertiary),
          ),
        ],
      );
    }

    if (invertebrate.isBreedingColony) {
      return Row(
        children: [
          Icon(Icons.family_restroom, size: 14, color: colorScheme.secondary),
          const SizedBox(width: 4),
          Text(
            'Breeding Colony • ${invertebrate.ageInTankDisplay}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(Icons.timer_outlined, size: 14, color: colorScheme.outline),
        const SizedBox(width: 4),
        Text(
          invertebrate.ageInTankDisplay,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
        ),
        if (invertebrate.sizeDisplay != 'Unknown') ...[
          const SizedBox(width: 8),
          Icon(Icons.straighten, size: 14, color: colorScheme.outline),
          const SizedBox(width: 4),
          Text(
            invertebrate.sizeDisplay,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
          ),
        ],
      ],
    );
  }
}
