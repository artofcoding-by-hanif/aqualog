import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/plant.dart';
import 'controllers/plant_provider.dart';

/// Plant form screen for adding/editing plants
class PlantFormScreen extends ConsumerStatefulWidget {
  const PlantFormScreen({super.key, required this.tankId, this.plant});

  /// Tank ID this plant belongs to
  final int tankId;

  /// Existing plant for edit mode (null for add mode)
  final PlantEntity? plant;

  bool get isEditing => plant != null;

  @override
  ConsumerState<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends ConsumerState<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _speciesController = TextEditingController();
  final _commonNameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();
  final _maxHeightController = TextEditingController();
  final _currentHeightController = TextEditingController();
  final _sourceController = TextEditingController();
  final _priceController = TextEditingController();

  PlantType _plantType = PlantType.stem;
  PlacementZone? _placementZone;
  LightingRequirement? _lightingRequirement;
  CO2Requirement _co2Requirement = CO2Requirement.none;
  GrowthRate? _growthRate;
  PlantDifficultyLevel? _difficultyLevel;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.plant != null) {
      _speciesController.text = widget.plant!.species;
      _commonNameController.text = widget.plant!.commonName ?? '';
      _quantityController.text = widget.plant!.quantity.toString();
      _notesController.text = widget.plant!.notes ?? '';
      _maxHeightController.text = widget.plant!.maxHeightCm?.toString() ?? '';
      _currentHeightController.text =
          widget.plant!.currentHeightCm?.toString() ?? '';
      _sourceController.text = widget.plant!.source ?? '';
      _priceController.text = widget.plant!.purchasePrice?.toString() ?? '';
      _plantType = widget.plant!.plantType;
      _placementZone = widget.plant!.placementZone;
      _lightingRequirement = widget.plant!.lightingRequirement;
      _co2Requirement = widget.plant!.co2Requirement;
      _growthRate = widget.plant!.growthRate;
      _difficultyLevel = widget.plant!.difficultyLevel;
    }
  }

  @override
  void dispose() {
    _speciesController.dispose();
    _commonNameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    _maxHeightController.dispose();
    _currentHeightController.dispose();
    _sourceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Plant' : 'Add Plant'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _speciesController,
              decoration: const InputDecoration(
                labelText: 'Species',
                hintText: 'e.g., Anubias barteri',
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the species';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _commonNameController,
              decoration: const InputDecoration(
                labelText: 'Common Name (optional)',
                hintText: 'e.g., Anubias',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      if (int.tryParse(value) == null || int.parse(value) < 1) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<PlantType>(
                    value: _plantType,
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: PlantType.values.map((type) {
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
                      if (value != null) setState(() => _plantType = value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<PlacementZone?>(
              value: _placementZone,
              decoration: const InputDecoration(labelText: 'Placement Zone'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...PlacementZone.values.map((type) {
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
                }),
              ],
              onChanged: (value) => setState(() => _placementZone = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LightingRequirement?>(
              value: _lightingRequirement,
              decoration: const InputDecoration(labelText: 'Lighting'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...LightingRequirement.values.map((type) {
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
                }),
              ],
              onChanged: (value) =>
                  setState(() => _lightingRequirement = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<CO2Requirement>(
              value: _co2Requirement,
              decoration: const InputDecoration(labelText: 'CO2 Requirement'),
              items: CO2Requirement.values.map((type) {
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
                if (value != null) setState(() => _co2Requirement = value);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<GrowthRate?>(
                    value: _growthRate,
                    decoration: const InputDecoration(labelText: 'Growth Rate'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Not specified'),
                      ),
                      ...GrowthRate.values.map((type) {
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
                      }),
                    ],
                    onChanged: (value) => setState(() => _growthRate = value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<PlantDifficultyLevel?>(
                    value: _difficultyLevel,
                    decoration: const InputDecoration(labelText: 'Difficulty'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Not specified'),
                      ),
                      ...PlantDifficultyLevel.values.map((type) {
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
                      }),
                    ],
                    onChanged: (value) =>
                        setState(() => _difficultyLevel = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _maxHeightController,
                    decoration: const InputDecoration(
                      labelText: 'Max Height (cm)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _currentHeightController,
                    decoration: const InputDecoration(
                      labelText: 'Current Height (cm)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _sourceController,
                    decoration: const InputDecoration(
                      labelText: 'Source (optional)',
                      hintText: 'e.g., Local store',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price (optional)',
                      prefixText: '\$ ',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
            FilledButton(
              onPressed: _isSaving ? null : _savePlant,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Plant' : 'Save Plant'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePlant() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final plant = PlantEntity(
        id: widget.plant?.id,
        tankId: widget.tankId,
        species: _speciesController.text.trim(),
        commonName: _commonNameController.text.trim().isEmpty
            ? null
            : _commonNameController.text.trim(),
        plantType: _plantType,
        quantity: int.parse(_quantityController.text),
        placementZone: _placementZone,
        lightingRequirement: _lightingRequirement,
        co2Requirement: _co2Requirement,
        growthRate: _growthRate,
        difficultyLevel: _difficultyLevel,
        maxHeightCm: _maxHeightController.text.isEmpty
            ? null
            : double.tryParse(_maxHeightController.text),
        currentHeightCm: _currentHeightController.text.isEmpty
            ? null
            : double.tryParse(_currentHeightController.text),
        source: _sourceController.text.trim().isEmpty
            ? null
            : _sourceController.text.trim(),
        purchasePrice: _priceController.text.isEmpty
            ? null
            : double.tryParse(_priceController.text),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        dateAdded: widget.plant?.dateAdded ?? DateTime.now(),
        dateRemoved: widget.plant?.dateRemoved,
        isPropagated: widget.plant?.isPropagated ?? false,
        parentPlantId: widget.plant?.parentPlantId,
        createdAt: widget.plant?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final notifier = ref.read(plantProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updatePlant(plant);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Plant updated')));
        }
      } else {
        await notifier.addPlant(plant);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Plant added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving plant: $e'),
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
