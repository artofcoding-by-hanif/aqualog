import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Invertebrate type
enum InvertebrateTypeDb {
  shrimp,
  snail,
  crab,
  crayfish,
  clam,
  starfish,
  urchin,
  coral,
  anemone,
  other,
}

/// Water type for invertebrates
enum InvertWaterTypeDb { freshwater, saltwater, brackish }

/// Care level difficulty for invertebrates
enum InvertCareLevelDb { beginner, intermediate, advanced, expert }

/// Table for storing invertebrates (shrimp, snails, crabs, etc.)
class Invertebrates extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Species scientific name
  TextColumn get species => text().withLength(min: 1, max: 200)();

  /// Common name
  TextColumn get commonName => text().nullable()();

  /// Type of invertebrate
  IntColumn get invertebrateType =>
      intEnum<InvertebrateTypeDb>().withDefault(const Constant(0))();

  /// Number of this species in tank
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Water type preference
  IntColumn get waterType =>
      intEnum<InvertWaterTypeDb>().withDefault(const Constant(0))();

  /// Care level difficulty
  IntColumn get careLevel => intEnum<InvertCareLevelDb>().nullable()();

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

  /// Is this invertebrate quarantined
  BoolColumn get isQuarantined =>
      boolean().withDefault(const Constant(false))();

  /// Quarantine end date
  DateTimeColumn get quarantineEndDate => dateTime().nullable()();

  /// Is this a breeding colony
  BoolColumn get isBreedingColony =>
      boolean().withDefault(const Constant(false))();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Photo URL or path
  TextColumn get photoUrl => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
