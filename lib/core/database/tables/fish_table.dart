import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Water type for fish
enum WaterTypeDb { freshwater, saltwater, brackish }

/// Fish temperament
enum FishTemperamentDb {
  peaceful,
  semiAggressive,
  aggressive,
  territorial,
  schooling,
  shy,
}

/// Fish diet type
enum FishDietDb {
  carnivore,
  herbivore,
  omnivore,
  insectivore,
  piscivore,
  detritivore,
}

/// Care level difficulty
enum CareLevelDb { beginner, intermediate, advanced, expert }

/// Swimming level in tank
enum SwimmingLevelDb { top, middle, bottom, all }

/// Table for storing fish
class Fish extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Species scientific name
  TextColumn get species => text().withLength(min: 1, max: 200)();

  /// Common name
  TextColumn get commonName => text().nullable()();

  /// Number of this species in tank
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Water type preference
  IntColumn get waterType =>
      intEnum<WaterTypeDb>().withDefault(const Constant(0))();

  /// Fish temperament
  IntColumn get temperament => intEnum<FishTemperamentDb>().nullable()();

  /// Diet type
  IntColumn get diet => intEnum<FishDietDb>().nullable()();

  /// Care level difficulty
  IntColumn get careLevel => intEnum<CareLevelDb>().nullable()();

  /// Swimming level in tank
  IntColumn get swimmingLevel => intEnum<SwimmingLevelDb>().nullable()();

  /// Maximum adult size in cm
  RealColumn get maxSizeCm => real().nullable()();

  /// Current size in cm
  RealColumn get currentSizeCm => real().nullable()();

  /// Minimum tank size in liters
  RealColumn get minTankSizeLiters => real().nullable()();

  /// Minimum temperature in Celsius
  RealColumn get minTempCelsius => real().nullable()();

  /// Maximum temperature in Celsius
  RealColumn get maxTempCelsius => real().nullable()();

  /// Minimum pH
  RealColumn get minPh => real().nullable()();

  /// Maximum pH
  RealColumn get maxPh => real().nullable()();

  /// Lifespan in years
  IntColumn get lifespanYears => integer().nullable()();

  /// Date added to tank
  DateTimeColumn get dateAdded => dateTime().nullable()();

  /// Date of death (if deceased)
  DateTimeColumn get dateDeceased => dateTime().nullable()();

  /// Purchase price
  RealColumn get purchasePrice => real().nullable()();

  /// Source/store where purchased
  TextColumn get source => text().nullable()();

  /// Is this fish quarantined
  BoolColumn get isQuarantined =>
      boolean().withDefault(const Constant(false))();

  /// Quarantine end date
  DateTimeColumn get quarantineEndDate => dateTime().nullable()();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Photo URL or path
  TextColumn get photoUrl => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
