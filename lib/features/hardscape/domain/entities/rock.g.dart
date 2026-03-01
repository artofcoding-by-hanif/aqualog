// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RockEntity _$RockEntityFromJson(Map<String, dynamic> json) => _RockEntity(
  id: (json['id'] as num?)?.toInt(),
  tankId: (json['tankId'] as num).toInt(),
  name: json['name'] as String,
  rockType: $enumDecode(_$RockTypeEnumMap, json['rockType']),
  weightKg: (json['weightKg'] as num?)?.toDouble(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  lengthCm: (json['lengthCm'] as num?)?.toDouble(),
  widthCm: (json['widthCm'] as num?)?.toDouble(),
  heightCm: (json['heightCm'] as num?)?.toDouble(),
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
  source: json['source'] as String?,
  dateAdded: json['dateAdded'] == null
      ? null
      : DateTime.parse(json['dateAdded'] as String),
  photoUrl: json['photoUrl'] as String?,
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RockEntityToJson(_RockEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'name': instance.name,
      'rockType': _$RockTypeEnumMap[instance.rockType]!,
      'weightKg': instance.weightKg,
      'quantity': instance.quantity,
      'lengthCm': instance.lengthCm,
      'widthCm': instance.widthCm,
      'heightCm': instance.heightCm,
      'purchasePrice': instance.purchasePrice,
      'source': instance.source,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'photoUrl': instance.photoUrl,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RockTypeEnumMap = {
  RockType.dragonStone: 'dragon_stone',
  RockType.seiryu: 'seiryu',
  RockType.lavaRock: 'lava_rock',
  RockType.slate: 'slate',
  RockType.riverRock: 'river_rock',
  RockType.petrifiedWood: 'petrified_wood',
  RockType.texasHoley: 'texas_holey',
  RockType.rainbowRock: 'rainbow_rock',
  RockType.pagoda: 'pagoda',
  RockType.elephantSkin: 'elephant_skin',
  RockType.mapleLeaf: 'maple_leaf',
  RockType.other: 'other',
};
