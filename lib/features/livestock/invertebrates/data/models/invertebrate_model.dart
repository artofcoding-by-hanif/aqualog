import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/tables/invertebrates_table.dart'
    as db_types;
import '../../domain/entities/invertebrate.dart';

/// Extension to map between Drift Invertebrate and InvertebrateEntity
extension InvertebrateMapper on Invertebrate {
  /// Convert Drift Invertebrate to domain InvertebrateEntity
  InvertebrateEntity toEntity() {
    return InvertebrateEntity(
      id: id,
      tankId: tankId,
      species: species,
      commonName: commonName,
      invertebrateType: _mapDbInvertebrateType(invertebrateType),
      quantity: quantity,
      waterType: _mapDbWaterType(waterType),
      careLevel: careLevel != null ? _mapDbCareLevel(careLevel!) : null,
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
      isBreedingColony: isBreedingColony,
      notes: notes,
      photoUrl: photoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static InvertebrateType _mapDbInvertebrateType(
    db_types.InvertebrateTypeDb dbType,
  ) {
    switch (dbType) {
      case db_types.InvertebrateTypeDb.shrimp:
        return InvertebrateType.shrimp;
      case db_types.InvertebrateTypeDb.snail:
        return InvertebrateType.snail;
      case db_types.InvertebrateTypeDb.crab:
        return InvertebrateType.crab;
      case db_types.InvertebrateTypeDb.crayfish:
        return InvertebrateType.crayfish;
      case db_types.InvertebrateTypeDb.clam:
        return InvertebrateType.clam;
      case db_types.InvertebrateTypeDb.starfish:
        return InvertebrateType.starfish;
      case db_types.InvertebrateTypeDb.urchin:
        return InvertebrateType.urchin;
      case db_types.InvertebrateTypeDb.coral:
        return InvertebrateType.coral;
      case db_types.InvertebrateTypeDb.anemone:
        return InvertebrateType.anemone;
      case db_types.InvertebrateTypeDb.other:
        return InvertebrateType.other;
    }
  }

  static InvertWaterType _mapDbWaterType(db_types.InvertWaterTypeDb dbType) {
    switch (dbType) {
      case db_types.InvertWaterTypeDb.freshwater:
        return InvertWaterType.freshwater;
      case db_types.InvertWaterTypeDb.saltwater:
        return InvertWaterType.saltwater;
      case db_types.InvertWaterTypeDb.brackish:
        return InvertWaterType.brackish;
    }
  }

  static InvertCareLevel _mapDbCareLevel(db_types.InvertCareLevelDb dbType) {
    switch (dbType) {
      case db_types.InvertCareLevelDb.beginner:
        return InvertCareLevel.beginner;
      case db_types.InvertCareLevelDb.intermediate:
        return InvertCareLevel.intermediate;
      case db_types.InvertCareLevelDb.advanced:
        return InvertCareLevel.advanced;
      case db_types.InvertCareLevelDb.expert:
        return InvertCareLevel.expert;
    }
  }
}

/// Extension to convert InvertebrateEntity to Drift companion for insert/update
extension InvertebrateEntityMapper on InvertebrateEntity {
  /// Convert domain InvertebrateEntity to Drift InvertebratesCompanion for insert
  InvertebratesCompanion toCompanion() {
    return InvertebratesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      species: Value(species),
      commonName: Value(commonName),
      invertebrateType: Value(_mapToDbInvertebrateType(invertebrateType)),
      quantity: Value(quantity),
      waterType: Value(_mapToDbWaterType(waterType)),
      careLevel: Value(
        careLevel != null ? _mapToDbCareLevel(careLevel!) : null,
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
      isBreedingColony: Value(isBreedingColony),
      notes: Value(notes),
      photoUrl: Value(photoUrl),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Invertebrate for update
  Invertebrate toDriftInvertebrate() {
    return Invertebrate(
      id: id!,
      tankId: tankId,
      species: species,
      commonName: commonName,
      invertebrateType: _mapToDbInvertebrateType(invertebrateType),
      quantity: quantity,
      waterType: _mapToDbWaterType(waterType),
      careLevel: careLevel != null ? _mapToDbCareLevel(careLevel!) : null,
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
      isBreedingColony: isBreedingColony,
      notes: notes,
      photoUrl: photoUrl,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.InvertebrateTypeDb _mapToDbInvertebrateType(
    InvertebrateType type,
  ) {
    switch (type) {
      case InvertebrateType.shrimp:
        return db_types.InvertebrateTypeDb.shrimp;
      case InvertebrateType.snail:
        return db_types.InvertebrateTypeDb.snail;
      case InvertebrateType.crab:
        return db_types.InvertebrateTypeDb.crab;
      case InvertebrateType.crayfish:
        return db_types.InvertebrateTypeDb.crayfish;
      case InvertebrateType.clam:
        return db_types.InvertebrateTypeDb.clam;
      case InvertebrateType.starfish:
        return db_types.InvertebrateTypeDb.starfish;
      case InvertebrateType.urchin:
        return db_types.InvertebrateTypeDb.urchin;
      case InvertebrateType.coral:
        return db_types.InvertebrateTypeDb.coral;
      case InvertebrateType.anemone:
        return db_types.InvertebrateTypeDb.anemone;
      case InvertebrateType.other:
        return db_types.InvertebrateTypeDb.other;
    }
  }

  static db_types.InvertWaterTypeDb _mapToDbWaterType(InvertWaterType type) {
    switch (type) {
      case InvertWaterType.freshwater:
        return db_types.InvertWaterTypeDb.freshwater;
      case InvertWaterType.saltwater:
        return db_types.InvertWaterTypeDb.saltwater;
      case InvertWaterType.brackish:
        return db_types.InvertWaterTypeDb.brackish;
    }
  }

  static db_types.InvertCareLevelDb _mapToDbCareLevel(InvertCareLevel type) {
    switch (type) {
      case InvertCareLevel.beginner:
        return db_types.InvertCareLevelDb.beginner;
      case InvertCareLevel.intermediate:
        return db_types.InvertCareLevelDb.intermediate;
      case InvertCareLevel.advanced:
        return db_types.InvertCareLevelDb.advanced;
      case InvertCareLevel.expert:
        return db_types.InvertCareLevelDb.expert;
    }
  }
}
