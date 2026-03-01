import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Types of equipment
enum EquipmentType {
  filter,
  heater,
  light,
  pump,
  co2System,
  airPump,
  skimmer,
  wavemaker,
  autoFeeder,
  dosingPump,
  controller,
  thermometer,
  testKit,
  other,
}

/// Equipment status
enum EquipmentStatus {
  active,
  inactive,
  maintenance,
  broken,
  replaced,
}

/// Table for storing equipment
class Equipment extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Equipment name/model
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Brand
  TextColumn get brand => text().nullable()();

  /// Model number
  TextColumn get model => text().nullable()();

  /// Type of equipment
  IntColumn get equipmentType => intEnum<EquipmentType>()();

  /// Current status
  IntColumn get status =>
      intEnum<EquipmentStatus>().withDefault(const Constant(0))();

  /// Wattage/power consumption
  RealColumn get wattage => real().nullable()();

  /// Purchase date
  DateTimeColumn get purchaseDate => dateTime().nullable()();

  /// Purchase price
  RealColumn get purchasePrice => real().nullable()();

  /// Warranty expiry date
  DateTimeColumn get warrantyExpiry => dateTime().nullable()();

  /// Last maintenance date
  DateTimeColumn get lastMaintenanceAt => dateTime().nullable()();

  /// Maintenance interval in days
  IntColumn get maintenanceIntervalDays => integer().nullable()();

  /// Notes
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

