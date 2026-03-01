import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/plants_table.dart' as db_types;
import '../../domain/entities/plant.dart';

/// Extension to map between Drift Plant and PlantEntity
extension PlantMapper on Plant {
  /// Convert Drift Plant to domain PlantEntity
  PlantEntity toEntity() {
    return PlantEntity(
      id: id,
      tankId: tankId,
      species: species,
      commonName: commonName,
      plantType: _mapDbPlantType(plantType),
      quantity: quantity,
      placementZone: placementZone != null
          ? _mapDbPlacementZone(placementZone!)
          : null,
      lightingRequirement: lightingRequirement != null
          ? _mapDbLightingRequirement(lightingRequirement!)
          : null,
      co2Requirement: _mapDbCO2Requirement(co2Requirement),
      growthRate: growthRate != null ? _mapDbGrowthRate(growthRate!) : null,
      difficultyLevel: difficultyLevel != null
          ? _mapDbDifficultyLevel(difficultyLevel!)
          : null,
      maxHeightCm: maxHeightCm,
      currentHeightCm: currentHeightCm,
      minTempCelsius: minTempCelsius,
      maxTempCelsius: maxTempCelsius,
      minPh: minPh,
      maxPh: maxPh,
      dateAdded: dateAdded,
      dateRemoved: dateRemoved,
      isPropagated: isPropagated,
      parentPlantId: parentPlantId,
      purchasePrice: purchasePrice,
      source: source,
      notes: notes,
      photoUrl: photoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static PlantType _mapDbPlantType(db_types.PlantTypeDb dbType) {
    switch (dbType) {
      case db_types.PlantTypeDb.stem:
        return PlantType.stem;
      case db_types.PlantTypeDb.rosette:
        return PlantType.rosette;
      case db_types.PlantTypeDb.carpet:
        return PlantType.carpet;
      case db_types.PlantTypeDb.floating:
        return PlantType.floating;
      case db_types.PlantTypeDb.moss:
        return PlantType.moss;
      case db_types.PlantTypeDb.fern:
        return PlantType.fern;
      case db_types.PlantTypeDb.rhizome:
        return PlantType.rhizome;
      case db_types.PlantTypeDb.bulb:
        return PlantType.bulb;
      case db_types.PlantTypeDb.other:
        return PlantType.other;
    }
  }

  static PlacementZone _mapDbPlacementZone(db_types.PlacementZoneDb dbType) {
    switch (dbType) {
      case db_types.PlacementZoneDb.foreground:
        return PlacementZone.foreground;
      case db_types.PlacementZoneDb.midground:
        return PlacementZone.midground;
      case db_types.PlacementZoneDb.background:
        return PlacementZone.background;
      case db_types.PlacementZoneDb.floating:
        return PlacementZone.floating;
    }
  }

  static LightingRequirement _mapDbLightingRequirement(
    db_types.LightingRequirementDb dbType,
  ) {
    switch (dbType) {
      case db_types.LightingRequirementDb.low:
        return LightingRequirement.low;
      case db_types.LightingRequirementDb.medium:
        return LightingRequirement.medium;
      case db_types.LightingRequirementDb.high:
        return LightingRequirement.high;
      case db_types.LightingRequirementDb.veryHigh:
        return LightingRequirement.veryHigh;
    }
  }

  static CO2Requirement _mapDbCO2Requirement(db_types.CO2RequirementDb dbType) {
    switch (dbType) {
      case db_types.CO2RequirementDb.none:
        return CO2Requirement.none;
      case db_types.CO2RequirementDb.low:
        return CO2Requirement.low;
      case db_types.CO2RequirementDb.medium:
        return CO2Requirement.medium;
      case db_types.CO2RequirementDb.high:
        return CO2Requirement.high;
    }
  }

  static GrowthRate _mapDbGrowthRate(db_types.GrowthRateDb dbType) {
    switch (dbType) {
      case db_types.GrowthRateDb.slow:
        return GrowthRate.slow;
      case db_types.GrowthRateDb.medium:
        return GrowthRate.medium;
      case db_types.GrowthRateDb.fast:
        return GrowthRate.fast;
    }
  }

  static PlantDifficultyLevel _mapDbDifficultyLevel(
    db_types.PlantDifficultyLevelDb dbType,
  ) {
    switch (dbType) {
      case db_types.PlantDifficultyLevelDb.easy:
        return PlantDifficultyLevel.easy;
      case db_types.PlantDifficultyLevelDb.moderate:
        return PlantDifficultyLevel.moderate;
      case db_types.PlantDifficultyLevelDb.difficult:
        return PlantDifficultyLevel.difficult;
      case db_types.PlantDifficultyLevelDb.expert:
        return PlantDifficultyLevel.expert;
    }
  }
}

/// Extension to map PlantEntity to Drift models
extension PlantEntityMapper on PlantEntity {
  /// Convert PlantEntity to PlantsCompanion for insert operations
  PlantsCompanion toCompanion() {
    return PlantsCompanion(
      tankId: Value(tankId),
      species: Value(species),
      commonName: Value(commonName),
      plantType: Value(_mapToDbPlantType(plantType)),
      quantity: Value(quantity),
      placementZone: Value(
        placementZone != null ? _mapToDbPlacementZone(placementZone!) : null,
      ),
      lightingRequirement: Value(
        lightingRequirement != null
            ? _mapToDbLightingRequirement(lightingRequirement!)
            : null,
      ),
      co2Requirement: Value(_mapToDbCO2Requirement(co2Requirement)),
      growthRate: Value(
        growthRate != null ? _mapToDbGrowthRate(growthRate!) : null,
      ),
      difficultyLevel: Value(
        difficultyLevel != null
            ? _mapToDbDifficultyLevel(difficultyLevel!)
            : null,
      ),
      maxHeightCm: Value(maxHeightCm),
      currentHeightCm: Value(currentHeightCm),
      minTempCelsius: Value(minTempCelsius),
      maxTempCelsius: Value(maxTempCelsius),
      minPh: Value(minPh),
      maxPh: Value(maxPh),
      dateAdded: Value(dateAdded),
      dateRemoved: Value(dateRemoved),
      isPropagated: Value(isPropagated),
      parentPlantId: Value(parentPlantId),
      purchasePrice: Value(purchasePrice),
      source: Value(source),
      notes: Value(notes),
      photoUrl: Value(photoUrl),
      createdAt: Value(createdAt ?? DateTime.now()),
      updatedAt: Value(updatedAt ?? DateTime.now()),
    );
  }

  /// Convert PlantEntity to Drift Plant for update operations
  Plant toDriftPlant() {
    return Plant(
      id: id!,
      tankId: tankId,
      species: species,
      commonName: commonName,
      plantType: _mapToDbPlantType(plantType),
      quantity: quantity,
      placementZone: placementZone != null
          ? _mapToDbPlacementZone(placementZone!)
          : null,
      lightingRequirement: lightingRequirement != null
          ? _mapToDbLightingRequirement(lightingRequirement!)
          : null,
      co2Requirement: _mapToDbCO2Requirement(co2Requirement),
      growthRate: growthRate != null ? _mapToDbGrowthRate(growthRate!) : null,
      difficultyLevel: difficultyLevel != null
          ? _mapToDbDifficultyLevel(difficultyLevel!)
          : null,
      maxHeightCm: maxHeightCm,
      currentHeightCm: currentHeightCm,
      minTempCelsius: minTempCelsius,
      maxTempCelsius: maxTempCelsius,
      minPh: minPh,
      maxPh: maxPh,
      dateAdded: dateAdded,
      dateRemoved: dateRemoved,
      isPropagated: isPropagated,
      parentPlantId: parentPlantId,
      purchasePrice: purchasePrice,
      source: source,
      notes: notes,
      photoUrl: photoUrl,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  static db_types.PlantTypeDb _mapToDbPlantType(PlantType type) {
    switch (type) {
      case PlantType.stem:
        return db_types.PlantTypeDb.stem;
      case PlantType.rosette:
        return db_types.PlantTypeDb.rosette;
      case PlantType.carpet:
        return db_types.PlantTypeDb.carpet;
      case PlantType.floating:
        return db_types.PlantTypeDb.floating;
      case PlantType.moss:
        return db_types.PlantTypeDb.moss;
      case PlantType.fern:
        return db_types.PlantTypeDb.fern;
      case PlantType.rhizome:
        return db_types.PlantTypeDb.rhizome;
      case PlantType.bulb:
        return db_types.PlantTypeDb.bulb;
      case PlantType.other:
        return db_types.PlantTypeDb.other;
    }
  }

  static db_types.PlacementZoneDb _mapToDbPlacementZone(PlacementZone type) {
    switch (type) {
      case PlacementZone.foreground:
        return db_types.PlacementZoneDb.foreground;
      case PlacementZone.midground:
        return db_types.PlacementZoneDb.midground;
      case PlacementZone.background:
        return db_types.PlacementZoneDb.background;
      case PlacementZone.floating:
        return db_types.PlacementZoneDb.floating;
    }
  }

  static db_types.LightingRequirementDb _mapToDbLightingRequirement(
    LightingRequirement type,
  ) {
    switch (type) {
      case LightingRequirement.low:
        return db_types.LightingRequirementDb.low;
      case LightingRequirement.medium:
        return db_types.LightingRequirementDb.medium;
      case LightingRequirement.high:
        return db_types.LightingRequirementDb.high;
      case LightingRequirement.veryHigh:
        return db_types.LightingRequirementDb.veryHigh;
    }
  }

  static db_types.CO2RequirementDb _mapToDbCO2Requirement(CO2Requirement type) {
    switch (type) {
      case CO2Requirement.none:
        return db_types.CO2RequirementDb.none;
      case CO2Requirement.low:
        return db_types.CO2RequirementDb.low;
      case CO2Requirement.medium:
        return db_types.CO2RequirementDb.medium;
      case CO2Requirement.high:
        return db_types.CO2RequirementDb.high;
    }
  }

  static db_types.GrowthRateDb _mapToDbGrowthRate(GrowthRate type) {
    switch (type) {
      case GrowthRate.slow:
        return db_types.GrowthRateDb.slow;
      case GrowthRate.medium:
        return db_types.GrowthRateDb.medium;
      case GrowthRate.fast:
        return db_types.GrowthRateDb.fast;
    }
  }

  static db_types.PlantDifficultyLevelDb _mapToDbDifficultyLevel(
    PlantDifficultyLevel type,
  ) {
    switch (type) {
      case PlantDifficultyLevel.easy:
        return db_types.PlantDifficultyLevelDb.easy;
      case PlantDifficultyLevel.moderate:
        return db_types.PlantDifficultyLevelDb.moderate;
      case PlantDifficultyLevel.difficult:
        return db_types.PlantDifficultyLevelDb.difficult;
      case PlantDifficultyLevel.expert:
        return db_types.PlantDifficultyLevelDb.expert;
    }
  }
}
