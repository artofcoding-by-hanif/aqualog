// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TankImageEntity _$TankImageEntityFromJson(Map<String, dynamic> json) =>
    _TankImageEntity(
      id: (json['id'] as num?)?.toInt(),
      tankId: (json['tankId'] as num).toInt(),
      imagePath: json['imagePath'] as String,
      caption: json['caption'] as String?,
      isCover: json['isCover'] as bool? ?? false,
      takenAt: json['takenAt'] == null
          ? null
          : DateTime.parse(json['takenAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TankImageEntityToJson(_TankImageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tankId': instance.tankId,
      'imagePath': instance.imagePath,
      'caption': instance.caption,
      'isCover': instance.isCover,
      'takenAt': instance.takenAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
