import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/app_router.dart';
import '../../domain/entities/driftwood.dart';
import '../controllers/driftwood_provider.dart';

/// Driftwood detail screen - displays driftwood information and actions
class DriftwoodDetailScreen extends ConsumerStatefulWidget {
  const DriftwoodDetailScreen({super.key, required this.driftwood});

  final DriftwoodEntity driftwood;

  @override
  ConsumerState<DriftwoodDetailScreen> createState() =>
      _DriftwoodDetailScreenState();
}

class _DriftwoodDetailScreenState extends ConsumerState<DriftwoodDetailScreen> {
  late DriftwoodEntity _driftwood;

  @override
  void initState() {
    super.initState();
    _driftwood = widget.driftwood;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_driftwood.fullName),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editDriftwood),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              if (!_driftwood.isCured)
                const PopupMenuItem(
                  value: 'markCured',
                  child: Text('Mark as Cured'),
                ),
              PopupMenuItem(
                value: 'toggleTannin',
                child: Text(
                  _driftwood.isReleasingTannins
                      ? 'Stop Tannins'
                      : 'Start Tannins',
                ),
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
          if (_driftwood.notes != null && _driftwood.notes!.isNotEmpty) ...[
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
                color: _getStatusColor(colorScheme),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _driftwood.driftwoodType.icon,
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
                    _driftwood.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    _driftwood.quantityDisplay,
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

  Color _getStatusColor(ColorScheme colorScheme) {
    if (!_driftwood.isCured) return colorScheme.tertiaryContainer;
    if (_driftwood.isReleasingTannins) return colorScheme.secondaryContainer;
    return colorScheme.primaryContainer;
  }

  Widget _buildStatusChip(BuildContext context, ColorScheme colorScheme) {
    if (!_driftwood.isCured) {
      return Chip(
        label: Text(_driftwood.curingStatusDisplay),
        backgroundColor: colorScheme.tertiaryContainer,
        labelStyle: TextStyle(color: colorScheme.onTertiaryContainer),
      );
    }
    if (_driftwood.isReleasingTannins) {
      return Chip(
        label: const Text('Releasing Tannins'),
        backgroundColor: colorScheme.secondaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSecondaryContainer),
      );
    }
    return Chip(
      label: const Text('Stable'),
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
              _driftwood.driftwoodType.displayName,
            ),
            _buildDetailRow(
              context,
              'Tannin Level',
              _driftwood.tanninLevelDisplay,
            ),
            if (_driftwood.hasDimensions)
              _buildDetailRow(
                context,
                'Dimensions',
                _driftwood.dimensionsDisplay ?? '',
              ),
            if (_driftwood.timeInTankDisplay != null)
              _buildDetailRow(
                context,
                'In Tank',
                _driftwood.timeInTankDisplay!,
              ),
            if (_driftwood.source != null)
              _buildDetailRow(context, 'Source', _driftwood.source!),
            if (_driftwood.purchasePrice != null)
              _buildDetailRow(
                context,
                'Price',
                '\$${_driftwood.purchasePrice!.toStringAsFixed(2)}',
              ),
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
              _driftwood.notes!,
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
      case 'markCured':
        _markAsCured();
        break;
      case 'toggleTannin':
        _toggleTanninRelease();
        break;
      case 'delete':
        _deleteDriftwood();
        break;
    }
  }

  Future<void> _editDriftwood() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.driftwoodForm,
      arguments: {'tankId': _driftwood.tankId, 'driftwood': _driftwood},
    );
    if (result == true) {
      final updated = await ref.read(
        driftwoodByIdProvider(_driftwood.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _driftwood = updated);
      }
    }
  }

  Future<void> _markAsCured() async {
    try {
      await ref
          .read(driftwoodProvider(_driftwood.tankId).notifier)
          .markAsCured(_driftwood);
      final updated = await ref.read(
        driftwoodByIdProvider(_driftwood.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _driftwood = updated);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Marked as cured')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _toggleTanninRelease() async {
    try {
      await ref
          .read(driftwoodProvider(_driftwood.tankId).notifier)
          .toggleTanninRelease(_driftwood);
      final updated = await ref.read(
        driftwoodByIdProvider(_driftwood.id!).future,
      );
      if (updated != null && mounted) {
        setState(() => _driftwood = updated);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _deleteDriftwood() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Driftwood'),
        content: Text(
          'Are you sure you want to delete "${_driftwood.fullName}"?',
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
            .read(driftwoodProvider(_driftwood.tankId).notifier)
            .deleteDriftwood(_driftwood.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Driftwood deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting driftwood: $e')),
          );
        }
      }
    }
  }
}
