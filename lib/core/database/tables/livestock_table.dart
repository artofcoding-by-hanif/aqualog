import 'package:drift/drift.dart';
import 'tanks_table.dart';

/// Types of livestock
enum LivestockType {
  fish,
  invertebrate,
  coral,
  plant,
  other,
}

/// Health status of livestock
enum HealthStatus {
  healthy,
  sick,
  quarantine,
  deceased,
  unknown,
}

/// Table for storing livestock (fish, invertebrates, plants, etc.)
class Livestock extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tanks table
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Common name (e.g., "Neon Tetra")
  TextColumn get commonName => text().withLength(min: 1, max: 100)();

  /// Scientific name (e.g., "Paracheirodon innesi")
  TextColumn get scientificName => text().nullable()();

  /// Type of livestock
  IntColumn get livestockType => intEnum<LivestockType>()();

  /// Quantity/count
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Current health status
  IntColumn get healthStatus =>
      intEnum<HealthStatus>().withDefault(const Constant(0))();

  /// Date acquired/added
  DateTimeColumn get acquiredAt => dateTime().nullable()();

  /// Purchase price
  RealColumn get purchasePrice => real().nullable()();

  /// Photo path
  TextColumn get photoPath => text().nullable()();

  /// Notes
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

