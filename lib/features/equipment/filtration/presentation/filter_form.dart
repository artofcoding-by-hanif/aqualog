import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/filter.dart';
import 'controllers/filter_provider.dart';

/// Filter form widget for adding/editing filters
class FilterFormScreen extends ConsumerStatefulWidget {
  const FilterFormScreen({super.key, required this.tankId, this.filter});

  /// Tank ID this filter belongs to
  final int tankId;

  /// Existing filter for edit mode (null for add mode)
  final FilterEntity? filter;

  bool get isEditing => filter != null;

  @override
  ConsumerState<FilterFormScreen> createState() => _FilterFormScreenState();
}

class _FilterFormScreenState extends ConsumerState<FilterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _flowRateController = TextEditingController();
  final _notesController = TextEditingController();

  FilterType _filterType = FilterType.hob;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.filter != null) {
      _nameController.text = widget.filter!.name;
      _brandController.text = widget.filter!.brand ?? '';
      _modelController.text = widget.filter!.model ?? '';
      _flowRateController.text = widget.filter!.flowRateLph?.toString() ?? '';
      _notesController.text = widget.filter!.notes ?? '';
      _filterType = widget.filter!.filterType;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _flowRateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Filter' : 'Add Filter'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Filter Name',
                hintText: 'e.g., Main Filter',
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
            DropdownButtonFormField<FilterType>(
              initialValue: _filterType,
              decoration: const InputDecoration(labelText: 'Filter Type'),
              items: FilterType.values.map((type) {
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
                    _filterType = value;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              _filterType.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(
                labelText: 'Brand (optional)',
                hintText: 'e.g., Fluval, Eheim',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _modelController,
              decoration: const InputDecoration(
                labelText: 'Model (optional)',
                hintText: 'e.g., 307, Classic 250',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _flowRateController,
              decoration: const InputDecoration(
                labelText: 'Flow Rate (optional)',
                suffixText: 'L/h',
                hintText: 'e.g., 1000',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) {
                    return 'Please enter a valid flow rate';
                  }
                }
                return null;
              },
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
              onPressed: _isSaving ? null : _saveFilter,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Filter' : 'Save Filter'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFilter() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final filter = FilterEntity(
        id: widget.filter?.id,
        tankId: widget.tankId,
        name: _nameController.text.trim(),
        filterType: _filterType,
        brand: _brandController.text.trim().isEmpty
            ? null
            : _brandController.text.trim(),
        model: _modelController.text.trim().isEmpty
            ? null
            : _modelController.text.trim(),
        flowRateLph: _flowRateController.text.isEmpty
            ? null
            : double.tryParse(_flowRateController.text),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        lastCleanedAt: widget.filter?.lastCleanedAt,
        mediaReplacedAt: widget.filter?.mediaReplacedAt,
        cleaningIntervalDays: widget.filter?.cleaningIntervalDays ?? 14,
        mediaReplacementIntervalDays:
            widget.filter?.mediaReplacementIntervalDays ?? 90,
        createdAt: widget.filter?.createdAt,
      );

      final notifier = ref.read(filterProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateFilter(filter);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Filter updated')));
        }
      } else {
        await notifier.addFilter(filter);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Filter added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving filter: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
