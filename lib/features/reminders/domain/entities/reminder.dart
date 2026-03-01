import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';

/// Types of fish food (for feeding reminders)
enum FoodType {
  flakes,
  pellets,
  granules,
  frozen,
  freezeDried,
  live,
  gel,
  vegetables,
  algaeWafer,
  sinkingPellets,
  other;

  /// Display name for the food type
  String get displayName {
    switch (this) {
      case FoodType.flakes:
        return 'Flakes';
      case FoodType.pellets:
        return 'Pellets';
      case FoodType.granules:
        return 'Granules';
      case FoodType.frozen:
        return 'Frozen';
      case FoodType.freezeDried:
        return 'Freeze-Dried';
      case FoodType.live:
        return 'Live Food';
      case FoodType.gel:
        return 'Gel Food';
      case FoodType.vegetables:
        return 'Vegetables';
      case FoodType.algaeWafer:
        return 'Algae Wafer';
      case FoodType.sinkingPellets:
        return 'Sinking Pellets';
      case FoodType.other:
        return 'Other';
    }
  }

  /// Icon for the food type
  String get icon {
    switch (this) {
      case FoodType.flakes:
        return '🥣';
      case FoodType.pellets:
        return '⚫';
      case FoodType.granules:
        return '🔘';
      case FoodType.frozen:
        return '🧊';
      case FoodType.freezeDried:
        return '🦐';
      case FoodType.live:
        return '🪱';
      case FoodType.gel:
        return '🟢';
      case FoodType.vegetables:
        return '🥬';
      case FoodType.algaeWafer:
        return '🟤';
      case FoodType.sinkingPellets:
        return '⬇️';
      case FoodType.other:
        return '🍽️';
    }
  }
}

/// Types of reminders
enum ReminderType {
  waterChange,
  feeding,
  fertilizing,
  cleaning,
  maintenance,
  waterTest,
  medicationDose,
  custom;

  /// Display name for the reminder type
  String get displayName {
    switch (this) {
      case ReminderType.waterChange:
        return 'Water Change';
      case ReminderType.feeding:
        return 'Feeding';
      case ReminderType.fertilizing:
        return 'Fertilizing';
      case ReminderType.cleaning:
        return 'Cleaning';
      case ReminderType.maintenance:
        return 'Maintenance';
      case ReminderType.waterTest:
        return 'Water Test';
      case ReminderType.medicationDose:
        return 'Medication Dose';
      case ReminderType.custom:
        return 'Custom';
    }
  }

  /// Icon for the reminder type
  String get icon {
    switch (this) {
      case ReminderType.waterChange:
        return '💧';
      case ReminderType.feeding:
        return '🍽️';
      case ReminderType.fertilizing:
        return '🌱';
      case ReminderType.cleaning:
        return '🧹';
      case ReminderType.maintenance:
        return '🔧';
      case ReminderType.waterTest:
        return '🧪';
      case ReminderType.medicationDose:
        return '💊';
      case ReminderType.custom:
        return '📝';
    }
  }
}

/// Repeat frequency for reminders
enum RepeatFrequency {
  none,
  daily,
  weekly,
  biweekly,
  monthly,
  custom;

  /// Display name for the frequency
  String get displayName {
    switch (this) {
      case RepeatFrequency.none:
        return 'One-time';
      case RepeatFrequency.daily:
        return 'Daily';
      case RepeatFrequency.weekly:
        return 'Weekly';
      case RepeatFrequency.biweekly:
        return 'Every 2 Weeks';
      case RepeatFrequency.monthly:
        return 'Monthly';
      case RepeatFrequency.custom:
        return 'Custom';
    }
  }

  /// Number of days for this frequency (null for none/custom)
  int? get intervalDays {
    switch (this) {
      case RepeatFrequency.none:
        return null;
      case RepeatFrequency.daily:
        return 1;
      case RepeatFrequency.weekly:
        return 7;
      case RepeatFrequency.biweekly:
        return 14;
      case RepeatFrequency.monthly:
        return 30; // Approximate
      case RepeatFrequency.custom:
        return null;
    }
  }
}

/// Reminder entity using Freezed pattern
@freezed
abstract class ReminderEntity with _$ReminderEntity {
  const ReminderEntity._();

  const factory ReminderEntity({
    /// Unique identifier (null for new reminders)
    int? id,

    /// Tank ID this reminder belongs to (null for global reminders)
    int? tankId,

    /// Filter ID this reminder is linked to (null for non-filter reminders)
    int? filterId,

    /// Food type for feeding reminders (null for non-feeding reminders)
    FoodType? foodType,

    /// Reminder title
    required String title,

    /// Description/notes
    String? description,

    /// Type of reminder
    required ReminderType reminderType,

    /// Scheduled date/time
    required DateTime scheduledAt,

    /// Repeat frequency
    @Default(RepeatFrequency.none) RepeatFrequency repeatFrequency,

    /// Custom repeat interval in days (when repeatFrequency is custom)
    int? customIntervalDays,

    /// Whether the reminder is enabled
    @Default(true) bool isEnabled,

    /// Whether the reminder has been completed
    @Default(false) bool isCompleted,

    /// Last completed timestamp
    DateTime? lastCompletedAt,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _ReminderEntity;

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Get the effective interval in days
  int get effectiveIntervalDays {
    if (repeatFrequency == RepeatFrequency.custom) {
      return customIntervalDays ?? 7;
    }
    return repeatFrequency.intervalDays ?? 0;
  }

  /// Calculate the next due date based on last completion or scheduled time
  DateTime get nextDueAt {
    if (repeatFrequency == RepeatFrequency.none) {
      return scheduledAt;
    }

    // If never completed, the first due date is the scheduled date
    if (lastCompletedAt == null) {
      return scheduledAt;
    }

    final baseDate = lastCompletedAt!;
    final interval = effectiveIntervalDays;

    if (interval == 0) return scheduledAt;

    // For monthly, handle month addition properly
    if (repeatFrequency == RepeatFrequency.monthly) {
      return DateTime(
        baseDate.year,
        baseDate.month + 1,
        baseDate.day,
        baseDate.hour,
        baseDate.minute,
      );
    }

    return baseDate.add(Duration(days: interval));
  }

  /// Whether the reminder is overdue
  bool get isOverdue {
    if (isCompleted && repeatFrequency == RepeatFrequency.none) return false;
    return DateTime.now().isAfter(nextDueAt);
  }

  /// Whether the reminder is due today
  bool get isDueToday {
    final now = DateTime.now();
    final due = nextDueAt;
    return now.year == due.year && now.month == due.month && now.day == due.day;
  }

  /// Whether the reminder is due tomorrow
  bool get isDueTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final due = nextDueAt;
    return tomorrow.year == due.year &&
        tomorrow.month == due.month &&
        tomorrow.day == due.day;
  }

  /// Whether the reminder is due today or tomorrow
  bool get isDueTodayOrTomorrow {
    return isDueToday || isDueTomorrow;
  }

  /// Whether the reminder is due soon (within 24 hours)
  bool get isDueSoon {
    final now = DateTime.now();
    final due = nextDueAt;
    return due.isAfter(now) && due.isBefore(now.add(const Duration(hours: 24)));
  }

  /// Days until due (negative if overdue)
  int get daysUntilDue {
    final now = DateTime.now();
    final due = nextDueAt;
    // Compare calendar dates, not time differences
    final nowDate = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(due.year, due.month, due.day);
    return dueDate.difference(nowDate).inDays;
  }

  /// Human-readable due status
  String get dueStatusDisplay {
    if (isCompleted && repeatFrequency == RepeatFrequency.none) {
      return 'Completed';
    }

    final days = daysUntilDue;
    if (days < 0) {
      return 'Overdue by ${-days} day${-days == 1 ? '' : 's'}';
    } else if (days == 0) {
      return 'Due today';
    } else if (days == 1) {
      return 'Due tomorrow';
    } else {
      return 'Due in $days days';
    }
  }

  /// Frequency display string
  String get frequencyDisplay {
    if (repeatFrequency == RepeatFrequency.custom &&
        customIntervalDays != null) {
      return 'Every $customIntervalDays day${customIntervalDays == 1 ? '' : 's'}';
    }
    return repeatFrequency.displayName;
  }

  /// Whether this is a global reminder (not tank-specific)
  bool get isGlobal => tankId == null;

  /// Whether this is a filter-linked reminder
  bool get isFilterLinked => filterId != null;

  /// Whether this is a feeding reminder with food type specified
  bool get hasFoodType =>
      reminderType == ReminderType.feeding && foodType != null;

  /// Food type display for feeding reminders
  String? get foodTypeDisplay => foodType?.displayName;

  /// Summary info for display
  String get infoSummary {
    final parts = <String>[];
    if (hasFoodType) {
      parts.add('${foodType!.icon} ${foodType!.displayName}');
    }
    parts.add(frequencyDisplay);
    parts.add(dueStatusDisplay);
    return parts.join(' • ');
  }
}
