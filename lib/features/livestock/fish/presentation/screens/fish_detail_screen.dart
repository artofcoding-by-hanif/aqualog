import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../router/app_router.dart';
import '../../domain/entities/fish.dart';
import '../controllers/fish_provider.dart';

/// Fish detail screen - displays fish information and actions
class FishDetailScreen extends ConsumerStatefulWidget {
  const FishDetailScreen({super.key, required this.fish});

  final FishEntity fish;

  @override
  ConsumerState<FishDetailScreen> createState() => _FishDetailScreenState();
}

class _FishDetailScreenState extends ConsumerState<FishDetailScreen> {
  late FishEntity _fish;

  @override
  void initState() {
    super.initState();
    _fish = widget.fish;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_fish.displayName),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editFish),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              if (_fish.isAlive && !_fish.isInQuarantine)
                const PopupMenuItem(
                  value: 'quarantine',
                  child: Text('Start Quarantine'),
                ),
              if (_fish.isInQuarantine)
                const PopupMenuItem(
                  value: 'endQuarantine',
                  child: Text('End Quarantine'),
                ),
              if (_fish.isAlive)
                const PopupMenuItem(
                  value: 'recordDeath',
                  child: Text('Record Death'),
                ),
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
          _buildDetailsSection(context, colorScheme),
          if (_fish.temperatureRangeDisplay != null ||
              _fish.phRangeDisplay != null) ...[
            const SizedBox(height: 24),
            _buildParametersSection(context, colorScheme),
          ],
          if (_fish.notes != null && _fish.notes!.isNotEmpty) ...[
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
                color: _fish.isDeceased
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('🐟', style: TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _fish.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    _fish.quantityDisplay,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildStatusChip(context, colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, ColorScheme colorScheme) {
    if (_fish.isDeceased) {
      return Chip(
        label: const Text('Deceased'),
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(color: colorScheme.outline),
      );
    }
    if (_fish.isInQuarantine) {
      return Chip(
        label: Text(
          'Quarantined${_fish.quarantineDaysRemaining != null ? ' (${_fish.quarantineDaysRemaining}d left)' : ''}',
        ),
        backgroundColor: colorScheme.tertiaryContainer,
        labelStyle: TextStyle(color: colorScheme.onTertiaryContainer),
      );
    }
    return Chip(
      label: const Text('Active'),
      backgroundColor: colorScheme.primaryContainer,
      labelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
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
            _buildDetailRow(context, 'Water Type', _fish.waterType.displayName),
            if (_fish.temperament != null)
              _buildDetailRow(
                context,
                'Temperament',
                _fish.temperament!.displayName,
              ),
            if (_fish.diet != null)
              _buildDetailRow(context, 'Diet', _fish.diet!.displayName),
            if (_fish.careLevel != null)
              _buildDetailRow(
                context,
                'Care Level',
                _fish.careLevel!.displayName,
              ),
            if (_fish.swimmingLevel != null)
              _buildDetailRow(
                context,
                'Swimming Level',
                _fish.swimmingLevel!.displayName,
              ),
            if (_fish.sizeDisplay != 'Unknown')
              _buildDetailRow(context, 'Size', _fish.sizeDisplay),
            _buildDetailRow(context, 'In Tank', _fish.ageInTankDisplay),
            if (_fish.lifespanYears != null)
              _buildDetailRow(
                context,
                'Lifespan',
                '${_fish.lifespanYears} years',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildParametersSection(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Water Parameters',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (_fish.temperatureRangeDisplay != null)
              _buildDetailRow(
                context,
                'Temperature',
                _fish.temperatureRangeDisplay!,
              ),
            if (_fish.phRangeDisplay != null)
              _buildDetailRow(context, 'pH', _fish.phRangeDisplay!),
          ],
        ),
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
            Text(_fish.notes!, style: Theme.of(context).textTheme.bodyMedium),
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
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  void _handleMenuAction(String value) {
    switch (value) {
      case 'quarantine':
        _startQuarantine();
        break;
      case 'endQuarantine':
        _endQuarantine();
        break;
      case 'recordDeath':
        _recordDeath();
        break;
      case 'delete':
        _deleteFish();
        break;
    }
  }

  Future<void> _editFish() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.fishForm,
      arguments: {'tankId': _fish.tankId, 'fish': _fish},
    );
    if (result == true) {
      final updated = await ref.read(fishByIdProvider(_fish.id!).future);
      if (updated != null && mounted) {
        setState(() => _fish = updated);
      }
    }
  }

  Future<void> _deleteFish() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Fish'),
        content: Text(
          'Are you sure you want to delete "${_fish.displayName}"?',
        ),
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
            .read(fishProvider(_fish.tankId).notifier)
            .deleteFish(_fish.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Fish deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting fish: $e')));
        }
      }
    }
  }

  Future<void> _startQuarantine() async {
    final endDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 14)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      helpText: 'Select quarantine end date',
    );

    if (endDate != null && mounted) {
      try {
        await ref
            .read(fishProvider(_fish.tankId).notifier)
            .startQuarantine(_fish, endDate);
        final updated = await ref.read(fishByIdProvider(_fish.id!).future);
        if (updated != null && mounted) {
          setState(() => _fish = updated);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Quarantine started')));
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

  Future<void> _endQuarantine() async {
    try {
      await ref.read(fishProvider(_fish.tankId).notifier).endQuarantine(_fish);
      final updated = await ref.read(fishByIdProvider(_fish.id!).future);
      if (updated != null && mounted) {
        setState(() => _fish = updated);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Quarantine ended')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _recordDeath() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Record Death'),
        content: Text('Record death for "${_fish.displayName}"?'),
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
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref.read(fishProvider(_fish.tankId).notifier).recordDeath(_fish);
        final updated = await ref.read(fishByIdProvider(_fish.id!).future);
        if (updated != null && mounted) {
          setState(() => _fish = updated);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Death recorded')));
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
}
