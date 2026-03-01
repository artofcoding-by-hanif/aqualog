import 'package:drift/drift.dart';

import 'tanks_table.dart';

/// Database enum for substrate types
enum SubstrateTypeDb {
  aquaSoil,
  gravel,
  sand,
  crushedCoral,
  fluorite,
  ecoComplete,
  stratum,
  controsoil,
  amazonia,
  powerSand,
  lavaRockSubstrate,
  peat,
  clay,
  rootTabs,
  other,
}

/// Table for storing substrate layers
class SubstrateLayers extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Layer name/label
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Type of substrate
  IntColumn get substrateType =>
      intEnum<SubstrateTypeDb>().withDefault(const Constant(0))();

  /// Brand name
  TextColumn get brand => text().nullable()();

  /// Depth of layer in cm
  RealColumn get depthCm => real().nullable()();

  /// Layer order (0 = bottom, higher = top)
  IntColumn get layerOrder => integer().withDefault(const Constant(0))();

  /// Volume in liters
  RealColumn get volumeLiters => real().nullable()();

  /// Weight in kg
  RealColumn get weightKg => real().nullable()();

  /// Color of the substrate
  TextColumn get color => text().nullable()();

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
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

