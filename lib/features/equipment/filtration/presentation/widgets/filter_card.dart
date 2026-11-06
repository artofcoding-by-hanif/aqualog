import 'package:flutter/material.dart';

import '../../domain/entities/filter.dart';

/// Filter card widget for displaying filter summary
class FilterCard extends StatelessWidget {
  const FilterCard({super.key, required this.filter, this.onTap});

  final FilterEntity filter;
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
                    filter.filterType.icon,
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
                      filter.name,
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
                    _buildMaintenanceStatus(context, colorScheme),
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
    parts.add(filter.filterType.displayName);
    if (filter.brand != null || filter.model != null) {
      final brandModel = [
        filter.brand,
        filter.model,
      ].where((s) => s != null && s.isNotEmpty).join(' ');
      if (brandModel.isNotEmpty) {
        parts.add(brandModel);
      }
    }
    if (filter.flowRateLph != null) {
      parts.add('${filter.flowRateLph!.toInt()} L/h');
    }
    return parts.join(' • ');
  }

  Color _getStatusColor(ColorScheme colorScheme) {
    if (filter.isCleaningDue || filter.isMediaReplacementDue) {
      return colorScheme.errorContainer;
    }
    return colorScheme.primaryContainer;
  }

  Widget _buildMaintenanceStatus(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    final status = filter.maintenanceStatus;
    final isOverdue = filter.isCleaningDue || filter.isMediaReplacementDue;

    return Row(
      children: [
        Icon(
          isOverdue ? Icons.warning_amber_rounded : Icons.check_circle_outline,
          size: 14,
          color: isOverdue ? colorScheme.error : colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isOverdue ? colorScheme.error : colorScheme.outline,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
