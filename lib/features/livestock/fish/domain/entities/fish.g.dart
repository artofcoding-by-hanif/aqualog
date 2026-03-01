// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FishEntity _$FishEntityFromJson(Map<String, dynamic> json) => _FishEntity(
  id: (json['id'] as num?)?.toInt(),
  tankId: (json['tankId'] as num).toInt(),
  species: json['species'] as String,
  commonName: json['commonName'] as String?,
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  waterType:
      $enumDecodeNullable(_$WaterTypeEnumMap, json['waterType']) ??
      WaterType.freshwater,
  temperament: $enumDecodeNullable(
    _$FishTemperamentEnumMap,
    json['temperament'],
  ),
  diet: $enumDecodeNullable(_$FishDietEnumMap, json['diet']),
  careLevel: $enumDecodeNullable(_$CareLevelEnumMap, json['careLevel']),
  swimmingLevel: $enumDecodeNullable(
    _$SwimmingLevelEnumMap,
    json['swimmingLevel'],
  ),
  maxSizeCm: (json['maxSizeCm'] as num?)?.toDouble(),
  currentSizeCm: (json['currentSizeCm'] as num?)?.toDouble(),
  minTankSizeLiters: (json['minTankSizeLiters'] as num?)?.toDouble(),
  minTempCelsius: (json['minTempCelsius'] as num?)?.toDouble(),
  maxTempCelsius: (json['maxTempCelsius'] as num?)?.toDouble(),
  minPh: (json['minPh'] as num?)?.toDouble(),
  maxPh: (json['maxPh'] as num?)?.toDouble(),
  lifespanYears: (json['lifespanYears'] as num?)?.toInt(),
  dateAdded: json['dateAdded'] == null
      ? null
      : DateTime.parse(json['dateAdded'] as String),
  dateDeceased: json['dateDeceased'] == null
      ? null
      : DateTime.parse(json['dateDeceased'] as String),
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
  source: json['source'] as String?,
  isQuarantined: json['isQuarantined'] as bool? ?? false,
  quarantineEndDate: json['quarantineEndDate'] == null
      ? null
      : DateTime.parse(json['quarantineEndDate'] as String),
  notes: json['notes'] as String?,
  photoUrl: json['photoUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FishEntityToJson(_FishEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'species': instance.species,
      'commonName': instance.commonName,
      'quantity': instance.quantity,
      'waterType': _$WaterTypeEnumMap[instance.waterType]!,
      'temperament': _$FishTemperamentEnumMap[instance.temperament],
      'diet': _$FishDietEnumMap[instance.diet],
      'careLevel': _$CareLevelEnumMap[instance.careLevel],
      'swimmingLevel': _$SwimmingLevelEnumMap[instance.swimmingLevel],
      'maxSizeCm': instance.maxSizeCm,
      'currentSizeCm': instance.currentSizeCm,
      'minTankSizeLiters': instance.minTankSizeLiters,
      'minTempCelsius': instance.minTempCelsius,
      'maxTempCelsius': instance.maxTempCelsius,
      'minPh': instance.minPh,
      'maxPh': instance.maxPh,
      'lifespanYears': instance.lifespanYears,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'dateDeceased': instance.dateDeceased?.toIso8601String(),
      'purchasePrice': instance.purchasePrice,
      'source': instance.source,
      'isQuarantined': instance.isQuarantined,
      'quarantineEndDate': instance.quarantineEndDate?.toIso8601String(),
      'notes': instance.notes,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$WaterTypeEnumMap = {
  WaterType.freshwater: 'freshwater',
  WaterType.saltwater: 'saltwater',
  WaterType.brackish: 'brackish',
};

const _$FishTemperamentEnumMap = {
  FishTemperament.peaceful: 'peaceful',
  FishTemperament.semiAggressive: 'semi_aggressive',
  FishTemperament.aggressive: 'aggressive',
  FishTemperament.territorial: 'territorial',
  FishTemperament.schooling: 'schooling',
  FishTemperament.shy: 'shy',
};

const _$FishDietEnumMap = {
  FishDiet.carnivore: 'carnivore',
  FishDiet.herbivore: 'herbivore',
  FishDiet.omnivore: 'omnivore',
  FishDiet.insectivore: 'insectivore',
  FishDiet.piscivore: 'piscivore',
  FishDiet.detritivore: 'detritivore',
};

const _$CareLevelEnumMap = {
  CareLevel.beginner: 'beginner',
  CareLevel.intermediate: 'intermediate',
  CareLevel.advanced: 'advanced',
  CareLevel.expert: 'expert',
};

const _$SwimmingLevelEnumMap = {
  SwimmingLevel.top: 'top',
  SwimmingLevel.middle: 'middle',
  SwimmingLevel.bottom: 'bottom',
  SwimmingLevel.all: 'all',
};
