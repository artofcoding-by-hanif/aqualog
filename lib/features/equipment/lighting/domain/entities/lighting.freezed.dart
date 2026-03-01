// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lighting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LightingEntity {

/// Unique identifier (null for new lights)
 int? get id;/// Foreign key to tank
 int get tankId;/// Light name/label
 String get name;/// Lighting type
 LightingType get lightingType;/// Brand name
 String? get brand;/// Model number/name
 String? get model;/// Power consumption in watts
 double? get wattage;/// Color temperature in Kelvin
 int? get kelvinRating;/// Light spectrum category
 LightSpectrum? get spectrum;/// PAR (Photosynthetically Active Radiation) value at substrate
 int? get parValue;/// Lumens output
 int? get lumens;/// Whether the light is dimmable
 bool get isDimmable;/// Whether the light has timer functionality
 bool get hasTimer;/// Whether the light has color control (RGB)
 bool get hasColorControl;/// Light on time (HH:mm format, e.g., "08:00")
 String? get onTime;/// Light off time (HH:mm format, e.g., "20:00")
 String? get offTime;/// Current intensity percentage (0-100)
 int get intensityPercent;/// Last bulb/LED replacement date
 DateTime? get lastReplacedAt;/// Recommended replacement interval in days (for bulbs)
 int get replacementIntervalDays;/// Notes/additional info
 String? get notes;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of LightingEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightingEntityCopyWith<LightingEntity> get copyWith => _$LightingEntityCopyWithImpl<LightingEntity>(this as LightingEntity, _$identity);

  /// Serializes this LightingEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.lightingType, lightingType) || other.lightingType == lightingType)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.wattage, wattage) || other.wattage == wattage)&&(identical(other.kelvinRating, kelvinRating) || other.kelvinRating == kelvinRating)&&(identical(other.spectrum, spectrum) || other.spectrum == spectrum)&&(identical(other.parValue, parValue) || other.parValue == parValue)&&(identical(other.lumens, lumens) || other.lumens == lumens)&&(identical(other.isDimmable, isDimmable) || other.isDimmable == isDimmable)&&(identical(other.hasTimer, hasTimer) || other.hasTimer == hasTimer)&&(identical(other.hasColorControl, hasColorControl) || other.hasColorControl == hasColorControl)&&(identical(other.onTime, onTime) || other.onTime == onTime)&&(identical(other.offTime, offTime) || other.offTime == offTime)&&(identical(other.intensityPercent, intensityPercent) || other.intensityPercent == intensityPercent)&&(identical(other.lastReplacedAt, lastReplacedAt) || other.lastReplacedAt == lastReplacedAt)&&(identical(other.replacementIntervalDays, replacementIntervalDays) || other.replacementIntervalDays == replacementIntervalDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,name,lightingType,brand,model,wattage,kelvinRating,spectrum,parValue,lumens,isDimmable,hasTimer,hasColorControl,onTime,offTime,intensityPercent,lastReplacedAt,replacementIntervalDays,notes,createdAt,updatedAt]);

@override
String toString() {
  return 'LightingEntity(id: $id, tankId: $tankId, name: $name, lightingType: $lightingType, brand: $brand, model: $model, wattage: $wattage, kelvinRating: $kelvinRating, spectrum: $spectrum, parValue: $parValue, lumens: $lumens, isDimmable: $isDimmable, hasTimer: $hasTimer, hasColorControl: $hasColorControl, onTime: $onTime, offTime: $offTime, intensityPercent: $intensityPercent, lastReplacedAt: $lastReplacedAt, replacementIntervalDays: $replacementIntervalDays, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LightingEntityCopyWith<$Res>  {
  factory $LightingEntityCopyWith(LightingEntity value, $Res Function(LightingEntity) _then) = _$LightingEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String name, LightingType lightingType, String? brand, String? model, double? wattage, int? kelvinRating, LightSpectrum? spectrum, int? parValue, int? lumens, bool isDimmable, bool hasTimer, bool hasColorControl, String? onTime, String? offTime, int intensityPercent, DateTime? lastReplacedAt, int replacementIntervalDays, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$LightingEntityCopyWithImpl<$Res>
    implements $LightingEntityCopyWith<$Res> {
  _$LightingEntityCopyWithImpl(this._self, this._then);

  final LightingEntity _self;
  final $Res Function(LightingEntity) _then;

/// Create a copy of LightingEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? lightingType = null,Object? brand = freezed,Object? model = freezed,Object? wattage = freezed,Object? kelvinRating = freezed,Object? spectrum = freezed,Object? parValue = freezed,Object? lumens = freezed,Object? isDimmable = null,Object? hasTimer = null,Object? hasColorControl = null,Object? onTime = freezed,Object? offTime = freezed,Object? intensityPercent = null,Object? lastReplacedAt = freezed,Object? replacementIntervalDays = null,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lightingType: null == lightingType ? _self.lightingType : lightingType // ignore: cast_nullable_to_non_nullable
as LightingType,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,wattage: freezed == wattage ? _self.wattage : wattage // ignore: cast_nullable_to_non_nullable
as double?,kelvinRating: freezed == kelvinRating ? _self.kelvinRating : kelvinRating // ignore: cast_nullable_to_non_nullable
as int?,spectrum: freezed == spectrum ? _self.spectrum : spectrum // ignore: cast_nullable_to_non_nullable
as LightSpectrum?,parValue: freezed == parValue ? _self.parValue : parValue // ignore: cast_nullable_to_non_nullable
as int?,lumens: freezed == lumens ? _self.lumens : lumens // ignore: cast_nullable_to_non_nullable
as int?,isDimmable: null == isDimmable ? _self.isDimmable : isDimmable // ignore: cast_nullable_to_non_nullable
as bool,hasTimer: null == hasTimer ? _self.hasTimer : hasTimer // ignore: cast_nullable_to_non_nullable
as bool,hasColorControl: null == hasColorControl ? _self.hasColorControl : hasColorControl // ignore: cast_nullable_to_non_nullable
as bool,onTime: freezed == onTime ? _self.onTime : onTime // ignore: cast_nullable_to_non_nullable
as String?,offTime: freezed == offTime ? _self.offTime : offTime // ignore: cast_nullable_to_non_nullable
as String?,intensityPercent: null == intensityPercent ? _self.intensityPercent : intensityPercent // ignore: cast_nullable_to_non_nullable
as int,lastReplacedAt: freezed == lastReplacedAt ? _self.lastReplacedAt : lastReplacedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replacementIntervalDays: null == replacementIntervalDays ? _self.replacementIntervalDays : replacementIntervalDays // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LightingEntity].
extension LightingEntityPatterns on LightingEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LightingEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LightingEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LightingEntity value)  $default,){
final _that = this;
switch (_that) {
case _LightingEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LightingEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LightingEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  LightingType lightingType,  String? brand,  String? model,  double? wattage,  int? kelvinRating,  LightSpectrum? spectrum,  int? parValue,  int? lumens,  bool isDimmable,  bool hasTimer,  bool hasColorControl,  String? onTime,  String? offTime,  int intensityPercent,  DateTime? lastReplacedAt,  int replacementIntervalDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LightingEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.lightingType,_that.brand,_that.model,_that.wattage,_that.kelvinRating,_that.spectrum,_that.parValue,_that.lumens,_that.isDimmable,_that.hasTimer,_that.hasColorControl,_that.onTime,_that.offTime,_that.intensityPercent,_that.lastReplacedAt,_that.replacementIntervalDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  LightingType lightingType,  String? brand,  String? model,  double? wattage,  int? kelvinRating,  LightSpectrum? spectrum,  int? parValue,  int? lumens,  bool isDimmable,  bool hasTimer,  bool hasColorControl,  String? onTime,  String? offTime,  int intensityPercent,  DateTime? lastReplacedAt,  int replacementIntervalDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LightingEntity():
return $default(_that.id,_that.tankId,_that.name,_that.lightingType,_that.brand,_that.model,_that.wattage,_that.kelvinRating,_that.spectrum,_that.parValue,_that.lumens,_that.isDimmable,_that.hasTimer,_that.hasColorControl,_that.onTime,_that.offTime,_that.intensityPercent,_that.lastReplacedAt,_that.replacementIntervalDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String name,  LightingType lightingType,  String? brand,  String? model,  double? wattage,  int? kelvinRating,  LightSpectrum? spectrum,  int? parValue,  int? lumens,  bool isDimmable,  bool hasTimer,  bool hasColorControl,  String? onTime,  String? offTime,  int intensityPercent,  DateTime? lastReplacedAt,  int replacementIntervalDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LightingEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.lightingType,_that.brand,_that.model,_that.wattage,_that.kelvinRating,_that.spectrum,_that.parValue,_that.lumens,_that.isDimmable,_that.hasTimer,_that.hasColorControl,_that.onTime,_that.offTime,_that.intensityPercent,_that.lastReplacedAt,_that.replacementIntervalDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LightingEntity extends LightingEntity {
  const _LightingEntity({this.id, required this.tankId, required this.name, required this.lightingType, this.brand, this.model, this.wattage, this.kelvinRating, this.spectrum, this.parValue, this.lumens, this.isDimmable = false, this.hasTimer = false, this.hasColorControl = false, this.onTime, this.offTime, this.intensityPercent = 100, this.lastReplacedAt, this.replacementIntervalDays = 365, this.notes, this.createdAt, this.updatedAt}): super._();
  factory _LightingEntity.fromJson(Map<String, dynamic> json) => _$LightingEntityFromJson(json);

/// Unique identifier (null for new lights)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Light name/label
@override final  String name;
/// Lighting type
@override final  LightingType lightingType;
/// Brand name
@override final  String? brand;
/// Model number/name
@override final  String? model;
/// Power consumption in watts
@override final  double? wattage;
/// Color temperature in Kelvin
@override final  int? kelvinRating;
/// Light spectrum category
@override final  LightSpectrum? spectrum;
/// PAR (Photosynthetically Active Radiation) value at substrate
@override final  int? parValue;
/// Lumens output
@override final  int? lumens;
/// Whether the light is dimmable
@override@JsonKey() final  bool isDimmable;
/// Whether the light has timer functionality
@override@JsonKey() final  bool hasTimer;
/// Whether the light has color control (RGB)
@override@JsonKey() final  bool hasColorControl;
/// Light on time (HH:mm format, e.g., "08:00")
@override final  String? onTime;
/// Light off time (HH:mm format, e.g., "20:00")
@override final  String? offTime;
/// Current intensity percentage (0-100)
@override@JsonKey() final  int intensityPercent;
/// Last bulb/LED replacement date
@override final  DateTime? lastReplacedAt;
/// Recommended replacement interval in days (for bulbs)
@override@JsonKey() final  int replacementIntervalDays;
/// Notes/additional info
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of LightingEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LightingEntityCopyWith<_LightingEntity> get copyWith => __$LightingEntityCopyWithImpl<_LightingEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LightingEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LightingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.lightingType, lightingType) || other.lightingType == lightingType)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.wattage, wattage) || other.wattage == wattage)&&(identical(other.kelvinRating, kelvinRating) || other.kelvinRating == kelvinRating)&&(identical(other.spectrum, spectrum) || other.spectrum == spectrum)&&(identical(other.parValue, parValue) || other.parValue == parValue)&&(identical(other.lumens, lumens) || other.lumens == lumens)&&(identical(other.isDimmable, isDimmable) || other.isDimmable == isDimmable)&&(identical(other.hasTimer, hasTimer) || other.hasTimer == hasTimer)&&(identical(other.hasColorControl, hasColorControl) || other.hasColorControl == hasColorControl)&&(identical(other.onTime, onTime) || other.onTime == onTime)&&(identical(other.offTime, offTime) || other.offTime == offTime)&&(identical(other.intensityPercent, intensityPercent) || other.intensityPercent == intensityPercent)&&(identical(other.lastReplacedAt, lastReplacedAt) || other.lastReplacedAt == lastReplacedAt)&&(identical(other.replacementIntervalDays, replacementIntervalDays) || other.replacementIntervalDays == replacementIntervalDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,name,lightingType,brand,model,wattage,kelvinRating,spectrum,parValue,lumens,isDimmable,hasTimer,hasColorControl,onTime,offTime,intensityPercent,lastReplacedAt,replacementIntervalDays,notes,createdAt,updatedAt]);

@override
String toString() {
  return 'LightingEntity(id: $id, tankId: $tankId, name: $name, lightingType: $lightingType, brand: $brand, model: $model, wattage: $wattage, kelvinRating: $kelvinRating, spectrum: $spectrum, parValue: $parValue, lumens: $lumens, isDimmable: $isDimmable, hasTimer: $hasTimer, hasColorControl: $hasColorControl, onTime: $onTime, offTime: $offTime, intensityPercent: $intensityPercent, lastReplacedAt: $lastReplacedAt, replacementIntervalDays: $replacementIntervalDays, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LightingEntityCopyWith<$Res> implements $LightingEntityCopyWith<$Res> {
  factory _$LightingEntityCopyWith(_LightingEntity value, $Res Function(_LightingEntity) _then) = __$LightingEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String name, LightingType lightingType, String? brand, String? model, double? wattage, int? kelvinRating, LightSpectrum? spectrum, int? parValue, int? lumens, bool isDimmable, bool hasTimer, bool hasColorControl, String? onTime, String? offTime, int intensityPercent, DateTime? lastReplacedAt, int replacementIntervalDays, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$LightingEntityCopyWithImpl<$Res>
    implements _$LightingEntityCopyWith<$Res> {
  __$LightingEntityCopyWithImpl(this._self, this._then);

  final _LightingEntity _self;
  final $Res Function(_LightingEntity) _then;

/// Create a copy of LightingEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? lightingType = null,Object? brand = freezed,Object? model = freezed,Object? wattage = freezed,Object? kelvinRating = freezed,Object? spectrum = freezed,Object? parValue = freezed,Object? lumens = freezed,Object? isDimmable = null,Object? hasTimer = null,Object? hasColorControl = null,Object? onTime = freezed,Object? offTime = freezed,Object? intensityPercent = null,Object? lastReplacedAt = freezed,Object? replacementIntervalDays = null,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_LightingEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lightingType: null == lightingType ? _self.lightingType : lightingType // ignore: cast_nullable_to_non_nullable
as LightingType,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,wattage: freezed == wattage ? _self.wattage : wattage // ignore: cast_nullable_to_non_nullable
as double?,kelvinRating: freezed == kelvinRating ? _self.kelvinRating : kelvinRating // ignore: cast_nullable_to_non_nullable
as int?,spectrum: freezed == spectrum ? _self.spectrum : spectrum // ignore: cast_nullable_to_non_nullable
as LightSpectrum?,parValue: freezed == parValue ? _self.parValue : parValue // ignore: cast_nullable_to_non_nullable
as int?,lumens: freezed == lumens ? _self.lumens : lumens // ignore: cast_nullable_to_non_nullable
as int?,isDimmable: null == isDimmable ? _self.isDimmable : isDimmable // ignore: cast_nullable_to_non_nullable
as bool,hasTimer: null == hasTimer ? _self.hasTimer : hasTimer // ignore: cast_nullable_to_non_nullable
as bool,hasColorControl: null == hasColorControl ? _self.hasColorControl : hasColorControl // ignore: cast_nullable_to_non_nullable
as bool,onTime: freezed == onTime ? _self.onTime : onTime // ignore: cast_nullable_to_non_nullable
as String?,offTime: freezed == offTime ? _self.offTime : offTime // ignore: cast_nullable_to_non_nullable
as String?,intensityPercent: null == intensityPercent ? _self.intensityPercent : intensityPercent // ignore: cast_nullable_to_non_nullable
as int,lastReplacedAt: freezed == lastReplacedAt ? _self.lastReplacedAt : lastReplacedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replacementIntervalDays: null == replacementIntervalDays ? _self.replacementIntervalDays : replacementIntervalDays // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
