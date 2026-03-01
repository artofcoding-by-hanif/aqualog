import 'package:drift/drift.dart';
import 'reminders_table.dart' show FoodType;
import 'tanks_table.dart';

/// Fish response to feeding
enum FeedingResponse {
  ateEagerly,
  ateNormally,
  ateSome,
  picky,
  ignored,
  unknown,
}

/// Table for storing feeding logs
class FeedingLogs extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Type of food given
  IntColumn get foodType => intEnum<FoodType>()();

  /// Food brand/name (optional)
  TextColumn get foodName => text().nullable()();

  /// Amount description (e.g., "pinch", "2 pellets", "1 cube")
  TextColumn get amount => text().nullable()();

  /// Fish response to the feeding
  IntColumn get response => intEnum<FeedingResponse>().withDefault(
    Constant(FeedingResponse.unknown.index),
  )();

  /// When the feeding occurred
  DateTimeColumn get fedAt => dateTime()();

  /// Additional notes
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
