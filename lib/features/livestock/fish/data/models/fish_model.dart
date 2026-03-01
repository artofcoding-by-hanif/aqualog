import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/tables/fish_table.dart' as db_types;
import '../../domain/entities/fish.dart';

/// Extension to map between Drift FishData and FishEntity
extension FishMapper on FishData {
  /// Convert Drift FishData to domain FishEntity
  FishEntity toEntity() {
    return FishEntity(
      id: id,
      tankId: tankId,
      species: species,
      commonName: commonName,
      quantity: quantity,
      waterType: _mapDbWaterType(waterType),
      temperament: temperament != null ? _mapDbTemperament(temperament!) : null,
      diet: diet != null ? _mapDbDiet(diet!) : null,
      careLevel: careLevel != null ? _mapDbCareLevel(careLevel!) : null,
      swimmingLevel: swimmingLevel != null
          ? _mapDbSwimmingLevel(swimmingLevel!)
          : null,
      maxSizeCm: maxSizeCm,
      currentSizeCm: currentSizeCm,
      minTankSizeLiters: minTankSizeLiters,
      minTempCelsius: minTempCelsius,
      maxTempCelsius: maxTempCelsius,
      minPh: minPh,
      maxPh: maxPh,
      lifespanYears: lifespanYears,
      dateAdded: dateAdded,
      dateDeceased: dateDeceased,
      purchasePrice: purchasePrice,
      source: source,
      isQuarantined: isQuarantined,
      quarantineEndDate: quarantineEndDate,
      notes: notes,
      photoUrl: photoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static WaterType _mapDbWaterType(db_types.WaterTypeDb dbType) {
    switch (dbType) {
      case db_types.WaterTypeDb.freshwater:
        return WaterType.freshwater;
      case db_types.WaterTypeDb.saltwater:
        return WaterType.saltwater;
      case db_types.WaterTypeDb.brackish:
        return WaterType.brackish;
    }
  }

  static FishTemperament _mapDbTemperament(db_types.FishTemperamentDb dbType) {
    switch (dbType) {
      case db_types.FishTemperamentDb.peaceful:
        return FishTemperament.peaceful;
      case db_types.FishTemperamentDb.semiAggressive:
        return FishTemperament.semiAggressive;
      case db_types.FishTemperamentDb.aggressive:
        return FishTemperament.aggressive;
      case db_types.FishTemperamentDb.territorial:
        return FishTemperament.territorial;
      case db_types.FishTemperamentDb.schooling:
        return FishTemperament.schooling;
      case db_types.FishTemperamentDb.shy:
        return FishTemperament.shy;
    }
  }

  static FishDiet _mapDbDiet(db_types.FishDietDb dbType) {
    switch (dbType) {
      case db_types.FishDietDb.carnivore:
        return FishDiet.carnivore;
      case db_types.FishDietDb.herbivore:
        return FishDiet.herbivore;
      case db_types.FishDietDb.omnivore:
        return FishDiet.omnivore;
      case db_types.FishDietDb.insectivore:
        return FishDiet.insectivore;
      case db_types.FishDietDb.piscivore:
        return FishDiet.piscivore;
      case db_types.FishDietDb.detritivore:
        return FishDiet.detritivore;
    }
  }

  static CareLevel _mapDbCareLevel(db_types.CareLevelDb dbType) {
    switch (dbType) {
      case db_types.CareLevelDb.beginner:
        return CareLevel.beginner;
      case db_types.CareLevelDb.intermediate:
        return CareLevel.intermediate;
      case db_types.CareLevelDb.advanced:
        return CareLevel.advanced;
      case db_types.CareLevelDb.expert:
        return CareLevel.expert;
    }
  }

  static SwimmingLevel _mapDbSwimmingLevel(db_types.SwimmingLevelDb dbType) {
    switch (dbType) {
      case db_types.SwimmingLevelDb.top:
        return SwimmingLevel.top;
      case db_types.SwimmingLevelDb.middle:
        return SwimmingLevel.middle;
      case db_types.SwimmingLevelDb.bottom:
        return SwimmingLevel.bottom;
      case db_types.SwimmingLevelDb.all:
        return SwimmingLevel.all;
    }
  }
}

/// Extension to convert FishEntity to Drift companion for insert/update
extension FishEntityMapper on FishEntity {
  /// Convert domain FishEntity to Drift FishCompanion for insert
  FishCompanion toCompanion() {
    return FishCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      species: Value(species),
      commonName: Value(commonName),
      quantity: Value(quantity),
      waterType: Value(_mapToDbWaterType(waterType)),
      temperament: Value(
        temperament != null ? _mapToDbTemperament(temperament!) : null,
      ),
      diet: Value(diet != null ? _mapToDbDiet(diet!) : null),
      careLevel: Value(
        careLevel != null ? _mapToDbCareLevel(careLevel!) : null,
      ),
      swimmingLevel: Value(
        swimmingLevel != null ? _mapToDbSwimmingLevel(swimmingLevel!) : null,
      ),
      maxSizeCm: Value(maxSizeCm),
      currentSizeCm: Value(currentSizeCm),
      minTankSizeLiters: Value(minTankSizeLiters),
      minTempCelsius: Value(minTempCelsius),
      maxTempCelsius: Value(maxTempCelsius),
      minPh: Value(minPh),
      maxPh: Value(maxPh),
      lifespanYears: Value(lifespanYears),
      dateAdded: Value(dateAdded),
      dateDeceased: Value(dateDeceased),
      purchasePrice: Value(purchasePrice),
      source: Value(source),
      isQuarantined: Value(isQuarantined),
      quarantineEndDate: Value(quarantineEndDate),
      notes: Value(notes),
      photoUrl: Value(photoUrl),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift FishData for update
  FishData toDriftFish() {
    return FishData(
      id: id!,
      tankId: tankId,
      species: species,
      commonName: commonName,
      quantity: quantity,
      waterType: _mapToDbWaterType(waterType),
      temperament: temperament != null
          ? _mapToDbTemperament(temperament!)
          : null,
      diet: diet != null ? _mapToDbDiet(diet!) : null,
      careLevel: careLevel != null ? _mapToDbCareLevel(careLevel!) : null,
      swimmingLevel: swimmingLevel != null
          ? _mapToDbSwimmingLevel(swimmingLevel!)
          : null,
      maxSizeCm: maxSizeCm,
      currentSizeCm: currentSizeCm,
      minTankSizeLiters: minTankSizeLiters,
      minTempCelsius: minTempCelsius,
      maxTempCelsius: maxTempCelsius,
      minPh: minPh,
      maxPh: maxPh,
      lifespanYears: lifespanYears,
      dateAdded: dateAdded,
      dateDeceased: dateDeceased,
      purchasePrice: purchasePrice,
      source: source,
      isQuarantined: isQuarantined,
      quarantineEndDate: quarantineEndDate,
      notes: notes,
      photoUrl: photoUrl,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.WaterTypeDb _mapToDbWaterType(WaterType type) {
    switch (type) {
      case WaterType.freshwater:
        return db_types.WaterTypeDb.freshwater;
      case WaterType.saltwater:
        return db_types.WaterTypeDb.saltwater;
      case WaterType.brackish:
        return db_types.WaterTypeDb.brackish;
    }
  }

  static db_types.FishTemperamentDb _mapToDbTemperament(FishTemperament type) {
    switch (type) {
      case FishTemperament.peaceful:
        return db_types.FishTemperamentDb.peaceful;
      case FishTemperament.semiAggressive:
        return db_types.FishTemperamentDb.semiAggressive;
      case FishTemperament.aggressive:
        return db_types.FishTemperamentDb.aggressive;
      case FishTemperament.territorial:
        return db_types.FishTemperamentDb.territorial;
      case FishTemperament.schooling:
        return db_types.FishTemperamentDb.schooling;
      case FishTemperament.shy:
        return db_types.FishTemperamentDb.shy;
    }
  }

  static db_types.FishDietDb _mapToDbDiet(FishDiet type) {
    switch (type) {
      case FishDiet.carnivore:
        return db_types.FishDietDb.carnivore;
      case FishDiet.herbivore:
        return db_types.FishDietDb.herbivore;
      case FishDiet.omnivore:
        return db_types.FishDietDb.omnivore;
      case FishDiet.insectivore:
        return db_types.FishDietDb.insectivore;
      case FishDiet.piscivore:
        return db_types.FishDietDb.piscivore;
      case FishDiet.detritivore:
        return db_types.FishDietDb.detritivore;
    }
  }

  static db_types.CareLevelDb _mapToDbCareLevel(CareLevel type) {
    switch (type) {
      case CareLevel.beginner:
        return db_types.CareLevelDb.beginner;
      case CareLevel.intermediate:
        return db_types.CareLevelDb.intermediate;
      case CareLevel.advanced:
        return db_types.CareLevelDb.advanced;
      case CareLevel.expert:
        return db_types.CareLevelDb.expert;
    }
  }

  static db_types.SwimmingLevelDb _mapToDbSwimmingLevel(SwimmingLevel type) {
    switch (type) {
      case SwimmingLevel.top:
        return db_types.SwimmingLevelDb.top;
      case SwimmingLevel.middle:
        return db_types.SwimmingLevelDb.middle;
      case SwimmingLevel.bottom:
        return db_types.SwimmingLevelDb.bottom;
      case SwimmingLevel.all:
        return db_types.SwimmingLevelDb.all;
    }
  }
}
