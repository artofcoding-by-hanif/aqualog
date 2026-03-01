// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TankEntity {

/// Unique identifier (null for new tanks)
 int? get id;/// Tank name (e.g., "Living Room Tank")
 String get name;/// Tank type
 TankType get tankType;/// Volume in liters (base unit)
 double get volumeLiters;/// Length in cm
 double? get lengthCm;/// Width in cm
 double? get widthCm;/// Height in cm
 double? get heightCm;/// Description/notes
 String? get description;/// Photo path (local storage)
 String? get photoPath;/// Setup/start date
 DateTime? get setupDate;/// Whether this is the currently selected/active tank
 bool get isActive;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of TankEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TankEntityCopyWith<TankEntity> get copyWith => _$TankEntityCopyWithImpl<TankEntity>(this as TankEntity, _$identity);

  /// Serializes this TankEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TankEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.tankType, tankType) || other.tankType == tankType)&&(identical(other.volumeLiters, volumeLiters) || other.volumeLiters == volumeLiters)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.widthCm, widthCm) || other.widthCm == widthCm)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.setupDate, setupDate) || other.setupDate == setupDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,tankType,volumeLiters,lengthCm,widthCm,heightCm,description,photoPath,setupDate,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'TankEntity(id: $id, name: $name, tankType: $tankType, volumeLiters: $volumeLiters, lengthCm: $lengthCm, widthCm: $widthCm, heightCm: $heightCm, description: $description, photoPath: $photoPath, setupDate: $setupDate, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TankEntityCopyWith<$Res>  {
  factory $TankEntityCopyWith(TankEntity value, $Res Function(TankEntity) _then) = _$TankEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String name, TankType tankType, double volumeLiters, double? lengthCm, double? widthCm, double? heightCm, String? description, String? photoPath, DateTime? setupDate, bool isActive, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$TankEntityCopyWithImpl<$Res>
    implements $TankEntityCopyWith<$Res> {
  _$TankEntityCopyWithImpl(this._self, this._then);

  final TankEntity _self;
  final $Res Function(TankEntity) _then;

/// Create a copy of TankEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? tankType = null,Object? volumeLiters = null,Object? lengthCm = freezed,Object? widthCm = freezed,Object? heightCm = freezed,Object? description = freezed,Object? photoPath = freezed,Object? setupDate = freezed,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tankType: null == tankType ? _self.tankType : tankType // ignore: cast_nullable_to_non_nullable
as TankType,volumeLiters: null == volumeLiters ? _self.volumeLiters : volumeLiters // ignore: cast_nullable_to_non_nullable
as double,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,widthCm: freezed == widthCm ? _self.widthCm : widthCm // ignore: cast_nullable_to_non_nullable
as double?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,setupDate: freezed == setupDate ? _self.setupDate : setupDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TankEntity].
extension TankEntityPatterns on TankEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TankEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TankEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TankEntity value)  $default,){
final _that = this;
switch (_that) {
case _TankEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TankEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TankEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  TankType tankType,  double volumeLiters,  double? lengthCm,  double? widthCm,  double? heightCm,  String? description,  String? photoPath,  DateTime? setupDate,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TankEntity() when $default != null:
return $default(_that.id,_that.name,_that.tankType,_that.volumeLiters,_that.lengthCm,_that.widthCm,_that.heightCm,_that.description,_that.photoPath,_that.setupDate,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  TankType tankType,  double volumeLiters,  double? lengthCm,  double? widthCm,  double? heightCm,  String? description,  String? photoPath,  DateTime? setupDate,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TankEntity():
return $default(_that.id,_that.name,_that.tankType,_that.volumeLiters,_that.lengthCm,_that.widthCm,_that.heightCm,_that.description,_that.photoPath,_that.setupDate,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  TankType tankType,  double volumeLiters,  double? lengthCm,  double? widthCm,  double? heightCm,  String? description,  String? photoPath,  DateTime? setupDate,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TankEntity() when $default != null:
return $default(_that.id,_that.name,_that.tankType,_that.volumeLiters,_that.lengthCm,_that.widthCm,_that.heightCm,_that.description,_that.photoPath,_that.setupDate,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TankEntity extends TankEntity {
  const _TankEntity({this.id, required this.name, required this.tankType, required this.volumeLiters, this.lengthCm, this.widthCm, this.heightCm, this.description, this.photoPath, this.setupDate, this.isActive = false, this.createdAt, this.updatedAt}): super._();
  factory _TankEntity.fromJson(Map<String, dynamic> json) => _$TankEntityFromJson(json);

/// Unique identifier (null for new tanks)
@override final  int? id;
/// Tank name (e.g., "Living Room Tank")
@override final  String name;
/// Tank type
@override final  TankType tankType;
/// Volume in liters (base unit)
@override final  double volumeLiters;
/// Length in cm
@override final  double? lengthCm;
/// Width in cm
@override final  double? widthCm;
/// Height in cm
@override final  double? heightCm;
/// Description/notes
@override final  String? description;
/// Photo path (local storage)
@override final  String? photoPath;
/// Setup/start date
@override final  DateTime? setupDate;
/// Whether this is the currently selected/active tank
@override@JsonKey() final  bool isActive;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of TankEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TankEntityCopyWith<_TankEntity> get copyWith => __$TankEntityCopyWithImpl<_TankEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TankEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TankEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.tankType, tankType) || other.tankType == tankType)&&(identical(other.volumeLiters, volumeLiters) || other.volumeLiters == volumeLiters)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.widthCm, widthCm) || other.widthCm == widthCm)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.setupDate, setupDate) || other.setupDate == setupDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,tankType,volumeLiters,lengthCm,widthCm,heightCm,description,photoPath,setupDate,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'TankEntity(id: $id, name: $name, tankType: $tankType, volumeLiters: $volumeLiters, lengthCm: $lengthCm, widthCm: $widthCm, heightCm: $heightCm, description: $description, photoPath: $photoPath, setupDate: $setupDate, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TankEntityCopyWith<$Res> implements $TankEntityCopyWith<$Res> {
  factory _$TankEntityCopyWith(_TankEntity value, $Res Function(_TankEntity) _then) = __$TankEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, TankType tankType, double volumeLiters, double? lengthCm, double? widthCm, double? heightCm, String? description, String? photoPath, DateTime? setupDate, bool isActive, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$TankEntityCopyWithImpl<$Res>
    implements _$TankEntityCopyWith<$Res> {
  __$TankEntityCopyWithImpl(this._self, this._then);

  final _TankEntity _self;
  final $Res Function(_TankEntity) _then;

/// Create a copy of TankEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? tankType = null,Object? volumeLiters = null,Object? lengthCm = freezed,Object? widthCm = freezed,Object? heightCm = freezed,Object? description = freezed,Object? photoPath = freezed,Object? setupDate = freezed,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TankEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tankType: null == tankType ? _self.tankType : tankType // ignore: cast_nullable_to_non_nullable
as TankType,volumeLiters: null == volumeLiters ? _self.volumeLiters : volumeLiters // ignore: cast_nullable_to_non_nullable
as double,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,widthCm: freezed == widthCm ? _self.widthCm : widthCm // ignore: cast_nullable_to_non_nullable
as double?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,setupDate: freezed == setupDate ? _self.setupDate : setupDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
