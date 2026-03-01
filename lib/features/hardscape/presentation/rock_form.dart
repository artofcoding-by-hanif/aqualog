import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/rock.dart';
import 'controllers/rock_provider.dart';

/// Rock form screen for adding/editing rocks
class RockFormScreen extends ConsumerStatefulWidget {
  const RockFormScreen({super.key, required this.tankId, this.rock});

  /// Tank ID this rock belongs to
  final int tankId;

  /// Existing rock for edit mode (null for add mode)
  final RockEntity? rock;

  bool get isEditing => rock != null;

  @override
  ConsumerState<RockFormScreen> createState() => _RockFormScreenState();
}

class _RockFormScreenState extends ConsumerState<RockFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _weightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _sourceController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  RockType _rockType = RockType.dragonStone;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.rock != null) {
      _nameController.text = widget.rock!.name;
      _quantityController.text = widget.rock!.quantity.toString();
      _weightController.text = widget.rock!.weightKg?.toString() ?? '';
      _lengthController.text = widget.rock!.lengthCm?.toString() ?? '';
      _widthController.text = widget.rock!.widthCm?.toString() ?? '';
      _heightController.text = widget.rock!.heightCm?.toString() ?? '';
      _sourceController.text = widget.rock!.source ?? '';
      _priceController.text = widget.rock!.purchasePrice?.toString() ?? '';
      _notesController.text = widget.rock!.notes ?? '';
      _rockType = widget.rock!.rockType;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _weightController.dispose();
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
      appBar: AppBar(title: Text(widget.isEditing ? 'Edit Rock' : 'Add Rock')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g., Main centerpiece rock',
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
            DropdownButtonFormField<RockType>(
              value: _rockType,
              decoration: const InputDecoration(labelText: 'Rock Type'),
              items: RockType.values.map((type) {
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
                if (value != null) setState(() => _rockType = value);
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
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                hintText: 'Optional',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
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
              onPressed: _isSaving ? null : _saveRock,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Rock' : 'Save Rock'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveRock() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final rock = RockEntity(
        id: widget.rock?.id,
        tankId: widget.tankId,
        name: _nameController.text.trim(),
        rockType: _rockType,
        quantity: int.parse(_quantityController.text),
        weightKg: double.tryParse(_weightController.text),
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
        dateAdded: widget.rock?.dateAdded ?? DateTime.now(),
        createdAt: widget.rock?.createdAt,
      );

      final notifier = ref.read(rockProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateRock(rock);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Rock updated')));
        }
      } else {
        await notifier.addRock(rock);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Rock added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving rock: $e'),
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
