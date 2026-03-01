import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../tank/domain/entities/tank.dart';
import '../../tank/presentation/controllers/tank_provider.dart';
import '../domain/entities/reminder.dart';
import 'controllers/reminder_provider.dart';

/// Reminder form screen for creating and editing reminders
class ReminderFormScreen extends ConsumerStatefulWidget {
  const ReminderFormScreen({super.key, this.reminder, this.tankId});

  final ReminderEntity? reminder;
  final int? tankId;

  bool get isEditing => reminder != null;

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customIntervalController = TextEditingController();

  ReminderType _type = ReminderType.waterChange;
  RepeatFrequency _frequency = RepeatFrequency.weekly;
  DateTime _scheduledDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _scheduledTime = const TimeOfDay(hour: 9, minute: 0);
  bool _isEnabled = true;
  int? _selectedTankId;
  FoodType? _selectedFoodType;

  @override
  void initState() {
    super.initState();
    _selectedTankId = widget.tankId ?? widget.reminder?.tankId;
    if (widget.reminder != null) {
      _populateFromReminder(widget.reminder!);
    }
  }

  void _populateFromReminder(ReminderEntity reminder) {
    _titleController.text = reminder.title;
    _descriptionController.text = reminder.description ?? '';
    _type = reminder.reminderType;
    _frequency = reminder.repeatFrequency;
    _scheduledDate = reminder.scheduledAt;
    _scheduledTime = TimeOfDay.fromDateTime(reminder.scheduledAt);
    _isEnabled = reminder.isEnabled;
    _selectedFoodType = reminder.foodType;
    if (reminder.customIntervalDays != null) {
      _customIntervalController.text = reminder.customIntervalDays.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _customIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Reminder' : 'Add Reminder'),
        actions: [
          if (widget.isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteReminder,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTitleField(),
            const SizedBox(height: 16),
            _buildTypeDropdown(),
            if (_type == ReminderType.feeding) ...[
              const SizedBox(height: 16),
              _buildFoodTypeDropdown(),
            ],
            const SizedBox(height: 16),
            _buildTankDropdown(),
            const SizedBox(height: 16),
            _buildFrequencyDropdown(),
            if (_frequency == RepeatFrequency.custom) ...[
              const SizedBox(height: 16),
              _buildCustomIntervalField(),
            ],
            const SizedBox(height: 16),
            _buildDatePicker(),
            const SizedBox(height: 16),
            _buildTimePicker(),
            const SizedBox(height: 16),
            _buildDescriptionField(),
            const SizedBox(height: 16),
            _buildEnabledSwitch(),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saveReminder,
              child: Text(
                widget.isEditing ? 'Update Reminder' : 'Save Reminder',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Title',
        hintText: 'e.g., Weekly Water Change',
      ),
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<ReminderType>(
      value: _type,
      decoration: const InputDecoration(labelText: 'Type'),
      items: ReminderType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text('${type.icon} ${type.displayName}'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _type = value!;
          // Auto-fill title if empty
          if (_titleController.text.isEmpty) {
            _titleController.text = value.displayName;
          }
          // Clear food type if not feeding reminder
          if (value != ReminderType.feeding) {
            _selectedFoodType = null;
          }
        });
      },
    );
  }

  Widget _buildFoodTypeDropdown() {
    return DropdownButtonFormField<FoodType>(
      value: _selectedFoodType,
      decoration: const InputDecoration(
        labelText: 'Food Type',
        hintText: 'Select the type of food',
        prefixIcon: Icon(Icons.restaurant),
      ),
      items: FoodType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text('${type.icon} ${type.displayName}'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedFoodType = value);
      },
    );
  }

  Widget _buildTankDropdown() {
    final tanksAsync = ref.watch(tanksStreamProvider);

    return tanksAsync.when(
      data: (tanks) {
        if (tanks.isEmpty) {
          return const SizedBox.shrink();
        }
        return DropdownButtonFormField<int?>(
          value: _selectedTankId,
          decoration: const InputDecoration(
            labelText: 'Tank (Optional)',
            hintText: 'Select a tank or leave empty for global reminder',
            prefixIcon: Icon(Icons.water_drop),
          ),
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text('🌐 Global (All tanks)'),
            ),
            ...tanks.map((tank) {
              return DropdownMenuItem<int?>(
                value: tank.id,
                child: Text('${tank.tankType.icon} ${tank.name}'),
              );
            }),
          ],
          onChanged: (value) {
            setState(() => _selectedTankId = value);
          },
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildFrequencyDropdown() {
    return DropdownButtonFormField<RepeatFrequency>(
      value: _frequency,
      decoration: const InputDecoration(labelText: 'Frequency'),
      items: RepeatFrequency.values.map((freq) {
        return DropdownMenuItem(value: freq, child: Text(freq.displayName));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _frequency = value!;
        });
      },
    );
  }

  Widget _buildCustomIntervalField() {
    return TextFormField(
      controller: _customIntervalController,
      decoration: const InputDecoration(
        labelText: 'Repeat every (days)',
        hintText: 'e.g., 5',
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (_frequency == RepeatFrequency.custom) {
          if (value == null || value.isEmpty) {
            return 'Please enter interval days';
          }
          final days = int.tryParse(value);
          if (days == null || days < 1) {
            return 'Please enter a valid number';
          }
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Date'),
      subtitle: Text(DateFormat.yMMMd().format(_scheduledDate)),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _scheduledDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
        );
        if (date != null) {
          setState(() {
            _scheduledDate = date;
          });
        }
      },
    );
  }

  Widget _buildTimePicker() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Time'),
      subtitle: Text(_scheduledTime.format(context)),
      trailing: const Icon(Icons.access_time),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _scheduledTime,
        );
        if (time != null) {
          setState(() {
            _scheduledTime = time;
          });
        }
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Notes (optional)',
        hintText: 'Add any additional notes...',
      ),
      textCapitalization: TextCapitalization.sentences,
      maxLines: 3,
    );
  }

  Widget _buildEnabledSwitch() {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Enabled'),
      subtitle: const Text('Receive notifications for this reminder'),
      value: _isEnabled,
      onChanged: (value) {
        setState(() {
          _isEnabled = value;
        });
      },
    );
  }

  DateTime get _combinedDateTime {
    return DateTime(
      _scheduledDate.year,
      _scheduledDate.month,
      _scheduledDate.day,
      _scheduledTime.hour,
      _scheduledTime.minute,
    );
  }

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;

    final reminder = ReminderEntity(
      id: widget.reminder?.id,
      tankId: _selectedTankId,
      filterId: widget.reminder?.filterId,
      foodType: _type == ReminderType.feeding ? _selectedFoodType : null,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      reminderType: _type,
      scheduledAt: _combinedDateTime,
      repeatFrequency: _frequency,
      customIntervalDays: _frequency == RepeatFrequency.custom
          ? int.tryParse(_customIntervalController.text)
          : null,
      isEnabled: _isEnabled,
      isCompleted: widget.reminder?.isCompleted ?? false,
      lastCompletedAt: widget.reminder?.lastCompletedAt,
      createdAt: widget.reminder?.createdAt,
      updatedAt: DateTime.now(),
    );

    if (widget.isEditing) {
      await ref.read(reminderProvider.notifier).updateReminder(reminder);
    } else {
      await ref.read(reminderProvider.notifier).addReminder(reminder);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _deleteReminder() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Reminder'),
        content: const Text('Are you sure you want to delete this reminder?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.reminder?.id != null) {
      await ref
          .read(reminderProvider.notifier)
          .deleteReminder(widget.reminder!.id!);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
