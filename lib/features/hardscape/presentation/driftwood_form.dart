import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/driftwood.dart';
import 'controllers/driftwood_provider.dart';

/// Driftwood form screen for adding/editing driftwood
class DriftwoodFormScreen extends ConsumerStatefulWidget {
  const DriftwoodFormScreen({super.key, required this.tankId, this.driftwood});

  /// Tank ID this driftwood belongs to
  final int tankId;

  /// Existing driftwood for edit mode (null for add mode)
  final DriftwoodEntity? driftwood;

  bool get isEditing => driftwood != null;

  @override
  ConsumerState<DriftwoodFormScreen> createState() =>
      _DriftwoodFormScreenState();
}

class _DriftwoodFormScreenState extends ConsumerState<DriftwoodFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _sourceController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  DriftwoodType _driftwoodType = DriftwoodType.manzanita;
  bool _isCured = true;
  bool _isReleasingTannins = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.driftwood != null) {
      _nameController.text = widget.driftwood!.name;
      _quantityController.text = widget.driftwood!.quantity.toString();
      _lengthController.text = widget.driftwood!.lengthCm?.toString() ?? '';
      _widthController.text = widget.driftwood!.widthCm?.toString() ?? '';
      _heightController.text = widget.driftwood!.heightCm?.toString() ?? '';
      _sourceController.text = widget.driftwood!.source ?? '';
      _priceController.text = widget.driftwood!.purchasePrice?.toString() ?? '';
      _notesController.text = widget.driftwood!.notes ?? '';
      _driftwoodType = widget.driftwood!.driftwoodType;
      _isCured = widget.driftwood!.isCured;
      _isReleasingTannins = widget.driftwood!.isReleasingTannins;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _sourceController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Driftwood' : 'Add Driftwood'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g., Main branch',
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<DriftwoodType>(
              value: _driftwoodType,
              decoration: const InputDecoration(labelText: 'Driftwood Type'),
              items: DriftwoodType.values.map((type) {
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
                if (value != null) setState(() => _driftwoodType = value);
              },
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
            SwitchListTile(
              title: const Text('Is Cured'),
              subtitle: const Text('Has the driftwood been waterlogged/soaked'),
              value: _isCured,
              onChanged: (value) => setState(() => _isCured = value),
            ),
            SwitchListTile(
              title: const Text('Releasing Tannins'),
              subtitle: const Text(
                'Is it currently releasing tannins into the water',
              ),
              value: _isReleasingTannins,
              onChanged: (value) => setState(() => _isReleasingTannins = value),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _lengthController,
                    decoration: const InputDecoration(labelText: 'Length (cm)'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _widthController,
                    decoration: const InputDecoration(labelText: 'Width (cm)'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _sourceController,
              decoration: const InputDecoration(
                labelText: 'Source (optional)',
                hintText: 'e.g., Local fish store',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
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
              onPressed: _isSaving ? null : _saveDriftwood,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      widget.isEditing ? 'Update Driftwood' : 'Save Driftwood',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDriftwood() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final driftwood = DriftwoodEntity(
        id: widget.driftwood?.id,
        tankId: widget.tankId,
        name: _nameController.text.trim(),
        driftwoodType: _driftwoodType,
        quantity: int.parse(_quantityController.text),
        isCured: _isCured,
        isReleasingTannins: _isReleasingTannins,
        lengthCm: double.tryParse(_lengthController.text),
        widthCm: double.tryParse(_widthController.text),
        heightCm: double.tryParse(_heightController.text),
        source: _sourceController.text.trim().isEmpty
            ? null
            : _sourceController.text.trim(),
        purchasePrice: double.tryParse(_priceController.text),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        dateAdded: widget.driftwood?.dateAdded ?? DateTime.now(),
        curingStartDate: _isCured
            ? null
            : (widget.driftwood?.curingStartDate ?? DateTime.now()),
        createdAt: widget.driftwood?.createdAt,
      );

      final notifier = ref.read(driftwoodProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateDriftwood(driftwood);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Driftwood updated')));
        }
      } else {
        await notifier.addDriftwood(driftwood);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Driftwood added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving driftwood: $e'),
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
