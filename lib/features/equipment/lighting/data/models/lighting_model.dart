import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/tables/lighting_table.dart' as db_types;
import '../../domain/entities/lighting.dart';

/// Extension to map between Drift Lighting and LightingEntity
extension LightingMapper on Lighting {
  /// Convert Drift Lighting to domain LightingEntity
  LightingEntity toEntity() {
    return LightingEntity(
      id: id,
      tankId: tankId,
      name: name,
      lightingType: _mapDbLightingType(lightingType),
      brand: brand,
      model: model,
      wattage: wattage,
      kelvinRating: kelvinRating,
      spectrum: spectrum != null ? _mapDbSpectrum(spectrum!) : null,
      parValue: parValue,
      lumens: lumens,
      isDimmable: isDimmable,
      hasTimer: hasTimer,
      hasColorControl: hasColorControl,
      onTime: onTime,
      offTime: offTime,
      intensityPercent: intensityPercent,
      lastReplacedAt: lastReplacedAt,
      replacementIntervalDays: replacementIntervalDays,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static LightingType _mapDbLightingType(db_types.LightingTypeDb dbType) {
    switch (dbType) {
      case db_types.LightingTypeDb.led:
        return LightingType.led;
      case db_types.LightingTypeDb.fluorescent:
        return LightingType.fluorescent;
      case db_types.LightingTypeDb.t5:
        return LightingType.t5;
      case db_types.LightingTypeDb.t8:
        return LightingType.t8;
      case db_types.LightingTypeDb.metalHalide:
        return LightingType.metalHalide;
      case db_types.LightingTypeDb.incandescent:
        return LightingType.incandescent;
      case db_types.LightingTypeDb.compactFluorescent:
        return LightingType.compactFluorescent;
      case db_types.LightingTypeDb.other:
        return LightingType.other;
    }
  }

  static LightSpectrum _mapDbSpectrum(db_types.LightSpectrumDb dbSpectrum) {
    switch (dbSpectrum) {
      case db_types.LightSpectrumDb.daylight:
        return LightSpectrum.daylight;
      case db_types.LightSpectrumDb.warmWhite:
        return LightSpectrum.warmWhite;
      case db_types.LightSpectrumDb.coolWhite:
        return LightSpectrum.coolWhite;
      case db_types.LightSpectrumDb.fullSpectrum:
        return LightSpectrum.fullSpectrum;
      case db_types.LightSpectrumDb.plantGrowth:
        return LightSpectrum.plantGrowth;
      case db_types.LightSpectrumDb.actinicBlue:
        return LightSpectrum.actinicBlue;
      case db_types.LightSpectrumDb.rgb:
        return LightSpectrum.rgb;
      case db_types.LightSpectrumDb.custom:
        return LightSpectrum.custom;
    }
  }
}

/// Extension to convert LightingEntity to Drift companion for insert/update
extension LightingEntityMapper on LightingEntity {
  /// Convert domain LightingEntity to Drift LightingsCompanion for insert
  LightingsCompanion toCompanion() {
    return LightingsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      name: Value(name),
      lightingType: Value(_mapToDbLightingType(lightingType)),
      brand: Value(brand),
      model: Value(model),
      wattage: Value(wattage),
      kelvinRating: Value(kelvinRating),
      spectrum: Value(spectrum != null ? _mapToDbSpectrum(spectrum!) : null),
      parValue: Value(parValue),
      lumens: Value(lumens),
      isDimmable: Value(isDimmable),
      hasTimer: Value(hasTimer),
      hasColorControl: Value(hasColorControl),
      onTime: Value(onTime),
      offTime: Value(offTime),
      intensityPercent: Value(intensityPercent),
      lastReplacedAt: Value(lastReplacedAt),
      replacementIntervalDays: Value(replacementIntervalDays),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Lighting for update
  Lighting toDriftLighting() {
    return Lighting(
      id: id!,
      tankId: tankId,
      name: name,
      lightingType: _mapToDbLightingType(lightingType),
      brand: brand,
      model: model,
      wattage: wattage,
      kelvinRating: kelvinRating,
      spectrum: spectrum != null ? _mapToDbSpectrum(spectrum!) : null,
      parValue: parValue,
      lumens: lumens,
      isDimmable: isDimmable,
      hasTimer: hasTimer,
      hasColorControl: hasColorControl,
      onTime: onTime,
      offTime: offTime,
      intensityPercent: intensityPercent,
      lastReplacedAt: lastReplacedAt,
      replacementIntervalDays: replacementIntervalDays,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.LightingTypeDb _mapToDbLightingType(LightingType type) {
    switch (type) {
      case LightingType.led:
        return db_types.LightingTypeDb.led;
      case LightingType.fluorescent:
        return db_types.LightingTypeDb.fluorescent;
      case LightingType.t5:
        return db_types.LightingTypeDb.t5;
      case LightingType.t8:
        return db_types.LightingTypeDb.t8;
      case LightingType.metalHalide:
        return db_types.LightingTypeDb.metalHalide;
      case LightingType.incandescent:
        return db_types.LightingTypeDb.incandescent;
      case LightingType.compactFluorescent:
        return db_types.LightingTypeDb.compactFluorescent;
      case LightingType.other:
        return db_types.LightingTypeDb.other;
    }
  }

  static db_types.LightSpectrumDb _mapToDbSpectrum(LightSpectrum spectrum) {
    switch (spectrum) {
      case LightSpectrum.daylight:
        return db_types.LightSpectrumDb.daylight;
      case LightSpectrum.warmWhite:
        return db_types.LightSpectrumDb.warmWhite;
      case LightSpectrum.coolWhite:
        return db_types.LightSpectrumDb.coolWhite;
      case LightSpectrum.fullSpectrum:
        return db_types.LightSpectrumDb.fullSpectrum;
      case LightSpectrum.plantGrowth:
        return db_types.LightSpectrumDb.plantGrowth;
      case LightSpectrum.actinicBlue:
        return db_types.LightSpectrumDb.actinicBlue;
      case LightSpectrum.rgb:
        return db_types.LightSpectrumDb.rgb;
      case LightSpectrum.custom:
        return db_types.LightSpectrumDb.custom;
    }
  }
}
