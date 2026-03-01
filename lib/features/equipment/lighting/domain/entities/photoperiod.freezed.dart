// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photoperiod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoperiodSegment {

/// Start time in HH:mm format (e.g., "08:00")
 String get startTime;/// End time in HH:mm format (e.g., "20:00")
 String get endTime;/// Intensity percentage (0-100)
 int get intensity;/// Optional color temperature for this segment (Kelvin)
 int? get colorTemperature;/// Optional RGB values for color control (hex format, e.g., "#FF5500")
 String? get colorHex;/// Whether to ramp/fade to this intensity (vs instant switch)
 bool get rampEnabled;/// Ramp duration in minutes (if rampEnabled)
 int get rampDurationMinutes;
/// Create a copy of PhotoperiodSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoperiodSegmentCopyWith<PhotoperiodSegment> get copyWith => _$PhotoperiodSegmentCopyWithImpl<PhotoperiodSegment>(this as PhotoperiodSegment, _$identity);

  /// Serializes this PhotoperiodSegment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoperiodSegment&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.colorTemperature, colorTemperature) || other.colorTemperature == colorTemperature)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.rampEnabled, rampEnabled) || other.rampEnabled == rampEnabled)&&(identical(other.rampDurationMinutes, rampDurationMinutes) || other.rampDurationMinutes == rampDurationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,intensity,colorTemperature,colorHex,rampEnabled,rampDurationMinutes);

@override
String toString() {
  return 'PhotoperiodSegment(startTime: $startTime, endTime: $endTime, intensity: $intensity, colorTemperature: $colorTemperature, colorHex: $colorHex, rampEnabled: $rampEnabled, rampDurationMinutes: $rampDurationMinutes)';
}


}

/// @nodoc
abstract mixin class $PhotoperiodSegmentCopyWith<$Res>  {
  factory $PhotoperiodSegmentCopyWith(PhotoperiodSegment value, $Res Function(PhotoperiodSegment) _then) = _$PhotoperiodSegmentCopyWithImpl;
@useResult
$Res call({
 String startTime, String endTime, int intensity, int? colorTemperature, String? colorHex, bool rampEnabled, int rampDurationMinutes
});




}
/// @nodoc
class _$PhotoperiodSegmentCopyWithImpl<$Res>
    implements $PhotoperiodSegmentCopyWith<$Res> {
  _$PhotoperiodSegmentCopyWithImpl(this._self, this._then);

  final PhotoperiodSegment _self;
  final $Res Function(PhotoperiodSegment) _then;

/// Create a copy of PhotoperiodSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTime = null,Object? endTime = null,Object? intensity = null,Object? colorTemperature = freezed,Object? colorHex = freezed,Object? rampEnabled = null,Object? rampDurationMinutes = null,}) {
  return _then(_self.copyWith(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,colorTemperature: freezed == colorTemperature ? _self.colorTemperature : colorTemperature // ignore: cast_nullable_to_non_nullable
as int?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,rampEnabled: null == rampEnabled ? _self.rampEnabled : rampEnabled // ignore: cast_nullable_to_non_nullable
as bool,rampDurationMinutes: null == rampDurationMinutes ? _self.rampDurationMinutes : rampDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoperiodSegment].
extension PhotoperiodSegmentPatterns on PhotoperiodSegment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoperiodSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoperiodSegment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoperiodSegment value)  $default,){
final _that = this;
switch (_that) {
case _PhotoperiodSegment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoperiodSegment value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoperiodSegment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String startTime,  String endTime,  int intensity,  int? colorTemperature,  String? colorHex,  bool rampEnabled,  int rampDurationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoperiodSegment() when $default != null:
return $default(_that.startTime,_that.endTime,_that.intensity,_that.colorTemperature,_that.colorHex,_that.rampEnabled,_that.rampDurationMinutes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String startTime,  String endTime,  int intensity,  int? colorTemperature,  String? colorHex,  bool rampEnabled,  int rampDurationMinutes)  $default,) {final _that = this;
switch (_that) {
case _PhotoperiodSegment():
return $default(_that.startTime,_that.endTime,_that.intensity,_that.colorTemperature,_that.colorHex,_that.rampEnabled,_that.rampDurationMinutes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String startTime,  String endTime,  int intensity,  int? colorTemperature,  String? colorHex,  bool rampEnabled,  int rampDurationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _PhotoperiodSegment() when $default != null:
return $default(_that.startTime,_that.endTime,_that.intensity,_that.colorTemperature,_that.colorHex,_that.rampEnabled,_that.rampDurationMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoperiodSegment extends PhotoperiodSegment {
  const _PhotoperiodSegment({required this.startTime, required this.endTime, this.intensity = 100, this.colorTemperature, this.colorHex, this.rampEnabled = false, this.rampDurationMinutes = 30}): super._();
  factory _PhotoperiodSegment.fromJson(Map<String, dynamic> json) => _$PhotoperiodSegmentFromJson(json);

/// Start time in HH:mm format (e.g., "08:00")
@override final  String startTime;
/// End time in HH:mm format (e.g., "20:00")
@override final  String endTime;
/// Intensity percentage (0-100)
@override@JsonKey() final  int intensity;
/// Optional color temperature for this segment (Kelvin)
@override final  int? colorTemperature;
/// Optional RGB values for color control (hex format, e.g., "#FF5500")
@override final  String? colorHex;
/// Whether to ramp/fade to this intensity (vs instant switch)
@override@JsonKey() final  bool rampEnabled;
/// Ramp duration in minutes (if rampEnabled)
@override@JsonKey() final  int rampDurationMinutes;

/// Create a copy of PhotoperiodSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoperiodSegmentCopyWith<_PhotoperiodSegment> get copyWith => __$PhotoperiodSegmentCopyWithImpl<_PhotoperiodSegment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoperiodSegmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoperiodSegment&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.colorTemperature, colorTemperature) || other.colorTemperature == colorTemperature)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.rampEnabled, rampEnabled) || other.rampEnabled == rampEnabled)&&(identical(other.rampDurationMinutes, rampDurationMinutes) || other.rampDurationMinutes == rampDurationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,intensity,colorTemperature,colorHex,rampEnabled,rampDurationMinutes);

@override
String toString() {
  return 'PhotoperiodSegment(startTime: $startTime, endTime: $endTime, intensity: $intensity, colorTemperature: $colorTemperature, colorHex: $colorHex, rampEnabled: $rampEnabled, rampDurationMinutes: $rampDurationMinutes)';
}


}

/// @nodoc
abstract mixin class _$PhotoperiodSegmentCopyWith<$Res> implements $PhotoperiodSegmentCopyWith<$Res> {
  factory _$PhotoperiodSegmentCopyWith(_PhotoperiodSegment value, $Res Function(_PhotoperiodSegment) _then) = __$PhotoperiodSegmentCopyWithImpl;
@override @useResult
$Res call({
 String startTime, String endTime, int intensity, int? colorTemperature, String? colorHex, bool rampEnabled, int rampDurationMinutes
});




}
/// @nodoc
class __$PhotoperiodSegmentCopyWithImpl<$Res>
    implements _$PhotoperiodSegmentCopyWith<$Res> {
  __$PhotoperiodSegmentCopyWithImpl(this._self, this._then);

  final _PhotoperiodSegment _self;
  final $Res Function(_PhotoperiodSegment) _then;

/// Create a copy of PhotoperiodSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? endTime = null,Object? intensity = null,Object? colorTemperature = freezed,Object? colorHex = freezed,Object? rampEnabled = null,Object? rampDurationMinutes = null,}) {
  return _then(_PhotoperiodSegment(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int,colorTemperature: freezed == colorTemperature ? _self.colorTemperature : colorTemperature // ignore: cast_nullable_to_non_nullable
as int?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,rampEnabled: null == rampEnabled ? _self.rampEnabled : rampEnabled // ignore: cast_nullable_to_non_nullable
as bool,rampDurationMinutes: null == rampDurationMinutes ? _self.rampDurationMinutes : rampDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PhotoperiodEntity {

/// Unique identifier (null for new photoperiods)
 int? get id;/// Foreign key to lighting fixture
 int get lightingId;/// Schedule name (e.g., "Summer Schedule", "Plant Growth")
 String get name;/// Whether this schedule is currently active
 bool get isEnabled;/// Light segments in the schedule
 List<PhotoperiodSegment> get segments;/// Days of the week this schedule applies to
 List<DayOfWeek> get activeDays;/// Notes/additional info
 String? get notes;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of PhotoperiodEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoperiodEntityCopyWith<PhotoperiodEntity> get copyWith => _$PhotoperiodEntityCopyWithImpl<PhotoperiodEntity>(this as PhotoperiodEntity, _$identity);

  /// Serializes this PhotoperiodEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoperiodEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.lightingId, lightingId) || other.lightingId == lightingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other.segments, segments)&&const DeepCollectionEquality().equals(other.activeDays, activeDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lightingId,name,isEnabled,const DeepCollectionEquality().hash(segments),const DeepCollectionEquality().hash(activeDays),notes,createdAt,updatedAt);

@override
String toString() {
  return 'PhotoperiodEntity(id: $id, lightingId: $lightingId, name: $name, isEnabled: $isEnabled, segments: $segments, activeDays: $activeDays, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PhotoperiodEntityCopyWith<$Res>  {
  factory $PhotoperiodEntityCopyWith(PhotoperiodEntity value, $Res Function(PhotoperiodEntity) _then) = _$PhotoperiodEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int lightingId, String name, bool isEnabled, List<PhotoperiodSegment> segments, List<DayOfWeek> activeDays, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PhotoperiodEntityCopyWithImpl<$Res>
    implements $PhotoperiodEntityCopyWith<$Res> {
  _$PhotoperiodEntityCopyWithImpl(this._self, this._then);

  final PhotoperiodEntity _self;
  final $Res Function(PhotoperiodEntity) _then;

/// Create a copy of PhotoperiodEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? lightingId = null,Object? name = null,Object? isEnabled = null,Object? segments = null,Object? activeDays = null,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,lightingId: null == lightingId ? _self.lightingId : lightingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<PhotoperiodSegment>,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as List<DayOfWeek>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoperiodEntity].
extension PhotoperiodEntityPatterns on PhotoperiodEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoperiodEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoperiodEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoperiodEntity value)  $default,){
final _that = this;
switch (_that) {
case _PhotoperiodEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoperiodEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoperiodEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int lightingId,  String name,  bool isEnabled,  List<PhotoperiodSegment> segments,  List<DayOfWeek> activeDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoperiodEntity() when $default != null:
return $default(_that.id,_that.lightingId,_that.name,_that.isEnabled,_that.segments,_that.activeDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int lightingId,  String name,  bool isEnabled,  List<PhotoperiodSegment> segments,  List<DayOfWeek> activeDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PhotoperiodEntity():
return $default(_that.id,_that.lightingId,_that.name,_that.isEnabled,_that.segments,_that.activeDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int lightingId,  String name,  bool isEnabled,  List<PhotoperiodSegment> segments,  List<DayOfWeek> activeDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PhotoperiodEntity() when $default != null:
return $default(_that.id,_that.lightingId,_that.name,_that.isEnabled,_that.segments,_that.activeDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoperiodEntity extends PhotoperiodEntity {
  const _PhotoperiodEntity({this.id, required this.lightingId, required this.name, this.isEnabled = true, final  List<PhotoperiodSegment> segments = const [], final  List<DayOfWeek> activeDays = const [], this.notes, this.createdAt, this.updatedAt}): _segments = segments,_activeDays = activeDays,super._();
  factory _PhotoperiodEntity.fromJson(Map<String, dynamic> json) => _$PhotoperiodEntityFromJson(json);

/// Unique identifier (null for new photoperiods)
@override final  int? id;
/// Foreign key to lighting fixture
@override final  int lightingId;
/// Schedule name (e.g., "Summer Schedule", "Plant Growth")
@override final  String name;
/// Whether this schedule is currently active
@override@JsonKey() final  bool isEnabled;
/// Light segments in the schedule
 final  List<PhotoperiodSegment> _segments;
/// Light segments in the schedule
@override@JsonKey() List<PhotoperiodSegment> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

/// Days of the week this schedule applies to
 final  List<DayOfWeek> _activeDays;
/// Days of the week this schedule applies to
@override@JsonKey() List<DayOfWeek> get activeDays {
  if (_activeDays is EqualUnmodifiableListView) return _activeDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeDays);
}

/// Notes/additional info
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of PhotoperiodEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoperiodEntityCopyWith<_PhotoperiodEntity> get copyWith => __$PhotoperiodEntityCopyWithImpl<_PhotoperiodEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoperiodEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoperiodEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.lightingId, lightingId) || other.lightingId == lightingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other._segments, _segments)&&const DeepCollectionEquality().equals(other._activeDays, _activeDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lightingId,name,isEnabled,const DeepCollectionEquality().hash(_segments),const DeepCollectionEquality().hash(_activeDays),notes,createdAt,updatedAt);

@override
String toString() {
  return 'PhotoperiodEntity(id: $id, lightingId: $lightingId, name: $name, isEnabled: $isEnabled, segments: $segments, activeDays: $activeDays, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PhotoperiodEntityCopyWith<$Res> implements $PhotoperiodEntityCopyWith<$Res> {
  factory _$PhotoperiodEntityCopyWith(_PhotoperiodEntity value, $Res Function(_PhotoperiodEntity) _then) = __$PhotoperiodEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int lightingId, String name, bool isEnabled, List<PhotoperiodSegment> segments, List<DayOfWeek> activeDays, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PhotoperiodEntityCopyWithImpl<$Res>
    implements _$PhotoperiodEntityCopyWith<$Res> {
  __$PhotoperiodEntityCopyWithImpl(this._self, this._then);

  final _PhotoperiodEntity _self;
  final $Res Function(_PhotoperiodEntity) _then;

/// Create a copy of PhotoperiodEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? lightingId = null,Object? name = null,Object? isEnabled = null,Object? segments = null,Object? activeDays = null,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_PhotoperiodEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,lightingId: null == lightingId ? _self.lightingId : lightingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<PhotoperiodSegment>,activeDays: null == activeDays ? _self._activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as List<DayOfWeek>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
