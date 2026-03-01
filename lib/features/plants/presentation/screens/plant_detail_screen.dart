import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/app_router.dart';
import '../../domain/entities/plant.dart';
import '../controllers/plant_provider.dart';

/// Plant detail screen - displays plant information and actions
class PlantDetailScreen extends ConsumerStatefulWidget {
  const PlantDetailScreen({super.key, required this.plant});

  final PlantEntity plant;

  @override
  ConsumerState<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends ConsumerState<PlantDetailScreen> {
  late PlantEntity _plant;

  @override
  void initState() {
    super.initState();
    _plant = widget.plant;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_plant.displayName),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editPlant),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              if (_plant.isActive)
                const PopupMenuItem(
                  value: 'propagate',
                  child: Text('Propagate'),
                ),
              if (_plant.isActive)
                const PopupMenuItem(
                  value: 'recordRemoval',
                  child: Text('Record Removal'),
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
          if (_plant.temperatureRangeDisplay != null ||
              _plant.phRangeDisplay != null) ...[
            const SizedBox(height: 24),
            _buildParametersSection(context, colorScheme),
          ],
          if (_plant.requirementsSummary.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildRequirementsSection(context, colorScheme),
          ],
          if (_plant.notes != null && _plant.notes!.isNotEmpty) ...[
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
                color: _plant.isRemoved
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _plant.plantType.icon,
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
                    _plant.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    _plant.quantityDisplay,
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
    if (_plant.isRemoved) {
      return Chip(
        label: const Text('Removed'),
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(color: colorScheme.outline),
      );
    }
    if (_plant.isPropagated) {
      return Chip(
        label: const Text('Propagated'),
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
            _buildDetailRow(context, 'Type', _plant.typeWithIcon),
            if (_plant.placementZone != null)
              _buildDetailRow(
                context,
                'Placement',
                _plant.placementZone!.displayName,
              ),
            if (_plant.heightDisplay != null)
              _buildDetailRow(context, 'Height', _plant.heightDisplay!),
            if (_plant.daysInTank != null)
              _buildDetailRow(context, 'In Tank', '${_plant.daysInTank} days'),
            if (_plant.source != null)
              _buildDetailRow(context, 'Source', _plant.source!),
            if (_plant.purchasePrice != null)
              _buildDetailRow(
                context,
                'Price',
                '\$${_plant.purchasePrice!.toStringAsFixed(2)}',
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
            if (_plant.temperatureRangeDisplay != null)
              _buildDetailRow(
                context,
                'Temperature',
                _plant.temperatureRangeDisplay!,
              ),
            if (_plant.phRangeDisplay != null)
              _buildDetailRow(context, 'pH', _plant.phRangeDisplay!),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementsSection(
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
              'Requirements',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (_plant.lightingRequirement != null)
              _buildDetailRow(
                context,
                'Lighting',
                '${_plant.lightingRequirement!.icon} ${_plant.lightingRequirement!.displayName}',
              ),
            _buildDetailRow(
              context,
              'CO2',
              '${_plant.co2Requirement.icon} ${_plant.co2Requirement.displayName}',
            ),
            if (_plant.growthRate != null)
              _buildDetailRow(
                context,
                'Growth Rate',
                '${_plant.growthRate!.icon} ${_plant.growthRate!.displayName}',
              ),
            if (_plant.difficultyLevel != null)
              _buildDetailRow(
                context,
                'Difficulty',
                '${_plant.difficultyLevel!.icon} ${_plant.difficultyLevel!.displayName}',
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
            Text(_plant.notes!, style: Theme.of(context).textTheme.bodyMedium),
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
      case 'propagate':
        _propagatePlant();
        break;
      case 'recordRemoval':
        _recordRemoval();
        break;
      case 'delete':
        _deletePlant();
        break;
    }
  }

  Future<void> _editPlant() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.plantForm,
      arguments: {'tankId': _plant.tankId, 'plant': _plant},
    );
    if (result == true) {
      final updated = await ref.read(plantByIdProvider(_plant.id!).future);
      if (updated != null && mounted) {
        setState(() => _plant = updated);
      }
    }
  }

  Future<void> _deletePlant() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plant'),
        content: Text(
          'Are you sure you want to delete "${_plant.displayName}"?',
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
            .read(plantProvider(_plant.tankId).notifier)
            .deletePlant(_plant.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Plant deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting plant: $e')));
        }
      }
    }
  }

  Future<void> _recordRemoval() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Record Removal'),
        content: Text('Record removal for "${_plant.displayName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref
            .read(plantProvider(_plant.tankId).notifier)
            .recordRemoval(_plant);
        final updated = await ref.read(plantByIdProvider(_plant.id!).future);
        if (updated != null && mounted) {
          setState(() => _plant = updated);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Removal recorded')));
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

  Future<void> _propagatePlant() async {
    final quantityController = TextEditingController(text: '1');

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Propagate Plant'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create a propagation from "${_plant.displayName}"?'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Propagate'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final quantity = int.tryParse(quantityController.text) ?? 1;
        await ref
            .read(plantProvider(_plant.tankId).notifier)
            .propagatePlant(_plant, quantity: quantity);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Plant propagated')));
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
