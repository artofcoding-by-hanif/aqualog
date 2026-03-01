// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driftwood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriftwoodEntity _$DriftwoodEntityFromJson(Map<String, dynamic> json) =>
    _DriftwoodEntity(
      id: (json['id'] as num?)?.toInt(),
      tankId: (json['tankId'] as num).toInt(),
      name: json['name'] as String,
      driftwoodType: $enumDecode(_$DriftwoodTypeEnumMap, json['driftwoodType']),
      isCured: json['isCured'] as bool? ?? false,
      isReleasingTannins: json['isReleasingTannins'] as bool? ?? true,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      lengthCm: (json['lengthCm'] as num?)?.toDouble(),
      widthCm: (json['widthCm'] as num?)?.toDouble(),
      heightCm: (json['heightCm'] as num?)?.toDouble(),
      purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
      source: json['source'] as String?,
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      curingStartDate: json['curingStartDate'] == null
          ? null
          : DateTime.parse(json['curingStartDate'] as String),
      photoUrl: json['photoUrl'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DriftwoodEntityToJson(_DriftwoodEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'name': instance.name,
      'driftwoodType': _$DriftwoodTypeEnumMap[instance.driftwoodType]!,
      'isCured': instance.isCured,
      'isReleasingTannins': instance.isReleasingTannins,
      'quantity': instance.quantity,
      'lengthCm': instance.lengthCm,
      'widthCm': instance.widthCm,
      'heightCm': instance.heightCm,
      'purchasePrice': instance.purchasePrice,
      'source': instance.source,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'curingStartDate': instance.curingStartDate?.toIso8601String(),
      'photoUrl': instance.photoUrl,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DriftwoodTypeEnumMap = {
  DriftwoodType.manzanita: 'manzanita',
  DriftwoodType.spiderWood: 'spider_wood',
  DriftwoodType.malaysian: 'malaysian',
  DriftwoodType.mopani: 'mopani',
  DriftwoodType.cholla: 'cholla',
  DriftwoodType.bogwood: 'bogwood',
  DriftwoodType.redmoor: 'redmoor',
  DriftwoodType.sumatra: 'sumatra',
  DriftwoodType.savanna: 'savanna',
  DriftwoodType.bonsai: 'bonsai',
  DriftwoodType.branch: 'branch',
  DriftwoodType.other: 'other',
};
