import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/invertebrate.dart';
import 'controllers/invertebrate_provider.dart';

/// Invertebrate form screen for adding and editing invertebrates
class InvertebrateFormScreen extends ConsumerStatefulWidget {
  const InvertebrateFormScreen({
    super.key,
    required this.tankId,
    this.invertebrate,
  });

  final int tankId;
  final InvertebrateEntity? invertebrate;

  bool get isEditing => invertebrate != null;

  @override
  ConsumerState<InvertebrateFormScreen> createState() =>
      _InvertebrateFormScreenState();
}

class _InvertebrateFormScreenState
    extends ConsumerState<InvertebrateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _speciesController = TextEditingController();
  final _commonNameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();

  InvertebrateType _invertebrateType = InvertebrateType.shrimp;
  InvertWaterType _waterType = InvertWaterType.freshwater;
  InvertCareLevel? _careLevel;
  bool _isBreedingColony = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.invertebrate != null) {
      final inv = widget.invertebrate!;
      _speciesController.text = inv.species;
      _commonNameController.text = inv.commonName ?? '';
      _quantityController.text = inv.quantity.toString();
      _notesController.text = inv.notes ?? '';
      _invertebrateType = inv.invertebrateType;
      _waterType = inv.waterType;
      _careLevel = inv.careLevel;
      _isBreedingColony = inv.isBreedingColony;
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
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Invertebrate' : 'Add Invertebrate',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _speciesController,
              decoration: const InputDecoration(
                labelText: 'Species *',
                hintText: 'e.g., Neocaridina davidi',
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
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
                hintText: 'e.g., Cherry Shrimp',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<InvertebrateType>(
              value: _invertebrateType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: InvertebrateType.values.map((type) {
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
                if (value != null) {
                  setState(() {
                    _invertebrateType = value;
                    // Reset breeding colony if not shrimp
                    if (value != InvertebrateType.shrimp) {
                      _isBreedingColony = false;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity *',
                hintText: '1',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter quantity';
                }
                final qty = int.tryParse(value);
                if (qty == null || qty < 1) {
                  return 'Please enter a valid quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<InvertWaterType>(
              value: _waterType,
              decoration: const InputDecoration(labelText: 'Water Type'),
              items: InvertWaterType.values.map((type) {
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
            DropdownButtonFormField<InvertCareLevel?>(
              value: _careLevel,
              decoration: const InputDecoration(labelText: 'Care Level'),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...InvertCareLevel.values.map((type) {
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
            if (_invertebrateType == InvertebrateType.shrimp) ...[
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Breeding Colony'),
                subtitle: const Text(
                  'Track as a colony with approximate count',
                ),
                value: _isBreedingColony,
                onChanged: (value) => setState(() => _isBreedingColony = value),
              ),
            ],
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
              onPressed: _isSaving ? null : _saveInvertebrate,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      widget.isEditing
                          ? 'Update Invertebrate'
                          : 'Save Invertebrate',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveInvertebrate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final invertebrate = InvertebrateEntity(
        id: widget.invertebrate?.id,
        tankId: widget.tankId,
        species: _speciesController.text.trim(),
        commonName: _commonNameController.text.trim().isEmpty
            ? null
            : _commonNameController.text.trim(),
        invertebrateType: _invertebrateType,
        quantity: int.parse(_quantityController.text),
        waterType: _waterType,
        careLevel: _careLevel,
        isBreedingColony: _invertebrateType == InvertebrateType.shrimp
            ? _isBreedingColony
            : false,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        dateAdded: widget.invertebrate?.dateAdded ?? DateTime.now(),
        dateDeceased: widget.invertebrate?.dateDeceased,
        isQuarantined: widget.invertebrate?.isQuarantined ?? false,
        quarantineEndDate: widget.invertebrate?.quarantineEndDate,
        createdAt: widget.invertebrate?.createdAt,
      );

      final notifier = ref.read(invertebrateProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateInvertebrate(invertebrate);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Invertebrate updated')));
        }
      } else {
        await notifier.addInvertebrate(invertebrate);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Invertebrate added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving invertebrate: $e'),
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
