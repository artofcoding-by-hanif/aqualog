import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/feeding_log.dart';
import '../controllers/feeding_log_provider.dart';

/// Feeding log form screen for adding/editing feeding logs
class FeedingLogFormScreen extends ConsumerStatefulWidget {
  const FeedingLogFormScreen({
    super.key,
    required this.tankId,
    required this.tankName,
    this.log,
  });

  final int tankId;
  final String tankName;
  final FeedingLogEntity? log;

  bool get isEditing => log != null;

  @override
  ConsumerState<FeedingLogFormScreen> createState() =>
      _FeedingLogFormScreenState();
}

class _FeedingLogFormScreenState extends ConsumerState<FeedingLogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late FoodType _foodType;
  late FeedingResponse _response;
  late TextEditingController _foodNameController;
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  late DateTime _fedAt;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _foodType = widget.log?.foodType ?? FoodType.flakes;
    _response = widget.log?.response ?? FeedingResponse.unknown;
    _foodNameController = TextEditingController(
      text: widget.log?.foodName ?? '',
    );
    _amountController = TextEditingController(text: widget.log?.amount ?? '');
    _notesController = TextEditingController(text: widget.log?.notes ?? '');
    _fedAt = widget.log?.fedAt ?? DateTime.now();
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Feeding' : 'Add Feeding'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<FoodType>(
              initialValue: _foodType,
              decoration: const InputDecoration(
                labelText: 'Food Type',
                prefixIcon: Icon(Icons.restaurant),
              ),
              items: FoodType.values.map((type) {
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
                  setState(() => _foodType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _foodNameController,
              decoration: const InputDecoration(
                labelText: 'Food Name/Brand (optional)',
                hintText: 'e.g., Hikari Micro Pellets',
                prefixIcon: Icon(Icons.label),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (optional)',
                hintText: 'e.g., 2 pinches, 5 pellets',
                prefixIcon: Icon(Icons.scale),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<FeedingResponse>(
              initialValue: _response,
              decoration: const InputDecoration(
                labelText: 'Fish Response',
                prefixIcon: Icon(Icons.pets),
              ),
              items: FeedingResponse.values.map((resp) {
                return DropdownMenuItem(
                  value: resp,
                  child: Row(
                    children: [
                      Text(resp.icon),
                      const SizedBox(width: 8),
                      Text(resp.displayName),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _response = value);
                }
              },
            ),
            const SizedBox(height: 16),
            _buildDateTimePicker(context),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Any observations...',
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
                  : Text(widget.isEditing ? 'Update' : 'Save Feeding'),
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
          labelText: 'Fed At',
          prefixIcon: Icon(Icons.calendar_today),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDateTime(_fedAt)),
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
      initialDate: _fedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null && context.mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_fedAt),
      );
      if (time != null) {
        setState(() {
          _fedAt = DateTime(
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
      final log = FeedingLogEntity(
        id: widget.log?.id,
        tankId: widget.tankId,
        foodType: _foodType,
        foodName: _foodNameController.text.trim().isEmpty
            ? null
            : _foodNameController.text.trim(),
        amount: _amountController.text.trim().isEmpty
            ? null
            : _amountController.text.trim(),
        response: _response,
        fedAt: _fedAt,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        createdAt: widget.log?.createdAt,
      );

      final notifier = ref.read(feedingLogProvider(widget.tankId).notifier);

      if (widget.isEditing) {
        await notifier.updateLog(log);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Feeding log updated')));
        }
      } else {
        await notifier.addLog(log);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Feeding logged')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving feeding log: $e'),
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
