import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Driftwood type enum for database
enum DriftwoodTypeDb {
  manzanita,
  spiderWood,
  malaysian,
  mopani,
  cholla,
  bogwood,
  redmoor,
  sumatra,
  savanna,
  bonsai,
  branch,
  other,
}

/// Table for storing driftwood (hardscape)
class Driftwoods extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Driftwood name/label
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Type of driftwood
  IntColumn get driftwoodType =>
      intEnum<DriftwoodTypeDb>().withDefault(const Constant(0))();

  /// Whether the wood has been properly cured/waterlogged
  BoolColumn get isCured => boolean().withDefault(const Constant(false))();

  /// Whether the wood is currently releasing tannins
  BoolColumn get isReleasingTannins =>
      boolean().withDefault(const Constant(true))();

  /// Quantity of pieces
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Length in cm
  RealColumn get lengthCm => real().nullable()();

  /// Width in cm
  RealColumn get widthCm => real().nullable()();

  /// Height in cm
  RealColumn get heightCm => real().nullable()();

  /// Purchase price
  RealColumn get purchasePrice => real().nullable()();

  /// Source/store where purchased
  TextColumn get source => text().nullable()();

  /// Date added to tank
  DateTimeColumn get dateAdded => dateTime().nullable()();

  /// Date curing was started (soaking)
  DateTimeColumn get curingStartDate => dateTime().nullable()();

  /// Photo URL or path
  TextColumn get photoUrl => text().nullable()();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

