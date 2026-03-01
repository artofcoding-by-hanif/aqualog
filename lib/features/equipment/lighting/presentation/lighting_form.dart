import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/reminders/presentation/widgets/suggested_reminders_dialog.dart';
import '../domain/entities/lighting.dart';
import 'controllers/lighting_provider.dart';

/// Lighting form widget for adding/editing lightings
class LightingFormScreen extends ConsumerStatefulWidget {
  const LightingFormScreen({
    super.key,
    required this.tankId,
    this.tankName,
    this.lighting,
  });

  /// Tank ID this lighting belongs to
  final int tankId;

  /// Tank name for display purposes
  final String? tankName;

  /// Existing lighting for edit mode (null for add mode)
  final LightingEntity? lighting;

  bool get isEditing => lighting != null;

  @override
  ConsumerState<LightingFormScreen> createState() => _LightingFormScreenState();
}

class _LightingFormScreenState extends ConsumerState<LightingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _wattageController = TextEditingController();
  final _kelvinController = TextEditingController();
  final _parController = TextEditingController();
  final _notesController = TextEditingController();

  LightingType _lightingType = LightingType.led;
  LightSpectrum? _spectrum;
  bool _isDimmable = false;
  bool _hasTimer = false;
  bool _hasColorControl = false;
  TimeOfDay? _onTime;
  TimeOfDay? _offTime;
  int _intensityPercent = 100;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.lighting != null) {
      _nameController.text = widget.lighting!.name;
      _brandController.text = widget.lighting!.brand ?? '';
      _modelController.text = widget.lighting!.model ?? '';
      _wattageController.text = widget.lighting!.wattage?.toString() ?? '';
      _kelvinController.text = widget.lighting!.kelvinRating?.toString() ?? '';
      _parController.text = widget.lighting!.parValue?.toString() ?? '';
      _notesController.text = widget.lighting!.notes ?? '';
      _lightingType = widget.lighting!.lightingType;
      _spectrum = widget.lighting!.spectrum;
      _isDimmable = widget.lighting!.isDimmable;
      _hasTimer = widget.lighting!.hasTimer;
      _hasColorControl = widget.lighting!.hasColorControl;
      _intensityPercent = widget.lighting!.intensityPercent;
      if (widget.lighting!.onTime != null) {
        final parts = widget.lighting!.onTime!.split(':');
        _onTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
      if (widget.lighting!.offTime != null) {
        final parts = widget.lighting!.offTime!.split(':');
        _offTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _wattageController.dispose();
    _kelvinController.dispose();
    _parController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Lighting' : 'Add Lighting'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Light Name',
                hintText: 'e.g., Main Light',
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
            DropdownButtonFormField<LightingType>(
              initialValue: _lightingType,
              decoration: const InputDecoration(labelText: 'Light Type'),
              items: LightingType.values.map((type) {
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
                  setState(() => _lightingType = value);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              _lightingType.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                      hintText: 'e.g., Fluval',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      hintText: 'e.g., Plant 3.0',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _wattageController,
                    decoration: const InputDecoration(
                      labelText: 'Wattage',
                      suffixText: 'W',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _kelvinController,
                    decoration: const InputDecoration(
                      labelText: 'Color Temp',
                      suffixText: 'K',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LightSpectrum>(
              initialValue: _spectrum,
              decoration: const InputDecoration(
                labelText: 'Spectrum (optional)',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Not specified'),
                ),
                ...LightSpectrum.values.map((spectrum) {
                  return DropdownMenuItem(
                    value: spectrum,
                    child: Text(spectrum.displayName),
                  );
                }),
              ],
              onChanged: (value) => setState(() => _spectrum = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _parController,
              decoration: const InputDecoration(
                labelText: 'PAR Value (optional)',
                hintText: 'Photosynthetically Active Radiation',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Text('Features', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: [
                FilterChip(
                  label: const Text('Dimmable'),
                  selected: _isDimmable,
                  onSelected: (val) => setState(() => _isDimmable = val),
                ),
                FilterChip(
                  label: const Text('Timer'),
                  selected: _hasTimer,
                  onSelected: (val) => setState(() => _hasTimer = val),
                ),
                FilterChip(
                  label: const Text('RGB Control'),
                  selected: _hasColorControl,
                  onSelected: (val) => setState(() => _hasColorControl = val),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Schedule', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('On Time'),
                    subtitle: Text(_onTime?.format(context) ?? 'Not set'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () => _pickTime(true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Off Time'),
                    subtitle: Text(_offTime?.format(context) ?? 'Not set'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () => _pickTime(false),
                  ),
                ),
              ],
            ),
            if (_isDimmable) ...[
              const SizedBox(height: 16),
              Text('Intensity: $_intensityPercent%'),
              Slider(
                value: _intensityPercent.toDouble(),
                min: 0,
                max: 100,
                divisions: 20,
                label: '$_intensityPercent%',
                onChanged: (val) =>
                    setState(() => _intensityPercent = val.round()),
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
              onPressed: _isSaving ? null : _saveLighting,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      widget.isEditing ? 'Update Lighting' : 'Save Lighting',
                    ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime(bool isOnTime) async {
    final initial = isOnTime ? _onTime : _offTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      setState(() {
        if (isOnTime) {
          _onTime = picked;
        } else {
          _offTime = picked;
        }
      });
    }
  }

  String? _formatTime(TimeOfDay? time) {
    if (time == null) return null;
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _saveLighting() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final lighting = LightingEntity(
        id: widget.lighting?.id,
        tankId: widget.tankId,
        name: _nameController.text.trim(),
        lightingType: _lightingType,
        brand: _brandController.text.trim().isEmpty
            ? null
            : _brandController.text.trim(),
        model: _modelController.text.trim().isEmpty
            ? null
            : _modelController.text.trim(),
        wattage: _wattageController.text.isEmpty
            ? null
            : double.tryParse(_wattageController.text),
        kelvinRating: _kelvinController.text.isEmpty
            ? null
            : int.tryParse(_kelvinController.text),
        spectrum: _spectrum,
        parValue: _parController.text.isEmpty
            ? null
            : int.tryParse(_parController.text),
        isDimmable: _isDimmable,
        hasTimer: _hasTimer,
        hasColorControl: _hasColorControl,
        onTime: _formatTime(_onTime),
        offTime: _formatTime(_offTime),
        intensityPercent: _intensityPercent,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        lastReplacedAt: widget.lighting?.lastReplacedAt,
        replacementIntervalDays:
            widget.lighting?.replacementIntervalDays ?? 365,
        createdAt: widget.lighting?.createdAt,
      );

      final notifier = ref.read(lightingProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateLighting(lighting);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Lighting updated')));
          Navigator.pop(context, true);
        }
      } else {
        await notifier.addLighting(lighting);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Lighting added')));
          // Show suggested reminders dialog for new lighting
          await _showSuggestedRemindersDialog(lighting);
          if (mounted) {
            Navigator.pop(context, true);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving lighting: $e'),
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

  Future<void> _showSuggestedRemindersDialog(LightingEntity lighting) async {
    final suggestions = ReminderSuggestions.forNewLighting(
      lighting.name,
      lighting.lightingType.name,
    );

    // Only show dialog if there are suggestions (LED doesn't have bulb replacement)
    if (suggestions.isEmpty) return;

    // Use tank name if available, otherwise use lighting name
    final displayName = widget.tankName ?? lighting.name;

    await showDialog<bool>(
      context: context,
      builder: (context) => SuggestedRemindersDialog(
        tankId: widget.tankId,
        tankName: displayName,
        suggestions: suggestions,
        contextTitle: 'Set Up Lighting Reminders',
      ),
    );
  }
}
