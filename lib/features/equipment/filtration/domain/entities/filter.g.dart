// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FilterEntity _$FilterEntityFromJson(Map<String, dynamic> json) =>
    _FilterEntity(
      id: (json['id'] as num?)?.toInt(),
      tankId: (json['tankId'] as num).toInt(),
      name: json['name'] as String,
      filterType: $enumDecode(_$FilterTypeEnumMap, json['filterType']),
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      flowRateLph: (json['flowRateLph'] as num?)?.toDouble(),
      mediaVolumeLiters: (json['mediaVolumeLiters'] as num?)?.toDouble(),
      lastCleanedAt: json['lastCleanedAt'] == null
          ? null
          : DateTime.parse(json['lastCleanedAt'] as String),
      mediaReplacedAt: json['mediaReplacedAt'] == null
          ? null
          : DateTime.parse(json['mediaReplacedAt'] as String),
      cleaningIntervalDays:
          (json['cleaningIntervalDays'] as num?)?.toInt() ?? 14,
      mediaReplacementIntervalDays:
          (json['mediaReplacementIntervalDays'] as num?)?.toInt() ?? 90,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FilterEntityToJson(_FilterEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'name': instance.name,
      'filterType': _$FilterTypeEnumMap[instance.filterType]!,
      'brand': instance.brand,
      'model': instance.model,
      'flowRateLph': instance.flowRateLph,
      'mediaVolumeLiters': instance.mediaVolumeLiters,
      'lastCleanedAt': instance.lastCleanedAt?.toIso8601String(),
      'mediaReplacedAt': instance.mediaReplacedAt?.toIso8601String(),
      'cleaningIntervalDays': instance.cleaningIntervalDays,
      'mediaReplacementIntervalDays': instance.mediaReplacementIntervalDays,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$FilterTypeEnumMap = {
  FilterType.hob: 'hob',
  FilterType.canister: 'canister',
  FilterType.sponge: 'sponge',
  FilterType.internal: 'internal',
  FilterType.sump: 'sump',
  FilterType.undergravel: 'undergravel',
  FilterType.fluidizedBed: 'fluidized_bed',
  FilterType.wetDry: 'wet_dry',
  FilterType.other: 'other',
};
