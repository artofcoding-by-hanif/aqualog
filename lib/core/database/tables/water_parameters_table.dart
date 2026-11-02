import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Table for storing water parameter readings
class WaterParameters extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Measurement timestamp
  DateTimeColumn get measuredAt => dateTime()();

  /// Temperature in Celsius
  RealColumn get temperatureCelsius => real().nullable()();

  /// pH level (0-14)
  RealColumn get ph => real().nullable()();

  /// Ammonia in ppm
  RealColumn get ammoniaPpm => real().nullable()();

  /// Nitrite in ppm
  RealColumn get nitritePpm => real().nullable()();

  /// Nitrate in ppm
  RealColumn get nitratePpm => real().nullable()();

  /// General Hardness (GH) in dGH
  RealColumn get ghDgh => real().nullable()();

  /// Carbonate Hardness (KH) in dKH
  RealColumn get khDkh => real().nullable()();

  /// Phosphate in ppm
  RealColumn get phosphatePpm => real().nullable()();

  /// Dissolved oxygen in mg/L
  RealColumn get oxygenMgL => real().nullable()();

  /// Carbon dioxide in mg/L
  RealColumn get co2MgL => real().nullable()();

  /// Salinity in ppt (for saltwater)
  RealColumn get salinityPpt => real().nullable()();

  /// Calcium in ppm (for reef tanks)
  RealColumn get calciumPpm => real().nullable()();

  /// Magnesium in ppm (for reef tanks)
  RealColumn get magnesiumPpm => real().nullable()();

  /// Alkalinity in dKH (for reef tanks)
  RealColumn get alkalinityDkh => real().nullable()();

  /// TDS (Total Dissolved Solids) in ppm
  RealColumn get tdsPpm => real().nullable()();

  /// Chlorine in ppm
  RealColumn get chlorinePpm => real().nullable()();

  /// Iron in ppm (for planted tanks)
  RealColumn get ironPpm => real().nullable()();

  /// Copper in ppm
  RealColumn get copperPpm => real().nullable()();

  /// Notes for this reading
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
