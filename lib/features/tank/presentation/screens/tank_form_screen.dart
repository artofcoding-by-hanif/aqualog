import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/volume_calculator.dart';
import '../../../reminders/presentation/widgets/suggested_reminders_dialog.dart';
import '../../domain/entities/tank.dart';
import '../controllers/tank_provider.dart';

/// Tank form screen for add/edit
class TankFormScreen extends ConsumerStatefulWidget {
  const TankFormScreen({super.key, this.tank});

  final TankEntity? tank;

  bool get isEditing => tank != null;

  @override
  ConsumerState<TankFormScreen> createState() => _TankFormScreenState();
}

class _TankFormScreenState extends ConsumerState<TankFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _volumeController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  TankType _tankType = TankType.freshwater;
  TankShape _tankShape = TankShape.rectangular;
  DateTime? _setupDate;
  bool _autoCalculateVolume = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _lengthController.addListener(_onDimensionChanged);
    _widthController.addListener(_onDimensionChanged);
    _heightController.addListener(_onDimensionChanged);

    if (widget.tank != null) {
      final tank = widget.tank!;
      _nameController.text = tank.name;
      _descriptionController.text = tank.description ?? '';
      _volumeController.text = tank.volumeLiters.toString();
      _tankType = tank.tankType;
      _setupDate = tank.setupDate;
      // If editing, start with manual mode since we don't store shape
      _autoCalculateVolume = false;
      if (tank.lengthCm != null) {
        _lengthController.text = tank.lengthCm.toString();
      }
      if (tank.widthCm != null) {
        _widthController.text = tank.widthCm.toString();
      }
      if (tank.heightCm != null) {
        _heightController.text = tank.heightCm.toString();
      }
    }
  }

  @override
  void dispose() {
    _lengthController.removeListener(_onDimensionChanged);
    _widthController.removeListener(_onDimensionChanged);
    _heightController.removeListener(_onDimensionChanged);
    _nameController.dispose();
    _descriptionController.dispose();
    _volumeController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _onDimensionChanged() {
    if (!_autoCalculateVolume) return;
    _calculateAndSetVolume();
  }

  void _calculateAndSetVolume() {
    final length = double.tryParse(_lengthController.text);
    final width = double.tryParse(_widthController.text);
    final height = double.tryParse(_heightController.text);

    final volume = VolumeCalculator.calculate(
      shape: _tankShape,
      lengthCm: length,
      widthCm: width,
      heightCm: height,
    );

    if (volume != null && volume > 0) {
      _volumeController.text = volume.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEditing ? 'Edit Tank' : 'Add Tank')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Tank Name',
                hintText: 'e.g., Living Room Tank',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'e.g., Planted community tank',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TankType>(
              value: _tankType,
              decoration: const InputDecoration(labelText: 'Tank Type'),
              items: TankType.values.map((type) {
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
                setState(() {
                  _tankType = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            _buildVolumeSection(),
            const SizedBox(height: 16),
            _buildDimensionsSection(),
            const SizedBox(height: 16),
            _buildSetupDatePicker(context),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSaving ? null : _saveTank,
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Save Changes' : 'Add Tank'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeSection() {
    final labels = _tankShape.dimensionLabels;
    final showWidth = _tankShape.requiresWidth;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.water_drop, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Volume & Dimensions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tank shape selector
            DropdownButtonFormField<TankShape>(
              value: _tankShape,
              decoration: const InputDecoration(
                labelText: 'Tank Shape',
                isDense: true,
              ),
              items: TankShape.values.map((shape) {
                return DropdownMenuItem(
                  value: shape,
                  child: Row(
                    children: [
                      Text(shape.icon),
                      const SizedBox(width: 8),
                      Text(shape.displayName),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _tankShape = value!;
                  if (_tankShape == TankShape.custom) {
                    _autoCalculateVolume = false;
                  }
                  _calculateAndSetVolume();
                });
              },
            ),
            const SizedBox(height: 16),
            // Auto-calculate toggle
            if (_tankShape != TankShape.custom)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Auto-calculate volume'),
                subtitle: Text(
                  _autoCalculateVolume
                      ? 'Volume calculated from dimensions'
                      : 'Enter volume manually',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                value: _autoCalculateVolume,
                onChanged: (value) {
                  setState(() {
                    _autoCalculateVolume = value;
                    if (value) {
                      _calculateAndSetVolume();
                    }
                  });
                },
              ),
            const SizedBox(height: 8),
            // Dimension inputs
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(
                      labelText: labels[0],
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                if (showWidth) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _widthController,
                      decoration: InputDecoration(
                        labelText: labels[1],
                        isDense: true,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      labelText: labels[2],
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Volume input
            TextFormField(
              controller: _volumeController,
              decoration: InputDecoration(
                labelText: 'Volume (Liters)',
                hintText: 'e.g., 100',
                suffixText: 'L',
                enabled:
                    !_autoCalculateVolume || _tankShape == TankShape.custom,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the volume';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            // Show calculated gallons
            if (_volumeController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '≈ ${((double.tryParse(_volumeController.text) ?? 0) * 0.264172).toStringAsFixed(1)} gal',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDimensionsSection() {
    // This is now integrated into _buildVolumeSection
    // Keeping this method for backwards compatibility if needed
    return const SizedBox.shrink();
  }

  Widget _buildSetupDatePicker(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.calendar_today),
      title: const Text('Setup Date'),
      subtitle: Text(
        _setupDate != null
            ? '${_setupDate!.day}/${_setupDate!.month}/${_setupDate!.year}'
            : 'Not set',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _setupDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() {
            _setupDate = date;
          });
        }
      },
    );
  }

  Future<void> _saveTank() async {
    if (_formKey.currentState!.validate()) {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      try {
        final tank = TankEntity(
          id: widget.tank?.id,
          name: _nameController.text.trim(),
          tankType: _tankType,
          volumeLiters: double.parse(_volumeController.text),
          lengthCm: double.tryParse(_lengthController.text),
          widthCm: double.tryParse(_widthController.text),
          heightCm: double.tryParse(_heightController.text),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          setupDate: _setupDate,
          isActive: widget.tank?.isActive ?? false,
          createdAt: widget.tank?.createdAt,
          updatedAt: widget.tank?.updatedAt,
        );

        final notifier = ref.read(tankProvider.notifier);

        if (widget.isEditing) {
          await notifier.updateTank(tank);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tank updated successfully')),
            );
            Navigator.of(context).pop(true);
          }
        } else {
          final tankId = await notifier.addTank(tank);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tank added successfully')),
            );
            // Show suggested reminders dialog for new tank
            await _showSuggestedRemindersDialog(
              tankId,
              tank.name,
              tank.tankType,
            );
            if (mounted) {
              Navigator.of(context).pop(true);
            }
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving tank: $e'),
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

  Future<void> _showSuggestedRemindersDialog(
    int tankId,
    String tankName,
    TankType tankType,
  ) async {
    final suggestions = ReminderSuggestions.forNewTank(tankType.name);

    if (suggestions.isEmpty) return;

    await showDialog<bool>(
      context: context,
      builder: (context) => SuggestedRemindersDialog(
        tankId: tankId,
        tankName: tankName,
        suggestions: suggestions,
        contextTitle: 'Set Up Reminders',
      ),
    );
  }
}
