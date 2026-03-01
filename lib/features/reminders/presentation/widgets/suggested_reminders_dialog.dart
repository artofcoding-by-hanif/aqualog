import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/reminder.dart';
import '../controllers/reminder_provider.dart';

/// A suggested reminder that can be enabled/disabled
class SuggestedReminder {
  SuggestedReminder({
    required this.title,
    required this.type,
    required this.frequency,
    this.customIntervalDays,
    this.description,
    this.isSelected = true,
  });

  final String title;
  final ReminderType type;
  final RepeatFrequency frequency;
  final int? customIntervalDays;
  final String? description;
  bool isSelected;
}

/// Dialog to show and select suggested reminders
class SuggestedRemindersDialog extends ConsumerStatefulWidget {
  const SuggestedRemindersDialog({
    super.key,
    required this.tankId,
    required this.tankName,
    required this.suggestions,
    this.filterId,
    this.contextTitle,
  });

  final int tankId;
  final String tankName;
  final List<SuggestedReminder> suggestions;
  final int? filterId;
  final String? contextTitle;

  @override
  ConsumerState<SuggestedRemindersDialog> createState() =>
      _SuggestedRemindersDialogState();
}

class _SuggestedRemindersDialogState
    extends ConsumerState<SuggestedRemindersDialog> {
  late List<SuggestedReminder> _suggestions;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _suggestions = widget.suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _suggestions.where((s) => s.isSelected).length;

    return AlertDialog(
      title: Text(widget.contextTitle ?? 'Set Up Reminders'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Would you like to set up reminders for "${widget.tankName}"?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ...List.generate(_suggestions.length, (index) {
              final suggestion = _suggestions[index];
              return CheckboxListTile(
                value: suggestion.isSelected,
                onChanged: (value) {
                  setState(() {
                    suggestion.isSelected = value ?? false;
                  });
                },
                title: Text('${suggestion.type.icon} ${suggestion.title}'),
                subtitle: Text(suggestion.frequency.displayName),
                dense: true,
                contentPadding: EdgeInsets.zero,
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context, false),
          child: const Text('Skip'),
        ),
        FilledButton(
          onPressed: _isSaving || selectedCount == 0 ? null : _createReminders,
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('Create ($selectedCount)'),
        ),
      ],
    );
  }

  Future<void> _createReminders() async {
    setState(() => _isSaving = true);

    try {
      final notifier = ref.read(reminderProvider.notifier);
      final now = DateTime.now();
      final selectedSuggestions = _suggestions
          .where((s) => s.isSelected)
          .toList();

      for (final suggestion in selectedSuggestions) {
        // Schedule the first occurrence based on frequency
        final scheduledAt = _calculateFirstOccurrence(now, suggestion);

        final reminder = ReminderEntity(
          tankId: widget.tankId,
          filterId: widget.filterId,
          title: suggestion.title,
          description: suggestion.description,
          reminderType: suggestion.type,
          scheduledAt: scheduledAt,
          repeatFrequency: suggestion.frequency,
          customIntervalDays: suggestion.customIntervalDays,
          isEnabled: true,
          isCompleted: false,
        );

        await notifier.addReminder(reminder);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Created ${selectedSuggestions.length} reminder${selectedSuggestions.length > 1 ? 's' : ''}',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating reminders: $e'),
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

  DateTime _calculateFirstOccurrence(
    DateTime now,
    SuggestedReminder suggestion,
  ) {
    // Set default time to 9:00 AM
    final baseTime = DateTime(now.year, now.month, now.day, 9, 0);

    switch (suggestion.frequency) {
      case RepeatFrequency.daily:
        return baseTime.add(const Duration(days: 1));
      case RepeatFrequency.weekly:
        return baseTime.add(const Duration(days: 7));
      case RepeatFrequency.biweekly:
        return baseTime.add(const Duration(days: 14));
      case RepeatFrequency.monthly:
        return baseTime.add(const Duration(days: 30));
      case RepeatFrequency.custom:
        final days = suggestion.customIntervalDays ?? 7;
        return baseTime.add(Duration(days: days));
      case RepeatFrequency.none:
        return baseTime.add(const Duration(days: 1));
    }
  }
}

/// Helper class to generate suggested reminders based on context
class ReminderSuggestions {
  /// Get suggested reminders for a new tank
  static List<SuggestedReminder> forNewTank(String tankType) {
    final suggestions = <SuggestedReminder>[
      SuggestedReminder(
        title: 'Water Change',
        type: ReminderType.waterChange,
        frequency: RepeatFrequency.weekly,
        description: 'Regular water change to maintain water quality',
      ),
      SuggestedReminder(
        title: 'Water Test',
        type: ReminderType.waterTest,
        frequency: RepeatFrequency.weekly,
        description: 'Test water parameters (pH, ammonia, nitrite, nitrate)',
      ),
      SuggestedReminder(
        title: 'Glass Cleaning',
        type: ReminderType.cleaning,
        frequency: RepeatFrequency.weekly,
        description: 'Clean algae from glass',
        isSelected: false,
      ),
    ];

    // Add tank-type specific suggestions
    if (tankType == 'planted' || tankType == 'shrimp') {
      suggestions.add(
        SuggestedReminder(
          title: 'Fertilizing',
          type: ReminderType.fertilizing,
          frequency: RepeatFrequency.weekly,
          description: 'Add liquid fertilizer',
        ),
      );
    }

    if (tankType == 'reef' || tankType == 'saltwater') {
      suggestions.add(
        SuggestedReminder(
          title: 'Salinity Check',
          type: ReminderType.waterTest,
          frequency: RepeatFrequency.daily,
          description: 'Check salinity/specific gravity',
        ),
      );
    }

    return suggestions;
  }

  /// Get suggested reminders for a new filter
  static List<SuggestedReminder> forNewFilter(
    String filterName,
    String filterType,
  ) {
    final suggestions = <SuggestedReminder>[];

    // Determine cleaning interval based on filter type
    int cleaningDays = 14; // default 2 weeks
    int mediaReplacementDays = 90; // default 3 months

    if (filterType == 'sponge') {
      cleaningDays = 7;
    } else if (filterType == 'canister') {
      cleaningDays = 30;
      mediaReplacementDays = 180;
    } else if (filterType == 'hob') {
      cleaningDays = 14;
      mediaReplacementDays = 30;
    }

    suggestions.add(
      SuggestedReminder(
        title: '$filterName Cleaning',
        type: ReminderType.maintenance,
        frequency: RepeatFrequency.custom,
        customIntervalDays: cleaningDays,
        description: 'Clean filter media in tank water',
      ),
    );

    suggestions.add(
      SuggestedReminder(
        title: '$filterName Media Replacement',
        type: ReminderType.maintenance,
        frequency: RepeatFrequency.custom,
        customIntervalDays: mediaReplacementDays,
        description: 'Replace filter media/cartridge',
        isSelected: false,
      ),
    );

    return suggestions;
  }

  /// Get suggested reminders for new lighting
  static List<SuggestedReminder> forNewLighting(
    String lightingName,
    String lightType,
  ) {
    final suggestions = <SuggestedReminder>[];

    // Determine bulb replacement interval based on light type
    int replacementDays = 365; // default 1 year

    if (lightType == 't5' || lightType == 't8') {
      replacementDays = 365; // 1 year for fluorescent
    } else if (lightType == 'led') {
      replacementDays = 730; // 2 years for LED (or never)
    } else if (lightType == 'metal_halide') {
      replacementDays = 365;
    }

    if (lightType != 'led') {
      suggestions.add(
        SuggestedReminder(
          title: '$lightingName Bulb Replacement',
          type: ReminderType.maintenance,
          frequency: RepeatFrequency.custom,
          customIntervalDays: replacementDays,
          description: 'Replace light bulb to maintain spectrum and intensity',
        ),
      );
    }

    return suggestions;
  }
}
