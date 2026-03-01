import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../router/app_router.dart';
import '../../domain/entities/invertebrate.dart';
import '../controllers/invertebrate_provider.dart';

/// Invertebrate detail screen - displays invertebrate information and actions
class InvertebrateDetailScreen extends ConsumerStatefulWidget {
  const InvertebrateDetailScreen({super.key, required this.invertebrate});

  final InvertebrateEntity invertebrate;

  @override
  ConsumerState<InvertebrateDetailScreen> createState() =>
      _InvertebrateDetailScreenState();
}

class _InvertebrateDetailScreenState
    extends ConsumerState<InvertebrateDetailScreen> {
  late InvertebrateEntity _invertebrate;

  @override
  void initState() {
    super.initState();
    _invertebrate = widget.invertebrate;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_invertebrate.displayName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editInvertebrate,
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              if (_invertebrate.isAlive && !_invertebrate.isInQuarantine)
                const PopupMenuItem(
                  value: 'quarantine',
                  child: Text('Start Quarantine'),
                ),
              if (_invertebrate.isInQuarantine)
                const PopupMenuItem(
                  value: 'endQuarantine',
                  child: Text('End Quarantine'),
                ),
              if (_invertebrate.isAlive &&
                  _invertebrate.invertebrateType == InvertebrateType.shrimp)
                PopupMenuItem(
                  value: 'toggleColony',
                  child: Text(
                    _invertebrate.isBreedingColony
                        ? 'Mark as Individual'
                        : 'Mark as Colony',
                  ),
                ),
              if (_invertebrate.isAlive)
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
          if (_invertebrate.temperatureRangeDisplay != null ||
              _invertebrate.phRangeDisplay != null) ...[
            const SizedBox(height: 24),
            _buildParametersSection(context, colorScheme),
          ],
          if (_invertebrate.notes != null &&
              _invertebrate.notes!.isNotEmpty) ...[
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
                color: _invertebrate.isDeceased
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _invertebrate.invertebrateType.icon,
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
                    _invertebrate.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    _invertebrate.quantityDisplay,
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
    if (_invertebrate.isDeceased) {
      return Chip(
        label: const Text('Deceased'),
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(color: colorScheme.outline),
      );
    }
    if (_invertebrate.isInQuarantine) {
      return Chip(
        label: Text(
          'Quarantined${_invertebrate.quarantineDaysRemaining != null ? ' (${_invertebrate.quarantineDaysRemaining}d left)' : ''}',
        ),
        backgroundColor: colorScheme.tertiaryContainer,
        labelStyle: TextStyle(color: colorScheme.onTertiaryContainer),
      );
    }
    if (_invertebrate.isBreedingColony) {
      return Chip(
        label: const Text('Breeding Colony'),
        backgroundColor: colorScheme.secondaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSecondaryContainer),
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
            _buildDetailRow(
              context,
              'Type',
              _invertebrate.invertebrateType.displayName,
            ),
            _buildDetailRow(
              context,
              'Water Type',
              _invertebrate.waterType.displayName,
            ),
            if (_invertebrate.careLevel != null)
              _buildDetailRow(
                context,
                'Care Level',
                _invertebrate.careLevel!.displayName,
              ),
            if (_invertebrate.sizeDisplay != 'Unknown')
              _buildDetailRow(context, 'Size', _invertebrate.sizeDisplay),
            _buildDetailRow(context, 'In Tank', _invertebrate.ageInTankDisplay),
            if (_invertebrate.lifespanYears != null)
              _buildDetailRow(
                context,
                'Lifespan',
                '${_invertebrate.lifespanYears} years',
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
            if (_invertebrate.temperatureRangeDisplay != null)
              _buildDetailRow(
                context,
                'Temperature',
                _invertebrate.temperatureRangeDisplay!,
              ),
            if (_invertebrate.phRangeDisplay != null)
              _buildDetailRow(context, 'pH', _invertebrate.phRangeDisplay!),
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
            Text(
              _invertebrate.notes!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
      case 'toggleColony':
        _toggleBreedingColony();
        break;
      case 'recordDeath':
        _recordDeath();
        break;
      case 'delete':
        _deleteInvertebrate();
        break;
    }
  }

  Future<void> _editInvertebrate() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.invertebrateForm,
      arguments: {
        'tankId': _invertebrate.tankId,
        'invertebrate': _invertebrate,
      },
    );
    if (result == true) {
      final updated = await ref.read(
        invertebrateByIdProvider(_invertebrate.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _invertebrate = updated);
      }
    }
  }

  Future<void> _deleteInvertebrate() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Invertebrate'),
        content: Text(
          'Are you sure you want to delete "${_invertebrate.displayName}"?',
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
            .read(invertebrateProvider(_invertebrate.tankId).notifier)
            .deleteInvertebrate(_invertebrate.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Invertebrate deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting invertebrate: $e')),
          );
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
            .read(invertebrateProvider(_invertebrate.tankId).notifier)
            .startQuarantine(_invertebrate, endDate);
        final updated = await ref.read(
          invertebrateByIdProvider(_invertebrate.id!).future,
        );
        if (updated != null && mounted) {
          setState(() => _invertebrate = updated);
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
      await ref
          .read(invertebrateProvider(_invertebrate.tankId).notifier)
          .endQuarantine(_invertebrate);
      final updated = await ref.read(
        invertebrateByIdProvider(_invertebrate.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _invertebrate = updated);
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

  Future<void> _toggleBreedingColony() async {
    try {
      await ref
          .read(invertebrateProvider(_invertebrate.tankId).notifier)
          .toggleBreedingColony(_invertebrate);
      final updated = await ref.read(
        invertebrateByIdProvider(_invertebrate.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _invertebrate = updated);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              updated.isBreedingColony
                  ? 'Marked as colony'
                  : 'Marked as individual',
            ),
          ),
        );
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
        content: Text('Record death for "${_invertebrate.displayName}"?'),
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
        await ref
            .read(invertebrateProvider(_invertebrate.tankId).notifier)
            .recordDeath(_invertebrate);
        final updated = await ref.read(
          invertebrateByIdProvider(_invertebrate.id!).future,
        );
        if (updated != null && mounted) {
          setState(() => _invertebrate = updated);
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
