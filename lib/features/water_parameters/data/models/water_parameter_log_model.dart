import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/water_parameter_log.dart';

/// Extension to map between Drift WaterParameter and WaterParameterLogEntity
extension WaterParameterLogMapper on WaterParameter {
  /// Convert Drift WaterParameter to domain WaterParameterLogEntity
  WaterParameterLogEntity toEntity() {
    return WaterParameterLogEntity(
      id: id,
      tankId: tankId,
      temperatureCelsius: temperatureCelsius,
      ph: ph,
      ammoniaPpm: ammoniaPpm,
      nitritePpm: nitritePpm,
      nitratePpm: nitratePpm,
      ghDgh: ghDgh,
      khDkh: khDkh,
      phosphatePpm: phosphatePpm,
      oxygenMgL: oxygenMgL,
      co2MgL: co2MgL,
      tdsPpm: tdsPpm,
      chlorinePpm: chlorinePpm,
      ironPpm: ironPpm,
      copperPpm: copperPpm,
      salinityPpt: salinityPpt,
      calciumPpm: calciumPpm,
      magnesiumPpm: magnesiumPpm,
      alkalinityDkh: alkalinityDkh,
      measuredAt: measuredAt,
      notes: notes,
      createdAt: createdAt,
    );
  }
}

/// Extension to convert WaterParameterLogEntity to Drift companion for insert/update
extension WaterParameterLogEntityMapper on WaterParameterLogEntity {
  /// Convert domain WaterParameterLogEntity to Drift WaterParametersCompanion for insert
  WaterParametersCompanion toCompanion() {
    return WaterParametersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      temperatureCelsius: Value(temperatureCelsius),
      ph: Value(ph),
      ammoniaPpm: Value(ammoniaPpm),
      nitritePpm: Value(nitritePpm),
      nitratePpm: Value(nitratePpm),
      ghDgh: Value(ghDgh),
      khDkh: Value(khDkh),
      phosphatePpm: Value(phosphatePpm),
      oxygenMgL: Value(oxygenMgL),
      co2MgL: Value(co2MgL),
      tdsPpm: Value(tdsPpm),
      chlorinePpm: Value(chlorinePpm),
      ironPpm: Value(ironPpm),
      copperPpm: Value(copperPpm),
      salinityPpt: Value(salinityPpt),
      calciumPpm: Value(calciumPpm),
      magnesiumPpm: Value(magnesiumPpm),
      alkalinityDkh: Value(alkalinityDkh),
      measuredAt: Value(measuredAt),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
    );
  }

  /// Convert to Drift WaterParameter for update
  WaterParameter toDriftWaterParameter() {
    return WaterParameter(
      id: id!,
      tankId: tankId,
      temperatureCelsius: temperatureCelsius,
      ph: ph,
      ammoniaPpm: ammoniaPpm,
      nitritePpm: nitritePpm,
      nitratePpm: nitratePpm,
      ghDgh: ghDgh,
      khDkh: khDkh,
      phosphatePpm: phosphatePpm,
      oxygenMgL: oxygenMgL,
      co2MgL: co2MgL,
      tdsPpm: tdsPpm,
      chlorinePpm: chlorinePpm,
      ironPpm: ironPpm,
      copperPpm: copperPpm,
      salinityPpt: salinityPpt,
      calciumPpm: calciumPpm,
      magnesiumPpm: magnesiumPpm,
      alkalinityDkh: alkalinityDkh,
      measuredAt: measuredAt,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
