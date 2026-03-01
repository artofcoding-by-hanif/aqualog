import 'package:drift/drift.dart';
import 'filters_table.dart';
import 'tanks_table.dart';

/// Types of reminders
enum ReminderType {
  waterChange,
  feeding,
  fertilizing,
  cleaning,
  maintenance,
  waterTest,
  medicationDose,
  custom,
}

/// Repeat frequency
enum RepeatFrequency { none, daily, weekly, biweekly, monthly, custom }

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
  other,
}

/// Table for storing reminders
class Reminders extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table (nullable for global reminders)
  IntColumn get tankId => integer().references(Tanks, #id).nullable()();

  /// Foreign key to filters table (nullable, for filter-specific reminders)
  IntColumn get filterId => integer().references(Filters, #id).nullable()();

  /// Food type for feeding reminders (nullable, only used when reminderType is feeding)
  IntColumn get foodType => intEnum<FoodType>().nullable()();

  /// Reminder title
  TextColumn get title => text().withLength(min: 1, max: 100)();

  /// Description/notes
  TextColumn get description => text().nullable()();

  /// Type of reminder
  IntColumn get reminderType => intEnum<ReminderType>()();

  /// Scheduled date/time
  DateTimeColumn get scheduledAt => dateTime()();

  /// Repeat frequency
  IntColumn get repeatFrequency =>
      intEnum<RepeatFrequency>().withDefault(const Constant(0))();

  /// Custom repeat interval in days (when repeatFrequency is custom)
  IntColumn get customIntervalDays => integer().nullable()();

  /// Whether the reminder is enabled
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// Whether the reminder has been completed
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  /// Last completed timestamp
  DateTimeColumn get lastCompletedAt => dateTime().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
