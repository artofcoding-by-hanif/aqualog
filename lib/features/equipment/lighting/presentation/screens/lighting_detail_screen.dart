import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../router/app_router.dart';
import '../../domain/entities/lighting.dart';
import '../controllers/lighting_provider.dart';

/// Lighting detail screen - displays lighting information and actions
class LightingDetailScreen extends ConsumerStatefulWidget {
  const LightingDetailScreen({super.key, required this.lighting});

  final LightingEntity lighting;

  @override
  ConsumerState<LightingDetailScreen> createState() =>
      _LightingDetailScreenState();
}

class _LightingDetailScreenState extends ConsumerState<LightingDetailScreen> {
  late LightingEntity _lighting;

  @override
  void initState() {
    super.initState();
    _lighting = widget.lighting;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_lighting.name),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editLighting),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') _deleteLighting();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(context, colorScheme),
          const SizedBox(height: 24),
          _buildScheduleSection(context, colorScheme),
          const SizedBox(height: 24),
          _buildMaintenanceSection(context, colorScheme),
          const SizedBox(height: 24),
          _buildDetailsSection(context, colorScheme),
          if (_lighting.notes != null && _lighting.notes!.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildNotesSection(context, colorScheme),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _lighting.lightingType.icon,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _lighting.lightingType.displayName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (_lighting.brand != null || _lighting.model != null)
                    Text(
                      [
                        _lighting.brand,
                        _lighting.model,
                      ].where((s) => s != null).join(' '),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  if (_lighting.wattage != null)
                    Text(
                      _lighting.wattageDisplay!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Schedule', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.schedule, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photoperiod',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        _lighting.photoperiodDisplay ?? 'Not set',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_lighting.intensityPercent != 100) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.brightness_6, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Intensity',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${_lighting.intensityPercent}%',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceSection(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Maintenance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  color: _lighting.isReplacementDue
                      ? colorScheme.error
                      : colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Replaced',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        _lighting.lastReplacedAt != null
                            ? '${_lighting.daysSinceReplaced} days ago'
                            : 'Never',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _lighting.isReplacementDue
                              ? colorScheme.error
                              : null,
                          fontWeight: _lighting.isReplacementDue
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _recordReplacement,
                  child: const Text('Record Replacement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              'Replacement Interval',
              '${_lighting.replacementIntervalDays} days',
            ),
            if (_lighting.kelvinRating != null)
              _buildDetailRow(
                context,
                'Color Temperature',
                _lighting.kelvinDisplay ?? '${_lighting.kelvinRating}K',
              ),
            if (_lighting.spectrum != null)
              _buildDetailRow(
                context,
                'Spectrum',
                _lighting.spectrum!.displayName,
              ),
            if (_lighting.parValue != null)
              _buildDetailRow(context, 'PAR Value', _lighting.parDisplay ?? ''),
            if (_lighting.lumens != null)
              _buildDetailRow(context, 'Lumens', '${_lighting.lumens} lm'),
            _buildDetailRow(context, 'Features', _lighting.featuresDisplay),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              _lighting.notes!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editLighting() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.lightingForm,
      arguments: {'tankId': _lighting.tankId, 'lighting': _lighting},
    );
    if (result == true) {
      final updated = await ref.read(
        lightingByIdProvider(_lighting.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _lighting = updated);
      }
    }
  }

  Future<void> _deleteLighting() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lighting'),
        content: Text('Are you sure you want to delete "${_lighting.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref
            .read(lightingProvider(_lighting.tankId).notifier)
            .deleteLighting(_lighting.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Lighting deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting lighting: $e')),
          );
        }
      }
    }
  }

  Future<void> _recordReplacement() async {
    try {
      await ref
          .read(lightingProvider(_lighting.tankId).notifier)
          .recordReplacement(_lighting);
      final updated = await ref.read(
        lightingByIdProvider(_lighting.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _lighting = updated);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Replacement recorded')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
