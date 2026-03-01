import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Rock type enum for database
enum RockTypeDb {
  dragonStone,
  seiryu,
  lavaRock,
  slate,
  riverRock,
  petrifiedWood,
  texasHoley,
  rainbowRock,
  pagoda,
  elephantSkin,
  mapleLeaf,
  other,
}

/// Table for storing rocks (hardscape)
class Rocks extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Rock name/label
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Type of rock
  IntColumn get rockType => intEnum<RockTypeDb>().withDefault(const Constant(0))();

  /// Weight in kilograms
  RealColumn get weightKg => real().nullable()();

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

  /// Photo URL or path
  TextColumn get photoUrl => text().nullable()();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

