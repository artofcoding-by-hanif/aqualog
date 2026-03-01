import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/app_router.dart';
import '../../domain/entities/rock.dart';
import '../controllers/rock_provider.dart';

/// Rock detail screen - displays rock information and actions
class RockDetailScreen extends ConsumerStatefulWidget {
  const RockDetailScreen({super.key, required this.rock});

  final RockEntity rock;

  @override
  ConsumerState<RockDetailScreen> createState() => _RockDetailScreenState();
}

class _RockDetailScreenState extends ConsumerState<RockDetailScreen> {
  late RockEntity _rock;

  @override
  void initState() {
    super.initState();
    _rock = widget.rock;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_rock.fullName),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editRock),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
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
          _buildDetailsSection(context, colorScheme),
          if (_rock.notes != null && _rock.notes!.isNotEmpty) ...[
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
                color: _rock.mayAffectWaterChemistry
                    ? colorScheme.tertiaryContainer
                    : colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _rock.rockType.icon,
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
                    _rock.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    _rock.quantityDisplay,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (_rock.mayAffectWaterChemistry)
                    Chip(
                      label: Text(
                        _rock.waterChemistryWarning ?? 'May affect pH',
                      ),
                      backgroundColor: colorScheme.tertiaryContainer,
                      labelStyle: TextStyle(
                        color: colorScheme.onTertiaryContainer,
                      ),
                    )
                  else
                    Chip(
                      label: const Text('Inert'),
                      backgroundColor: colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        color: colorScheme.onPrimaryContainer,
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

  Widget _buildDetailsSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            _buildDetailRow(context, 'Type', _rock.rockType.displayName),
            if (_rock.weightKg != null)
              _buildDetailRow(context, 'Weight', _rock.weightDisplay() ?? ''),
            if (_rock.hasDimensions)
              _buildDetailRow(
                context,
                'Dimensions',
                _rock.dimensionsDisplay ?? '',
              ),
            if (_rock.timeInTankDisplay != null)
              _buildDetailRow(context, 'In Tank', _rock.timeInTankDisplay!),
            if (_rock.source != null)
              _buildDetailRow(context, 'Source', _rock.source!),
            if (_rock.purchasePrice != null)
              _buildDetailRow(
                context,
                'Price',
                '\$${_rock.purchasePrice!.toStringAsFixed(2)}',
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
            Text(_rock.notes!, style: Theme.of(context).textTheme.bodyMedium),
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
      case 'delete':
        _deleteRock();
        break;
    }
  }

  Future<void> _editRock() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.rockForm,
      arguments: {'tankId': _rock.tankId, 'rock': _rock},
    );
    if (result == true) {
      final updated = await ref.read(rockByIdProvider(_rock.id!).future);
      if (updated != null && mounted) {
        setState(() => _rock = updated);
      }
    }
  }

  Future<void> _deleteRock() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Rock'),
        content: Text('Are you sure you want to delete "${_rock.fullName}"?'),
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
            .read(rockProvider(_rock.tankId).notifier)
            .deleteRock(_rock.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Rock deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting rock: $e')));
        }
      }
    }
  }
}
