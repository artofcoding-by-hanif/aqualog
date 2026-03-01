// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substrate_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubstrateLayerEntity _$SubstrateLayerEntityFromJson(
  Map<String, dynamic> json,
) => _SubstrateLayerEntity(
  id: (json['id'] as num?)?.toInt(),
  tankId: (json['tankId'] as num).toInt(),
  name: json['name'] as String,
  substrateType: $enumDecode(_$SubstrateTypeEnumMap, json['substrateType']),
  brand: json['brand'] as String?,
  depthCm: (json['depthCm'] as num?)?.toDouble(),
  layerOrder: (json['layerOrder'] as num?)?.toInt() ?? 0,
  volumeLiters: (json['volumeLiters'] as num?)?.toDouble(),
  weightKg: (json['weightKg'] as num?)?.toDouble(),
  color: json['color'] as String?,
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

Map<String, dynamic> _$SubstrateLayerEntityToJson(
  _SubstrateLayerEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'tankId': instance.tankId,
  'name': instance.name,
  'substrateType': _$SubstrateTypeEnumMap[instance.substrateType]!,
  'brand': instance.brand,
  'depthCm': instance.depthCm,
  'layerOrder': instance.layerOrder,
  'volumeLiters': instance.volumeLiters,
  'weightKg': instance.weightKg,
  'color': instance.color,
  'purchasePrice': instance.purchasePrice,
  'source': instance.source,
  'dateAdded': instance.dateAdded?.toIso8601String(),
  'photoUrl': instance.photoUrl,
  'notes': instance.notes,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$SubstrateTypeEnumMap = {
  SubstrateType.aquaSoil: 'aqua_soil',
  SubstrateType.gravel: 'gravel',
  SubstrateType.sand: 'sand',
  SubstrateType.crushedCoral: 'crushed_coral',
  SubstrateType.fluorite: 'fluorite',
  SubstrateType.ecoComplete: 'eco_complete',
  SubstrateType.stratum: 'stratum',
  SubstrateType.controsoil: 'controsoil',
  SubstrateType.amazonia: 'amazonia',
  SubstrateType.powerSand: 'power_sand',
  SubstrateType.lavaRockSubstrate: 'lava_rock_substrate',
  SubstrateType.peat: 'peat',
  SubstrateType.clay: 'clay',
  SubstrateType.rootTabs: 'root_tabs',
  SubstrateType.other: 'other',
};
