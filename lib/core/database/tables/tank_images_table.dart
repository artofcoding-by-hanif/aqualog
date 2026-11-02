import 'package:drift/drift.dart';

import 'tanks_table.dart';

/// Table for storing tank images (gallery)
class TankImages extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to tank
  IntColumn get tankId => integer().references(Tanks, #id)();

  /// Image file path (local storage)
  TextColumn get imagePath => text()();

  /// Optional caption/description
  TextColumn get caption => text().nullable()();

  /// Whether this is the cover/primary image for the tank
  BoolColumn get isCover => boolean().withDefault(const Constant(false))();

  /// Date the photo was taken (if available)
  DateTimeColumn get takenAt => dateTime().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
