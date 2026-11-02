import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Plant type for database
enum PlantTypeDb {
  stem,
  rosette,
  carpet,
  floating,
  moss,
  fern,
  rhizome,
  bulb,
  other,
}

/// Lighting requirement for database
enum LightingRequirementDb { low, medium, high, veryHigh }

/// CO2 requirement for database
enum CO2RequirementDb { none, low, medium, high }

/// Growth rate for database
enum GrowthRateDb { slow, medium, fast }

/// Placement zone for database
enum PlacementZoneDb { foreground, midground, background, floating }

/// Difficulty level for database
enum PlantDifficultyLevelDb { easy, moderate, difficult, expert }

/// Table for storing aquarium plants
class Plants extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Species scientific name
  TextColumn get species => text().withLength(min: 1, max: 200)();

  /// Common name
  TextColumn get commonName => text().nullable()();

  /// Type of plant
  IntColumn get plantType =>
      intEnum<PlantTypeDb>().withDefault(const Constant(0))();

  /// Number of this species in tank
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Placement zone in tank
  IntColumn get placementZone => intEnum<PlacementZoneDb>().nullable()();

  /// Lighting requirement
  IntColumn get lightingRequirement =>
      intEnum<LightingRequirementDb>().nullable()();

  /// CO2 requirement
  IntColumn get co2Requirement =>
      intEnum<CO2RequirementDb>().withDefault(const Constant(0))();

  /// Growth rate
  IntColumn get growthRate => intEnum<GrowthRateDb>().nullable()();

  /// Difficulty level
  IntColumn get difficultyLevel =>
      intEnum<PlantDifficultyLevelDb>().nullable()();

  /// Maximum height in cm
  RealColumn get maxHeightCm => real().nullable()();

  /// Current height in cm
  RealColumn get currentHeightCm => real().nullable()();

  /// Minimum temperature in Celsius
  RealColumn get minTempCelsius => real().nullable()();

  /// Maximum temperature in Celsius
  RealColumn get maxTempCelsius => real().nullable()();

  /// Minimum pH
  RealColumn get minPh => real().nullable()();

  /// Maximum pH
  RealColumn get maxPh => real().nullable()();

  /// Date added to tank
  DateTimeColumn get dateAdded => dateTime().nullable()();

  /// Date removed from tank
  DateTimeColumn get dateRemoved => dateTime().nullable()();

  /// Is this plant propagated from another
  BoolColumn get isPropagated => boolean().withDefault(const Constant(false))();

  /// Parent plant ID (if propagated)
  IntColumn get parentPlantId => integer().nullable()();

  /// Purchase price
  RealColumn get purchasePrice => real().nullable()();

  /// Source/store where purchased
  TextColumn get source => text().nullable()();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Photo URL or path
  TextColumn get photoUrl => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
