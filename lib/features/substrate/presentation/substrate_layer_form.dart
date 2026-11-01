import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/substrate_layer.dart';
import 'controllers/substrate_layer_provider.dart';
import '../../../core/theme/color_scheme.dart';

/// Substrate layer form screen for adding/editing substrate layers
class SubstrateLayerFormScreen extends ConsumerStatefulWidget {
  const SubstrateLayerFormScreen({
    super.key,
    required this.tankId,
    this.layer,
    this.nextLayerOrder = 0,
  });

  /// Tank ID this layer belongs to
  final int tankId;

  /// Existing layer for edit mode (null for add mode)
  final SubstrateLayerEntity? layer;

  /// Next layer order for new layers
  final int nextLayerOrder;

  bool get isEditing => layer != null;

  @override
  ConsumerState<SubstrateLayerFormScreen> createState() =>
      _SubstrateLayerFormScreenState();
}

class _SubstrateLayerFormScreenState
    extends ConsumerState<SubstrateLayerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _depthController = TextEditingController();
  final _volumeController = TextEditingController();
  final _weightController = TextEditingController();
  final _colorController = TextEditingController();
  final _sourceController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  SubstrateType _substrateType = SubstrateType.gravel;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.layer != null) {
      _nameController.text = widget.layer!.name;
      _brandController.text = widget.layer!.brand ?? '';
      _depthController.text = widget.layer!.depthCm?.toString() ?? '';
      _volumeController.text = widget.layer!.volumeLiters?.toString() ?? '';
      _weightController.text = widget.layer!.weightKg?.toString() ?? '';
      _colorController.text = widget.layer!.color ?? '';
      _sourceController.text = widget.layer!.source ?? '';
      _priceController.text = widget.layer!.purchasePrice?.toString() ?? '';
      _notesController.text = widget.layer!.notes ?? '';
      _substrateType = widget.layer!.substrateType;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _depthController.dispose();
    _volumeController.dispose();
    _weightController.dispose();
    _colorController.dispose();
    _sourceController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Substrate Layer' : 'Add Substrate Layer',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Layer Name',
                hintText: 'e.g., Bottom Layer, Cap Layer',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            // Substrate type dropdown
            DropdownButtonFormField<SubstrateType>(
              value: _substrateType,
              decoration: const InputDecoration(labelText: 'Substrate Type'),
              items: SubstrateType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Text(type.icon),
                      const SizedBox(width: 8),
                      Text(type.displayName),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _substrateType = value);
              },
            ),
            const SizedBox(height: 8),
            // Substrate description
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _substrateType.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        if (_substrateType.isNutrientRich)
                          _buildChip('Nutrient Rich', AquaPalette.healthy),
                        if (_substrateType.affectsWaterChemistry)
                          _buildChip('Affects Water', AquaPalette.caution),
                        if (_substrateType.isInert)
                          _buildChip('Inert', AquaPalette.azure),
                        _buildChip(_substrateType.grainSize, AquaPalette.mist),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Brand field
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(
                labelText: 'Brand (optional)',
                hintText: 'e.g., ADA, Fluval, Seachem',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            // Depth and Color row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _depthController,
                    decoration: const InputDecoration(
                      labelText: 'Depth (cm)',
                      hintText: 'e.g., 2.5',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _colorController,
                    decoration: const InputDecoration(
                      labelText: 'Color (optional)',
                      hintText: 'e.g., Black, Natural',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Volume and Weight row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _volumeController,
                    decoration: const InputDecoration(
                      labelText: 'Volume (L)',
                      hintText: 'e.g., 9',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      hintText: 'e.g., 9',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Source field
            TextFormField(
              controller: _sourceController,
              decoration: const InputDecoration(
                labelText: 'Source (optional)',
                hintText: 'e.g., Local fish store, Amazon',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            // Price field
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price (optional)',
                prefixText: '\$ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 16),
            // Notes field
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                hintText: 'Any additional notes...',
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            // Save button
            FilledButton(
              onPressed: _isSaving ? null : _saveLayer,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Layer' : 'Save Layer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 10)),
      backgroundColor: color.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: color.withValues(alpha: 0.8)),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  Future<void> _saveLayer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final layer = SubstrateLayerEntity(
        id: widget.layer?.id,
        tankId: widget.tankId,
        name: _nameController.text.trim(),
        substrateType: _substrateType,
        brand: _brandController.text.trim().isEmpty
            ? null
            : _brandController.text.trim(),
        depthCm: double.tryParse(_depthController.text),
        layerOrder: widget.layer?.layerOrder ?? widget.nextLayerOrder,
        volumeLiters: double.tryParse(_volumeController.text),
        weightKg: double.tryParse(_weightController.text),
        color: _colorController.text.trim().isEmpty
            ? null
            : _colorController.text.trim(),
        purchasePrice: double.tryParse(_priceController.text),
        source: _sourceController.text.trim().isEmpty
            ? null
            : _sourceController.text.trim(),
        dateAdded: widget.layer?.dateAdded ?? DateTime.now(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        createdAt: widget.layer?.createdAt,
      );

      final notifier = ref.read(substrateLayerProvider.notifier);

      if (widget.isEditing) {
        await notifier.updateLayer(layer);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Layer updated')));
        }
      } else {
        await notifier.addLayer(layer);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Layer added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving layer: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
