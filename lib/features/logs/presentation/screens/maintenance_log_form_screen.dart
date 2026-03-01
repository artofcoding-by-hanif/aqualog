import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/maintenance_log.dart';
import '../controllers/maintenance_log_provider.dart';

/// Maintenance log form screen for adding/editing maintenance logs
class MaintenanceLogFormScreen extends ConsumerStatefulWidget {
  const MaintenanceLogFormScreen({
    super.key,
    required this.tankId,
    required this.tankName,
    this.log,
    this.initialType,
  });

  final int tankId;
  final String tankName;
  final MaintenanceLogEntity? log;
  final MaintenanceType? initialType;

  bool get isEditing => log != null;

  @override
  ConsumerState<MaintenanceLogFormScreen> createState() =>
      _MaintenanceLogFormScreenState();
}

class _MaintenanceLogFormScreenState
    extends ConsumerState<MaintenanceLogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late MaintenanceType _maintenanceType;
  late TextEditingController _titleController;
  late TextEditingController _notesController;
  late TextEditingController _waterChangePercentController;
  late TextEditingController _durationController;
  late DateTime _performedAt;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _maintenanceType =
        widget.log?.maintenanceType ??
        widget.initialType ??
        MaintenanceType.waterChange;
    _titleController = TextEditingController(
      text: widget.log?.title ?? _maintenanceType.displayName,
    );
    _notesController = TextEditingController(text: widget.log?.notes ?? '');
    _waterChangePercentController = TextEditingController(
      text: widget.log?.waterChangePercent?.toStringAsFixed(0) ?? '25',
    );
    _durationController = TextEditingController(
      text: widget.log?.durationMinutes?.toString() ?? '',
    );
    _performedAt = widget.log?.performedAt ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    _waterChangePercentController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEditing ? 'Edit Log' : 'Add Log')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<MaintenanceType>(
              initialValue: _maintenanceType,
              decoration: const InputDecoration(
                labelText: 'Maintenance Type',
                prefixIcon: Icon(Icons.category),
              ),
              items: MaintenanceType.values.map((type) {
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
                    _maintenanceType = value;
                    // Update title if it matches the old type's display name
                    if (_titleController.text == _maintenanceType.displayName ||
                        _titleController.text.isEmpty) {
                      _titleController.text = value.displayName;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'e.g., Weekly water change',
                prefixIcon: Icon(Icons.title),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            if (_maintenanceType == MaintenanceType.waterChange) ...[
              TextFormField(
                controller: _waterChangePercentController,
                decoration: const InputDecoration(
                  labelText: 'Water Change %',
                  hintText: 'e.g., 25',
                  prefixIcon: Icon(Icons.water_drop),
                  suffixText: '%',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ],
            _buildDateTimePicker(context),
            const SizedBox(height: 16),
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                hintText: 'e.g., 30',
                prefixIcon: Icon(Icons.timer),
                suffixText: 'min',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Any additional notes...',
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSaving ? null : _saveLog,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Log' : 'Save Log'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return InkWell(
      onTap: () => _selectDateTime(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Performed At',
          prefixIcon: Icon(Icons.calendar_today),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDateTime(_performedAt)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    String dateStr;
    if (date == today) {
      dateStr = 'Today';
    } else if (date == today.subtract(const Duration(days: 1))) {
      dateStr = 'Yesterday';
    } else {
      dateStr = '${dt.day}/${dt.month}/${dt.year}';
    }

    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$dateStr at $hour:$minute';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _performedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null && context.mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_performedAt),
      );
      if (time != null) {
        setState(() {
          _performedAt = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final log = MaintenanceLogEntity(
        id: widget.log?.id,
        tankId: widget.tankId,
        maintenanceType: _maintenanceType,
        title: _titleController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        waterChangePercent: _maintenanceType == MaintenanceType.waterChange
            ? double.tryParse(_waterChangePercentController.text)
            : null,
        waterChangeLiters: null,
        performedAt: _performedAt,
        durationMinutes: int.tryParse(_durationController.text),
        createdAt: widget.log?.createdAt,
      );

      final notifier = ref.read(maintenanceLogProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateLog(log);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Log updated')));
        }
      } else {
        await notifier.addLog(log);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Log added')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving log: $e'),
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
