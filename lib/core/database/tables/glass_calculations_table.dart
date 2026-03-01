import 'package:drift/drift.dart';

/// Table for storing saved glass calculations
class GlassCalculations extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Name/label for this calculation
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Tank length in mm
  RealColumn get lengthMm => real()();

  /// Tank width in mm
  RealColumn get widthMm => real()();

  /// Tank height in mm
  RealColumn get heightMm => real()();

  /// Glass thickness in mm
  RealColumn get glassThicknessMm => real()();

  /// Glue/silicone thickness in mm
  RealColumn get glueThicknessMm => real().withDefault(const Constant(1.0))();

  /// Calculated volume in liters
  RealColumn get volumeLiters => real()();

  /// Bottom glass length in mm
  RealColumn get bottomLengthMm => real()();

  /// Bottom glass width in mm
  RealColumn get bottomWidthMm => real()();

  /// Front/back glass length in mm
  RealColumn get frontBackLengthMm => real()();

  /// Front/back glass height in mm
  RealColumn get frontBackHeightMm => real()();

  /// Side glass width in mm
  RealColumn get sideWidthMm => real()();

  /// Side glass height in mm
  RealColumn get sideHeightMm => real()();

  /// Total glass area in square meters
  RealColumn get totalGlassAreaSqM => real()();

  /// Estimated glass weight in kg
  RealColumn get estimatedWeightKg => real()();

  /// Notes
  TextColumn get notes => text().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
