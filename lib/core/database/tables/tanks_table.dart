import 'package:drift/drift.dart';

/// Tank/Aquarium types
enum TankType { freshwater, saltwater, brackish, planted, reef, shrimp, pond }

/// Table for storing aquarium/tank information
class Tanks extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Tank name (e.g., "Living Room Tank")
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Tank type
  IntColumn get tankType => intEnum<TankType>()();

  /// Volume in liters
  RealColumn get volumeLiters => real()();

  /// Length in cm
  RealColumn get lengthCm => real().nullable()();

  /// Width in cm
  RealColumn get widthCm => real().nullable()();

  /// Height in cm
  RealColumn get heightCm => real().nullable()();

  /// Description/notes
  TextColumn get description => text().nullable()();

  /// Photo path (local storage)
  TextColumn get photoPath => text().nullable()();

  /// Setup date
  DateTimeColumn get setupDate => dateTime().nullable()();

  /// Whether this is the currently selected/active tank
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
