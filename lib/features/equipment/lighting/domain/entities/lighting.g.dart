// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lighting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LightingEntity _$LightingEntityFromJson(Map<String, dynamic> json) =>
    _LightingEntity(
      id: (json['id'] as num?)?.toInt(),
      tankId: (json['tankId'] as num).toInt(),
      name: json['name'] as String,
      lightingType: $enumDecode(_$LightingTypeEnumMap, json['lightingType']),
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      wattage: (json['wattage'] as num?)?.toDouble(),
      kelvinRating: (json['kelvinRating'] as num?)?.toInt(),
      spectrum: $enumDecodeNullable(_$LightSpectrumEnumMap, json['spectrum']),
      parValue: (json['parValue'] as num?)?.toInt(),
      lumens: (json['lumens'] as num?)?.toInt(),
      isDimmable: json['isDimmable'] as bool? ?? false,
      hasTimer: json['hasTimer'] as bool? ?? false,
      hasColorControl: json['hasColorControl'] as bool? ?? false,
      onTime: json['onTime'] as String?,
      offTime: json['offTime'] as String?,
      intensityPercent: (json['intensityPercent'] as num?)?.toInt() ?? 100,
      lastReplacedAt: json['lastReplacedAt'] == null
          ? null
          : DateTime.parse(json['lastReplacedAt'] as String),
      replacementIntervalDays:
          (json['replacementIntervalDays'] as num?)?.toInt() ?? 365,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LightingEntityToJson(_LightingEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'name': instance.name,
      'lightingType': _$LightingTypeEnumMap[instance.lightingType]!,
      'brand': instance.brand,
      'model': instance.model,
      'wattage': instance.wattage,
      'kelvinRating': instance.kelvinRating,
      'spectrum': _$LightSpectrumEnumMap[instance.spectrum],
      'parValue': instance.parValue,
      'lumens': instance.lumens,
      'isDimmable': instance.isDimmable,
      'hasTimer': instance.hasTimer,
      'hasColorControl': instance.hasColorControl,
      'onTime': instance.onTime,
      'offTime': instance.offTime,
      'intensityPercent': instance.intensityPercent,
      'lastReplacedAt': instance.lastReplacedAt?.toIso8601String(),
      'replacementIntervalDays': instance.replacementIntervalDays,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$LightingTypeEnumMap = {
  LightingType.led: 'led',
  LightingType.fluorescent: 'fluorescent',
  LightingType.t5: 't5',
  LightingType.t8: 't8',
  LightingType.metalHalide: 'metal_halide',
  LightingType.incandescent: 'incandescent',
  LightingType.compactFluorescent: 'compact_fluorescent',
  LightingType.other: 'other',
};

const _$LightSpectrumEnumMap = {
  LightSpectrum.daylight: 'daylight',
  LightSpectrum.warmWhite: 'warm_white',
  LightSpectrum.coolWhite: 'cool_white',
  LightSpectrum.fullSpectrum: 'full_spectrum',
  LightSpectrum.plantGrowth: 'plant_growth',
  LightSpectrum.actinicBlue: 'actinic_blue',
  LightSpectrum.rgb: 'rgb',
  LightSpectrum.custom: 'custom',
};
