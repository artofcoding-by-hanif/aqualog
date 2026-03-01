import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Lighting types for aquarium lighting
enum LightingTypeDb {
  led,
  fluorescent,
  t5,
  t8,
  metalHalide,
  incandescent,
  compactFluorescent,
  other,
}

/// Light spectrum categories
enum LightSpectrumDb {
  daylight,
  warmWhite,
  coolWhite,
  fullSpectrum,
  plantGrowth,
  actinicBlue,
  rgb,
  custom,
}

/// Table for storing aquarium lighting fixtures
class Lightings extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Light name/label
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Lighting type
  IntColumn get lightingType => intEnum<LightingTypeDb>()();

  /// Brand name
  TextColumn get brand => text().nullable()();

  /// Model number/name
  TextColumn get model => text().nullable()();

  /// Power consumption in watts
  RealColumn get wattage => real().nullable()();

  /// Color temperature in Kelvin
  IntColumn get kelvinRating => integer().nullable()();

  /// Light spectrum category
  IntColumn get spectrum => intEnum<LightSpectrumDb>().nullable()();

  /// PAR (Photosynthetically Active Radiation) value at substrate
  IntColumn get parValue => integer().nullable()();

  /// Lumens output
  IntColumn get lumens => integer().nullable()();

  /// Whether the light is dimmable
  BoolColumn get isDimmable => boolean().withDefault(const Constant(false))();

  /// Whether the light has timer functionality
  BoolColumn get hasTimer => boolean().withDefault(const Constant(false))();

  /// Whether the light has color control (RGB)
  BoolColumn get hasColorControl =>
      boolean().withDefault(const Constant(false))();

  /// Light on time (HH:mm format)
  TextColumn get onTime => text().nullable()();

  /// Light off time (HH:mm format)
  TextColumn get offTime => text().nullable()();

  /// Current intensity percentage (0-100)
  IntColumn get intensityPercent =>
      integer().withDefault(const Constant(100))();

  /// Last bulb/LED replacement date
  DateTimeColumn get lastReplacedAt => dateTime().nullable()();

  /// Recommended replacement interval in days
  IntColumn get replacementIntervalDays =>
      integer().withDefault(const Constant(365))();

  /// Notes/additional info
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

