import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Types of fertilizer
enum FertilizerType {
  macro,
  micro,
  iron,
  potassium,
  nitrogen,
  phosphorus,
  carbonSource,
  allInOne,
  substrate,
  other,
}

/// Table for storing fertilizer products
class Fertilizers extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Product name
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Brand
  TextColumn get brand => text().nullable()();

  /// Type of fertilizer
  IntColumn get fertilizerType => intEnum<FertilizerType>()();

  /// Recommended dosage per liter
  RealColumn get dosageMlPerLiter => real().nullable()();

  /// Notes/instructions
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Table for storing fertilization logs/schedule
class FertilizationLogs extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Foreign key to fertilizers table
  IntColumn get fertilizerId => integer().references(Fertilizers, #id)();

  /// Dosage amount in ml
  RealColumn get dosageMl => real()();

  /// Date/time of application
  DateTimeColumn get appliedAt => dateTime()();

  /// Notes
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

