// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photoperiod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhotoperiodSegment _$PhotoperiodSegmentFromJson(Map<String, dynamic> json) =>
    _PhotoperiodSegment(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      intensity: (json['intensity'] as num?)?.toInt() ?? 100,
      colorTemperature: (json['colorTemperature'] as num?)?.toInt(),
      colorHex: json['colorHex'] as String?,
      rampEnabled: json['rampEnabled'] as bool? ?? false,
      rampDurationMinutes: (json['rampDurationMinutes'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$PhotoperiodSegmentToJson(_PhotoperiodSegment instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'intensity': instance.intensity,
      'colorTemperature': instance.colorTemperature,
      'colorHex': instance.colorHex,
      'rampEnabled': instance.rampEnabled,
      'rampDurationMinutes': instance.rampDurationMinutes,
    };

_PhotoperiodEntity _$PhotoperiodEntityFromJson(Map<String, dynamic> json) =>
    _PhotoperiodEntity(
      id: (json['id'] as num?)?.toInt(),
      lightingId: (json['lightingId'] as num).toInt(),
      name: json['name'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      segments:
          (json['segments'] as List<dynamic>?)
              ?.map(
                (e) => PhotoperiodSegment.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      activeDays:
          (json['activeDays'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PhotoperiodEntityToJson(
  _PhotoperiodEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'lightingId': instance.lightingId,
  'name': instance.name,
  'isEnabled': instance.isEnabled,
  'segments': instance.segments,
  'activeDays': instance.activeDays.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
  'notes': instance.notes,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'monday',
  DayOfWeek.tuesday: 'tuesday',
  DayOfWeek.wednesday: 'wednesday',
  DayOfWeek.thursday: 'thursday',
  DayOfWeek.friday: 'friday',
  DayOfWeek.saturday: 'saturday',
  DayOfWeek.sunday: 'sunday',
};
