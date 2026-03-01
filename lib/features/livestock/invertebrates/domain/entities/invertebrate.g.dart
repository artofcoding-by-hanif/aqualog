// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invertebrate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvertebrateEntity _$InvertebrateEntityFromJson(Map<String, dynamic> json) =>
    _InvertebrateEntity(
      id: (json['id'] as num?)?.toInt(),
      tankId: (json['tankId'] as num).toInt(),
      species: json['species'] as String,
      commonName: json['commonName'] as String?,
      invertebrateType:
          $enumDecodeNullable(
            _$InvertebrateTypeEnumMap,
            json['invertebrateType'],
          ) ??
          InvertebrateType.shrimp,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      waterType:
          $enumDecodeNullable(_$InvertWaterTypeEnumMap, json['waterType']) ??
          InvertWaterType.freshwater,
      careLevel: $enumDecodeNullable(
        _$InvertCareLevelEnumMap,
        json['careLevel'],
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
      isBreedingColony: json['isBreedingColony'] as bool? ?? false,
      notes: json['notes'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$InvertebrateEntityToJson(_InvertebrateEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'species': instance.species,
      'commonName': instance.commonName,
      'invertebrateType': _$InvertebrateTypeEnumMap[instance.invertebrateType]!,
      'quantity': instance.quantity,
      'waterType': _$InvertWaterTypeEnumMap[instance.waterType]!,
      'careLevel': _$InvertCareLevelEnumMap[instance.careLevel],
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
      'isBreedingColony': instance.isBreedingColony,
      'notes': instance.notes,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$InvertebrateTypeEnumMap = {
  InvertebrateType.shrimp: 'shrimp',
  InvertebrateType.snail: 'snail',
  InvertebrateType.crab: 'crab',
  InvertebrateType.crayfish: 'crayfish',
  InvertebrateType.clam: 'clam',
  InvertebrateType.starfish: 'starfish',
  InvertebrateType.urchin: 'urchin',
  InvertebrateType.coral: 'coral',
  InvertebrateType.anemone: 'anemone',
  InvertebrateType.other: 'other',
};

const _$InvertWaterTypeEnumMap = {
  InvertWaterType.freshwater: 'freshwater',
  InvertWaterType.saltwater: 'saltwater',
  InvertWaterType.brackish: 'brackish',
};

const _$InvertCareLevelEnumMap = {
  InvertCareLevel.beginner: 'beginner',
  InvertCareLevel.intermediate: 'intermediate',
  InvertCareLevel.advanced: 'advanced',
  InvertCareLevel.expert: 'expert',
};
