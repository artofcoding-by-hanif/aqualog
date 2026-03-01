// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'glass_calculation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlassCalculationEntity {

/// Unique identifier (null for new calculations)
 int? get id;/// Name/label for this calculation
 String get name;/// Tank length in mm
 double get lengthMm;/// Tank width in mm
 double get widthMm;/// Tank height in mm
 double get heightMm;/// Glass thickness in mm
 double get glassThicknessMm;/// Glue/silicone thickness in mm (default 1mm)
 double get glueThicknessMm;/// Calculated volume in liters
 double get volumeLiters;/// Bottom glass length in mm
 double get bottomLengthMm;/// Bottom glass width in mm
 double get bottomWidthMm;/// Front/back glass length in mm
 double get frontBackLengthMm;/// Front/back glass height in mm
 double get frontBackHeightMm;/// Side glass width in mm
 double get sideWidthMm;/// Side glass height in mm
 double get sideHeightMm;/// Total glass area in square meters
 double get totalGlassAreaSqM;/// Estimated glass weight in kg
 double get estimatedWeightKg;/// Notes
 String? get notes;/// Created timestamp
 DateTime? get createdAt;
/// Create a copy of GlassCalculationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlassCalculationEntityCopyWith<GlassCalculationEntity> get copyWith => _$GlassCalculationEntityCopyWithImpl<GlassCalculationEntity>(this as GlassCalculationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlassCalculationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lengthMm, lengthMm) || other.lengthMm == lengthMm)&&(identical(other.widthMm, widthMm) || other.widthMm == widthMm)&&(identical(other.heightMm, heightMm) || other.heightMm == heightMm)&&(identical(other.glassThicknessMm, glassThicknessMm) || other.glassThicknessMm == glassThicknessMm)&&(identical(other.glueThicknessMm, glueThicknessMm) || other.glueThicknessMm == glueThicknessMm)&&(identical(other.volumeLiters, volumeLiters) || other.volumeLiters == volumeLiters)&&(identical(other.bottomLengthMm, bottomLengthMm) || other.bottomLengthMm == bottomLengthMm)&&(identical(other.bottomWidthMm, bottomWidthMm) || other.bottomWidthMm == bottomWidthMm)&&(identical(other.frontBackLengthMm, frontBackLengthMm) || other.frontBackLengthMm == frontBackLengthMm)&&(identical(other.frontBackHeightMm, frontBackHeightMm) || other.frontBackHeightMm == frontBackHeightMm)&&(identical(other.sideWidthMm, sideWidthMm) || other.sideWidthMm == sideWidthMm)&&(identical(other.sideHeightMm, sideHeightMm) || other.sideHeightMm == sideHeightMm)&&(identical(other.totalGlassAreaSqM, totalGlassAreaSqM) || other.totalGlassAreaSqM == totalGlassAreaSqM)&&(identical(other.estimatedWeightKg, estimatedWeightKg) || other.estimatedWeightKg == estimatedWeightKg)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,lengthMm,widthMm,heightMm,glassThicknessMm,glueThicknessMm,volumeLiters,bottomLengthMm,bottomWidthMm,frontBackLengthMm,frontBackHeightMm,sideWidthMm,sideHeightMm,totalGlassAreaSqM,estimatedWeightKg,notes,createdAt);

@override
String toString() {
  return 'GlassCalculationEntity(id: $id, name: $name, lengthMm: $lengthMm, widthMm: $widthMm, heightMm: $heightMm, glassThicknessMm: $glassThicknessMm, glueThicknessMm: $glueThicknessMm, volumeLiters: $volumeLiters, bottomLengthMm: $bottomLengthMm, bottomWidthMm: $bottomWidthMm, frontBackLengthMm: $frontBackLengthMm, frontBackHeightMm: $frontBackHeightMm, sideWidthMm: $sideWidthMm, sideHeightMm: $sideHeightMm, totalGlassAreaSqM: $totalGlassAreaSqM, estimatedWeightKg: $estimatedWeightKg, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GlassCalculationEntityCopyWith<$Res>  {
  factory $GlassCalculationEntityCopyWith(GlassCalculationEntity value, $Res Function(GlassCalculationEntity) _then) = _$GlassCalculationEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String name, double lengthMm, double widthMm, double heightMm, double glassThicknessMm, double glueThicknessMm, double volumeLiters, double bottomLengthMm, double bottomWidthMm, double frontBackLengthMm, double frontBackHeightMm, double sideWidthMm, double sideHeightMm, double totalGlassAreaSqM, double estimatedWeightKg, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$GlassCalculationEntityCopyWithImpl<$Res>
    implements $GlassCalculationEntityCopyWith<$Res> {
  _$GlassCalculationEntityCopyWithImpl(this._self, this._then);

  final GlassCalculationEntity _self;
  final $Res Function(GlassCalculationEntity) _then;

/// Create a copy of GlassCalculationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? lengthMm = null,Object? widthMm = null,Object? heightMm = null,Object? glassThicknessMm = null,Object? glueThicknessMm = null,Object? volumeLiters = null,Object? bottomLengthMm = null,Object? bottomWidthMm = null,Object? frontBackLengthMm = null,Object? frontBackHeightMm = null,Object? sideWidthMm = null,Object? sideHeightMm = null,Object? totalGlassAreaSqM = null,Object? estimatedWeightKg = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lengthMm: null == lengthMm ? _self.lengthMm : lengthMm // ignore: cast_nullable_to_non_nullable
as double,widthMm: null == widthMm ? _self.widthMm : widthMm // ignore: cast_nullable_to_non_nullable
as double,heightMm: null == heightMm ? _self.heightMm : heightMm // ignore: cast_nullable_to_non_nullable
as double,glassThicknessMm: null == glassThicknessMm ? _self.glassThicknessMm : glassThicknessMm // ignore: cast_nullable_to_non_nullable
as double,glueThicknessMm: null == glueThicknessMm ? _self.glueThicknessMm : glueThicknessMm // ignore: cast_nullable_to_non_nullable
as double,volumeLiters: null == volumeLiters ? _self.volumeLiters : volumeLiters // ignore: cast_nullable_to_non_nullable
as double,bottomLengthMm: null == bottomLengthMm ? _self.bottomLengthMm : bottomLengthMm // ignore: cast_nullable_to_non_nullable
as double,bottomWidthMm: null == bottomWidthMm ? _self.bottomWidthMm : bottomWidthMm // ignore: cast_nullable_to_non_nullable
as double,frontBackLengthMm: null == frontBackLengthMm ? _self.frontBackLengthMm : frontBackLengthMm // ignore: cast_nullable_to_non_nullable
as double,frontBackHeightMm: null == frontBackHeightMm ? _self.frontBackHeightMm : frontBackHeightMm // ignore: cast_nullable_to_non_nullable
as double,sideWidthMm: null == sideWidthMm ? _self.sideWidthMm : sideWidthMm // ignore: cast_nullable_to_non_nullable
as double,sideHeightMm: null == sideHeightMm ? _self.sideHeightMm : sideHeightMm // ignore: cast_nullable_to_non_nullable
as double,totalGlassAreaSqM: null == totalGlassAreaSqM ? _self.totalGlassAreaSqM : totalGlassAreaSqM // ignore: cast_nullable_to_non_nullable
as double,estimatedWeightKg: null == estimatedWeightKg ? _self.estimatedWeightKg : estimatedWeightKg // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GlassCalculationEntity].
extension GlassCalculationEntityPatterns on GlassCalculationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlassCalculationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlassCalculationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlassCalculationEntity value)  $default,){
final _that = this;
switch (_that) {
case _GlassCalculationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlassCalculationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GlassCalculationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  double lengthMm,  double widthMm,  double heightMm,  double glassThicknessMm,  double glueThicknessMm,  double volumeLiters,  double bottomLengthMm,  double bottomWidthMm,  double frontBackLengthMm,  double frontBackHeightMm,  double sideWidthMm,  double sideHeightMm,  double totalGlassAreaSqM,  double estimatedWeightKg,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlassCalculationEntity() when $default != null:
return $default(_that.id,_that.name,_that.lengthMm,_that.widthMm,_that.heightMm,_that.glassThicknessMm,_that.glueThicknessMm,_that.volumeLiters,_that.bottomLengthMm,_that.bottomWidthMm,_that.frontBackLengthMm,_that.frontBackHeightMm,_that.sideWidthMm,_that.sideHeightMm,_that.totalGlassAreaSqM,_that.estimatedWeightKg,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  double lengthMm,  double widthMm,  double heightMm,  double glassThicknessMm,  double glueThicknessMm,  double volumeLiters,  double bottomLengthMm,  double bottomWidthMm,  double frontBackLengthMm,  double frontBackHeightMm,  double sideWidthMm,  double sideHeightMm,  double totalGlassAreaSqM,  double estimatedWeightKg,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _GlassCalculationEntity():
return $default(_that.id,_that.name,_that.lengthMm,_that.widthMm,_that.heightMm,_that.glassThicknessMm,_that.glueThicknessMm,_that.volumeLiters,_that.bottomLengthMm,_that.bottomWidthMm,_that.frontBackLengthMm,_that.frontBackHeightMm,_that.sideWidthMm,_that.sideHeightMm,_that.totalGlassAreaSqM,_that.estimatedWeightKg,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  double lengthMm,  double widthMm,  double heightMm,  double glassThicknessMm,  double glueThicknessMm,  double volumeLiters,  double bottomLengthMm,  double bottomWidthMm,  double frontBackLengthMm,  double frontBackHeightMm,  double sideWidthMm,  double sideHeightMm,  double totalGlassAreaSqM,  double estimatedWeightKg,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GlassCalculationEntity() when $default != null:
return $default(_that.id,_that.name,_that.lengthMm,_that.widthMm,_that.heightMm,_that.glassThicknessMm,_that.glueThicknessMm,_that.volumeLiters,_that.bottomLengthMm,_that.bottomWidthMm,_that.frontBackLengthMm,_that.frontBackHeightMm,_that.sideWidthMm,_that.sideHeightMm,_that.totalGlassAreaSqM,_that.estimatedWeightKg,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _GlassCalculationEntity extends GlassCalculationEntity {
  const _GlassCalculationEntity({this.id, required this.name, required this.lengthMm, required this.widthMm, required this.heightMm, required this.glassThicknessMm, this.glueThicknessMm = 1.0, required this.volumeLiters, required this.bottomLengthMm, required this.bottomWidthMm, required this.frontBackLengthMm, required this.frontBackHeightMm, required this.sideWidthMm, required this.sideHeightMm, required this.totalGlassAreaSqM, required this.estimatedWeightKg, this.notes, this.createdAt}): super._();
  

/// Unique identifier (null for new calculations)
@override final  int? id;
/// Name/label for this calculation
@override final  String name;
/// Tank length in mm
@override final  double lengthMm;
/// Tank width in mm
@override final  double widthMm;
/// Tank height in mm
@override final  double heightMm;
/// Glass thickness in mm
@override final  double glassThicknessMm;
/// Glue/silicone thickness in mm (default 1mm)
@override@JsonKey() final  double glueThicknessMm;
/// Calculated volume in liters
@override final  double volumeLiters;
/// Bottom glass length in mm
@override final  double bottomLengthMm;
/// Bottom glass width in mm
@override final  double bottomWidthMm;
/// Front/back glass length in mm
@override final  double frontBackLengthMm;
/// Front/back glass height in mm
@override final  double frontBackHeightMm;
/// Side glass width in mm
@override final  double sideWidthMm;
/// Side glass height in mm
@override final  double sideHeightMm;
/// Total glass area in square meters
@override final  double totalGlassAreaSqM;
/// Estimated glass weight in kg
@override final  double estimatedWeightKg;
/// Notes
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;

/// Create a copy of GlassCalculationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlassCalculationEntityCopyWith<_GlassCalculationEntity> get copyWith => __$GlassCalculationEntityCopyWithImpl<_GlassCalculationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlassCalculationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lengthMm, lengthMm) || other.lengthMm == lengthMm)&&(identical(other.widthMm, widthMm) || other.widthMm == widthMm)&&(identical(other.heightMm, heightMm) || other.heightMm == heightMm)&&(identical(other.glassThicknessMm, glassThicknessMm) || other.glassThicknessMm == glassThicknessMm)&&(identical(other.glueThicknessMm, glueThicknessMm) || other.glueThicknessMm == glueThicknessMm)&&(identical(other.volumeLiters, volumeLiters) || other.volumeLiters == volumeLiters)&&(identical(other.bottomLengthMm, bottomLengthMm) || other.bottomLengthMm == bottomLengthMm)&&(identical(other.bottomWidthMm, bottomWidthMm) || other.bottomWidthMm == bottomWidthMm)&&(identical(other.frontBackLengthMm, frontBackLengthMm) || other.frontBackLengthMm == frontBackLengthMm)&&(identical(other.frontBackHeightMm, frontBackHeightMm) || other.frontBackHeightMm == frontBackHeightMm)&&(identical(other.sideWidthMm, sideWidthMm) || other.sideWidthMm == sideWidthMm)&&(identical(other.sideHeightMm, sideHeightMm) || other.sideHeightMm == sideHeightMm)&&(identical(other.totalGlassAreaSqM, totalGlassAreaSqM) || other.totalGlassAreaSqM == totalGlassAreaSqM)&&(identical(other.estimatedWeightKg, estimatedWeightKg) || other.estimatedWeightKg == estimatedWeightKg)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,lengthMm,widthMm,heightMm,glassThicknessMm,glueThicknessMm,volumeLiters,bottomLengthMm,bottomWidthMm,frontBackLengthMm,frontBackHeightMm,sideWidthMm,sideHeightMm,totalGlassAreaSqM,estimatedWeightKg,notes,createdAt);

@override
String toString() {
  return 'GlassCalculationEntity(id: $id, name: $name, lengthMm: $lengthMm, widthMm: $widthMm, heightMm: $heightMm, glassThicknessMm: $glassThicknessMm, glueThicknessMm: $glueThicknessMm, volumeLiters: $volumeLiters, bottomLengthMm: $bottomLengthMm, bottomWidthMm: $bottomWidthMm, frontBackLengthMm: $frontBackLengthMm, frontBackHeightMm: $frontBackHeightMm, sideWidthMm: $sideWidthMm, sideHeightMm: $sideHeightMm, totalGlassAreaSqM: $totalGlassAreaSqM, estimatedWeightKg: $estimatedWeightKg, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GlassCalculationEntityCopyWith<$Res> implements $GlassCalculationEntityCopyWith<$Res> {
  factory _$GlassCalculationEntityCopyWith(_GlassCalculationEntity value, $Res Function(_GlassCalculationEntity) _then) = __$GlassCalculationEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, double lengthMm, double widthMm, double heightMm, double glassThicknessMm, double glueThicknessMm, double volumeLiters, double bottomLengthMm, double bottomWidthMm, double frontBackLengthMm, double frontBackHeightMm, double sideWidthMm, double sideHeightMm, double totalGlassAreaSqM, double estimatedWeightKg, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$GlassCalculationEntityCopyWithImpl<$Res>
    implements _$GlassCalculationEntityCopyWith<$Res> {
  __$GlassCalculationEntityCopyWithImpl(this._self, this._then);

  final _GlassCalculationEntity _self;
  final $Res Function(_GlassCalculationEntity) _then;

/// Create a copy of GlassCalculationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? lengthMm = null,Object? widthMm = null,Object? heightMm = null,Object? glassThicknessMm = null,Object? glueThicknessMm = null,Object? volumeLiters = null,Object? bottomLengthMm = null,Object? bottomWidthMm = null,Object? frontBackLengthMm = null,Object? frontBackHeightMm = null,Object? sideWidthMm = null,Object? sideHeightMm = null,Object? totalGlassAreaSqM = null,Object? estimatedWeightKg = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_GlassCalculationEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lengthMm: null == lengthMm ? _self.lengthMm : lengthMm // ignore: cast_nullable_to_non_nullable
as double,widthMm: null == widthMm ? _self.widthMm : widthMm // ignore: cast_nullable_to_non_nullable
as double,heightMm: null == heightMm ? _self.heightMm : heightMm // ignore: cast_nullable_to_non_nullable
as double,glassThicknessMm: null == glassThicknessMm ? _self.glassThicknessMm : glassThicknessMm // ignore: cast_nullable_to_non_nullable
as double,glueThicknessMm: null == glueThicknessMm ? _self.glueThicknessMm : glueThicknessMm // ignore: cast_nullable_to_non_nullable
as double,volumeLiters: null == volumeLiters ? _self.volumeLiters : volumeLiters // ignore: cast_nullable_to_non_nullable
as double,bottomLengthMm: null == bottomLengthMm ? _self.bottomLengthMm : bottomLengthMm // ignore: cast_nullable_to_non_nullable
as double,bottomWidthMm: null == bottomWidthMm ? _self.bottomWidthMm : bottomWidthMm // ignore: cast_nullable_to_non_nullable
as double,frontBackLengthMm: null == frontBackLengthMm ? _self.frontBackLengthMm : frontBackLengthMm // ignore: cast_nullable_to_non_nullable
as double,frontBackHeightMm: null == frontBackHeightMm ? _self.frontBackHeightMm : frontBackHeightMm // ignore: cast_nullable_to_non_nullable
as double,sideWidthMm: null == sideWidthMm ? _self.sideWidthMm : sideWidthMm // ignore: cast_nullable_to_non_nullable
as double,sideHeightMm: null == sideHeightMm ? _self.sideHeightMm : sideHeightMm // ignore: cast_nullable_to_non_nullable
as double,totalGlassAreaSqM: null == totalGlassAreaSqM ? _self.totalGlassAreaSqM : totalGlassAreaSqM // ignore: cast_nullable_to_non_nullable
as double,estimatedWeightKg: null == estimatedWeightKg ? _self.estimatedWeightKg : estimatedWeightKg // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
