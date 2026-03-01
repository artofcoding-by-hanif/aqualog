import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/glass_calculation.dart';

/// Extension to map between Drift GlassCalculation and GlassCalculationEntity
extension GlassCalculationMapper on GlassCalculation {
  /// Convert Drift GlassCalculation to domain GlassCalculationEntity
  GlassCalculationEntity toEntity() {
    return GlassCalculationEntity(
      id: id,
      name: name,
      lengthMm: lengthMm,
      widthMm: widthMm,
      heightMm: heightMm,
      glassThicknessMm: glassThicknessMm,
      glueThicknessMm: glueThicknessMm,
      volumeLiters: volumeLiters,
      bottomLengthMm: bottomLengthMm,
      bottomWidthMm: bottomWidthMm,
      frontBackLengthMm: frontBackLengthMm,
      frontBackHeightMm: frontBackHeightMm,
      sideWidthMm: sideWidthMm,
      sideHeightMm: sideHeightMm,
      totalGlassAreaSqM: totalGlassAreaSqM,
      estimatedWeightKg: estimatedWeightKg,
      notes: notes,
      createdAt: createdAt,
    );
  }
}

/// Extension to convert GlassCalculationEntity to Drift companion
extension GlassCalculationEntityMapper on GlassCalculationEntity {
  /// Convert domain GlassCalculationEntity to Drift companion for insert
  GlassCalculationsCompanion toCompanion() {
    return GlassCalculationsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      lengthMm: Value(lengthMm),
      widthMm: Value(widthMm),
      heightMm: Value(heightMm),
      glassThicknessMm: Value(glassThicknessMm),
      glueThicknessMm: Value(glueThicknessMm),
      volumeLiters: Value(volumeLiters),
      bottomLengthMm: Value(bottomLengthMm),
      bottomWidthMm: Value(bottomWidthMm),
      frontBackLengthMm: Value(frontBackLengthMm),
      frontBackHeightMm: Value(frontBackHeightMm),
      sideWidthMm: Value(sideWidthMm),
      sideHeightMm: Value(sideHeightMm),
      totalGlassAreaSqM: Value(totalGlassAreaSqM),
      estimatedWeightKg: Value(estimatedWeightKg),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
    );
  }

  /// Convert domain GlassCalculationEntity to Drift GlassCalculation for update
  GlassCalculation toDriftGlassCalculation() {
    return GlassCalculation(
      id: id!,
      name: name,
      lengthMm: lengthMm,
      widthMm: widthMm,
      heightMm: heightMm,
      glassThicknessMm: glassThicknessMm,
      glueThicknessMm: glueThicknessMm,
      volumeLiters: volumeLiters,
      bottomLengthMm: bottomLengthMm,
      bottomWidthMm: bottomWidthMm,
      frontBackLengthMm: frontBackLengthMm,
      frontBackHeightMm: frontBackHeightMm,
      sideWidthMm: sideWidthMm,
      sideHeightMm: sideHeightMm,
      totalGlassAreaSqM: totalGlassAreaSqM,
      estimatedWeightKg: estimatedWeightKg,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}

