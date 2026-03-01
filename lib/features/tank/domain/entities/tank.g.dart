// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TankEntity _$TankEntityFromJson(Map<String, dynamic> json) => _TankEntity(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  tankType: $enumDecode(_$TankTypeEnumMap, json['tankType']),
  volumeLiters: (json['volumeLiters'] as num).toDouble(),
  lengthCm: (json['lengthCm'] as num?)?.toDouble(),
  widthCm: (json['widthCm'] as num?)?.toDouble(),
  heightCm: (json['heightCm'] as num?)?.toDouble(),
  description: json['description'] as String?,
  photoPath: json['photoPath'] as String?,
  setupDate: json['setupDate'] == null
      ? null
      : DateTime.parse(json['setupDate'] as String),
  isActive: json['isActive'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TankEntityToJson(_TankEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tankType': _$TankTypeEnumMap[instance.tankType]!,
      'volumeLiters': instance.volumeLiters,
      'lengthCm': instance.lengthCm,
      'widthCm': instance.widthCm,
      'heightCm': instance.heightCm,
      'description': instance.description,
      'photoPath': instance.photoPath,
      'setupDate': instance.setupDate?.toIso8601String(),
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$TankTypeEnumMap = {
  TankType.freshwater: 'freshwater',
  TankType.saltwater: 'saltwater',
  TankType.brackish: 'brackish',
  TankType.planted: 'planted',
  TankType.reef: 'reef',
  TankType.shrimp: 'shrimp',
  TankType.pond: 'pond',
};
