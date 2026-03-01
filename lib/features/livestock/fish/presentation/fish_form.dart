import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/fish.dart';
import 'controllers/fish_provider.dart';

/// Fish form screen for adding/editing fish
class FishFormScreen extends ConsumerStatefulWidget {
  const FishFormScreen({super.key, required this.tankId, this.fish});

  /// Tank ID this fish belongs to
  final int tankId;

  /// Existing fish for edit mode (null for add mode)
  final FishEntity? fish;

  bool get isEditing => fish != null;

  @override
  ConsumerState<FishFormScreen> createState() => _FishFormScreenState();
}

class _FishFormScreenState extends ConsumerState<FishFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _speciesController = TextEditingController();
  final _commonNameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();

  WaterType _waterType = WaterType.freshwater;
  FishTemperament? _temperament;
  FishDiet? _diet;
  CareLevel? _careLevel;
  SwimmingLevel? _swimmingLevel;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.fish != null) {
      _speciesController.text = widget.fish!.species;
      _commonNameController.text = widget.fish!.commonName ?? '';
      _quantityController.text = widget.fish!.quantity.toString();
      _notesController.text = widget.fish!.notes ?? '';
      _waterType = widget.fish!.waterType;
      _temperament = widget.fish!.temperament;
      _diet = widget.fish!.diet;
      _careLevel = widget.fish!.careLevel;
      _swimmingLevel = widget.fish!.swimmingLevel;
    }
  }

  @override
  void dispose() {
    _speciesController.dispose();
    _commonNameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEditing ? 'Edit Fish' : 'Add Fish')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _speciesController,
              decoration: const InputDecoration(
                labelText: 'Species',
                hintText: 'e.g., Betta splendens',
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
                hintText: 'e.g., Siamese Fighting Fish',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter quantity';
                }
                if (int.tryParse(value) == null || int.parse(value) < 1) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<WaterType>(
              value: _waterType,
              decoration: const InputDecoration(labelText: 'Water Type'),
              items: WaterType.values.map((type) {
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
                if (value != null) setState(() => _waterType = value);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<FishTemperament?>(
              value: _temperament,
              decoration: const InputDecoration(labelText: 'Temperament'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...FishTemperament.values.map((type) {
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
              onChanged: (value) => setState(() => _temperament = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<FishDiet?>(
              value: _diet,
              decoration: const InputDecoration(labelText: 'Diet'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...FishDiet.values.map((type) {
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
              onChanged: (value) => setState(() => _diet = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<CareLevel?>(
              value: _careLevel,
              decoration: const InputDecoration(labelText: 'Care Level'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...CareLevel.values.map((type) {
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
              onChanged: (value) => setState(() => _careLevel = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<SwimmingLevel?>(
              value: _swimmingLevel,
              decoration: const InputDecoration(labelText: 'Swimming Level'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...SwimmingLevel.values.map((type) {
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
              onChanged: (value) => setState(() => _swimmingLevel = value),
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
              onPressed: _isSaving ? null : _saveFish,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Fish' : 'Save Fish'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFish() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final fish = FishEntity(
        id: widget.fish?.id,
        tankId: widget.tankId,
        species: _speciesController.text.trim(),
        commonName: _commonNameController.text.trim().isEmpty
            ? null
            : _commonNameController.text.trim(),
        quantity: int.parse(_quantityController.text),
        waterType: _waterType,
        temperament: _temperament,
        diet: _diet,
        careLevel: _careLevel,
        swimmingLevel: _swimmingLevel,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        dateAdded: widget.fish?.dateAdded ?? DateTime.now(),
        dateDeceased: widget.fish?.dateDeceased,
        isQuarantined: widget.fish?.isQuarantined ?? false,
        quarantineEndDate: widget.fish?.quarantineEndDate,
        createdAt: widget.fish?.createdAt,
      );

      final notifier = ref.read(fishProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateFish(fish);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Fish updated')));
        }
      } else {
        await notifier.addFish(fish);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Fish added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving fish: $e'),
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
