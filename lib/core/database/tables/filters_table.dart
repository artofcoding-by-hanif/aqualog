import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Filter types for aquarium filtration
enum FilterType {
  hob,
  canister,
  sponge,
  internal,
  sump,
  undergravel,
  fluidizedBed,
  wetDry,
  other,
}

/// Table for storing aquarium filters
class Filters extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Filter name/label
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Filter type
  IntColumn get filterType => intEnum<FilterType>()();

  /// Brand name
  TextColumn get brand => text().nullable()();

  /// Model number/name
  TextColumn get model => text().nullable()();

  /// Flow rate in liters per hour
  RealColumn get flowRateLph => real().nullable()();

  /// Media volume capacity in liters
  RealColumn get mediaVolumeLiters => real().nullable()();

  /// Last cleaned date
  DateTimeColumn get lastCleanedAt => dateTime().nullable()();

  /// Last media replacement date
  DateTimeColumn get mediaReplacedAt => dateTime().nullable()();

  /// Recommended cleaning interval in days
  IntColumn get cleaningIntervalDays =>
      integer().withDefault(const Constant(14))();

  /// Recommended media replacement interval in days
  IntColumn get mediaReplacementIntervalDays =>
      integer().withDefault(const Constant(90))();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

