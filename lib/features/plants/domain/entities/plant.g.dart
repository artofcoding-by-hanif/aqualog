// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantEntity _$PlantEntityFromJson(Map<String, dynamic> json) => _PlantEntity(
  id: (json['id'] as num?)?.toInt(),
  tankId: (json['tankId'] as num).toInt(),
  species: json['species'] as String,
  commonName: json['commonName'] as String?,
  plantType:
      $enumDecodeNullable(_$PlantTypeEnumMap, json['plantType']) ??
      PlantType.stem,
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  placementZone: $enumDecodeNullable(
    _$PlacementZoneEnumMap,
    json['placementZone'],
  ),
  lightingRequirement: $enumDecodeNullable(
    _$LightingRequirementEnumMap,
    json['lightingRequirement'],
  ),
  co2Requirement:
      $enumDecodeNullable(_$CO2RequirementEnumMap, json['co2Requirement']) ??
      CO2Requirement.none,
  growthRate: $enumDecodeNullable(_$GrowthRateEnumMap, json['growthRate']),
  difficultyLevel: $enumDecodeNullable(
    _$PlantDifficultyLevelEnumMap,
    json['difficultyLevel'],
  ),
  maxHeightCm: (json['maxHeightCm'] as num?)?.toDouble(),
  currentHeightCm: (json['currentHeightCm'] as num?)?.toDouble(),
  minTempCelsius: (json['minTempCelsius'] as num?)?.toDouble(),
  maxTempCelsius: (json['maxTempCelsius'] as num?)?.toDouble(),
  minPh: (json['minPh'] as num?)?.toDouble(),
  maxPh: (json['maxPh'] as num?)?.toDouble(),
  dateAdded: json['dateAdded'] == null
      ? null
      : DateTime.parse(json['dateAdded'] as String),
  dateRemoved: json['dateRemoved'] == null
      ? null
      : DateTime.parse(json['dateRemoved'] as String),
  isPropagated: json['isPropagated'] as bool? ?? false,
  parentPlantId: (json['parentPlantId'] as num?)?.toInt(),
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
  source: json['source'] as String?,
  notes: json['notes'] as String?,
  photoUrl: json['photoUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PlantEntityToJson(
  _PlantEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'tankId': instance.tankId,
  'species': instance.species,
  'commonName': instance.commonName,
  'plantType': _$PlantTypeEnumMap[instance.plantType]!,
  'quantity': instance.quantity,
  'placementZone': _$PlacementZoneEnumMap[instance.placementZone],
  'lightingRequirement':
      _$LightingRequirementEnumMap[instance.lightingRequirement],
  'co2Requirement': _$CO2RequirementEnumMap[instance.co2Requirement]!,
  'growthRate': _$GrowthRateEnumMap[instance.growthRate],
  'difficultyLevel': _$PlantDifficultyLevelEnumMap[instance.difficultyLevel],
  'maxHeightCm': instance.maxHeightCm,
  'currentHeightCm': instance.currentHeightCm,
  'minTempCelsius': instance.minTempCelsius,
  'maxTempCelsius': instance.maxTempCelsius,
  'minPh': instance.minPh,
  'maxPh': instance.maxPh,
  'dateAdded': instance.dateAdded?.toIso8601String(),
  'dateRemoved': instance.dateRemoved?.toIso8601String(),
  'isPropagated': instance.isPropagated,
  'parentPlantId': instance.parentPlantId,
  'purchasePrice': instance.purchasePrice,
  'source': instance.source,
  'notes': instance.notes,
  'photoUrl': instance.photoUrl,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$PlantTypeEnumMap = {
  PlantType.stem: 'stem',
  PlantType.rosette: 'rosette',
  PlantType.carpet: 'carpet',
  PlantType.floating: 'floating',
  PlantType.moss: 'moss',
  PlantType.fern: 'fern',
  PlantType.rhizome: 'rhizome',
  PlantType.bulb: 'bulb',
  PlantType.other: 'other',
};

const _$PlacementZoneEnumMap = {
  PlacementZone.foreground: 'foreground',
  PlacementZone.midground: 'midground',
  PlacementZone.background: 'background',
  PlacementZone.floating: 'floating',
};

const _$LightingRequirementEnumMap = {
  LightingRequirement.low: 'low',
  LightingRequirement.medium: 'medium',
  LightingRequirement.high: 'high',
  LightingRequirement.veryHigh: 'very_high',
};

const _$CO2RequirementEnumMap = {
  CO2Requirement.none: 'none',
  CO2Requirement.low: 'low',
  CO2Requirement.medium: 'medium',
  CO2Requirement.high: 'high',
};

const _$GrowthRateEnumMap = {
  GrowthRate.slow: 'slow',
  GrowthRate.medium: 'medium',
  GrowthRate.fast: 'fast',
};

const _$PlantDifficultyLevelEnumMap = {
  PlantDifficultyLevel.easy: 'easy',
  PlantDifficultyLevel.moderate: 'moderate',
  PlantDifficultyLevel.difficult: 'difficult',
  PlantDifficultyLevel.expert: 'expert',
};
