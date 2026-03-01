import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Types of maintenance activities
enum MaintenanceType {
  waterChange,
  filterCleaning,
  glassCleaning,
  substrateCleaning,
  trimming,
  equipmentMaintenance,
  medicationDose,
  other,
}

/// Table for storing maintenance activity logs
class MaintenanceLogs extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Type of maintenance
  IntColumn get maintenanceType => intEnum<MaintenanceType>()();

  /// Title/description
  TextColumn get title => text().withLength(min: 1, max: 100)();

  /// Detailed notes
  TextColumn get notes => text().nullable()();

  /// For water changes: percentage changed
  RealColumn get waterChangePercent => real().nullable()();

  /// For water changes: liters changed
  RealColumn get waterChangeLiters => real().nullable()();

  /// Performed at
  DateTimeColumn get performedAt => dateTime()();

  /// Duration in minutes
  IntColumn get durationMinutes => integer().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

