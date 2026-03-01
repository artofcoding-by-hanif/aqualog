import 'package:flutter/material.dart';

import '../../domain/entities/rock.dart';

/// Rock card widget for displaying rock summary
class RockCard extends StatelessWidget {
  const RockCard({super.key, required this.rock, this.onTap});

  final RockEntity rock;
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
                  color: rock.mayAffectWaterChemistry
                      ? colorScheme.tertiaryContainer
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    rock.rockType.icon,
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
                      rock.fullName,
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
    parts.add(rock.quantityDisplay);
    if (rock.weightKg != null && rock.weightDisplay() != null) {
      parts.add(rock.weightDisplay()!);
    }
    if (rock.hasDimensions && rock.dimensionsDisplay != null) {
      parts.add(rock.dimensionsDisplay!);
    }
    return parts.join(' • ');
  }

  Widget _buildStatusRow(BuildContext context, ColorScheme colorScheme) {
    final widgets = <Widget>[];

    // Time in tank
    if (rock.timeInTankDisplay != null) {
      widgets.add(
        Icon(Icons.timer_outlined, size: 14, color: colorScheme.outline),
      );
      widgets.add(const SizedBox(width: 4));
      widgets.add(
        Text(
          rock.timeInTankDisplay!,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
        ),
      );
    }

    // Water chemistry warning
    if (rock.mayAffectWaterChemistry) {
      widgets.add(const SizedBox(width: 8));
      widgets.add(
        Icon(Icons.warning_amber, size: 14, color: colorScheme.tertiary),
      );
      widgets.add(const SizedBox(width: 4));
      widgets.add(
        Text(
          'May affect pH',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.tertiary),
        ),
      );
    }

    return Row(children: widgets);
  }
}
