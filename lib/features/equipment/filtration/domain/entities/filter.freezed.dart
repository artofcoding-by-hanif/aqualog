// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilterEntity {

/// Unique identifier (null for new filters)
 int? get id;/// Foreign key to tank
 int get tankId;/// Filter name/label
 String get name;/// Filter type
 FilterType get filterType;/// Brand name
 String? get brand;/// Model number/name
 String? get model;/// Flow rate in liters per hour
 double? get flowRateLph;/// Media volume capacity in liters
 double? get mediaVolumeLiters;/// Last cleaned date
 DateTime? get lastCleanedAt;/// Last media replacement date
 DateTime? get mediaReplacedAt;/// Recommended cleaning interval in days
 int get cleaningIntervalDays;/// Recommended media replacement interval in days
 int get mediaReplacementIntervalDays;/// Notes/additional info
 String? get notes;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of FilterEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterEntityCopyWith<FilterEntity> get copyWith => _$FilterEntityCopyWithImpl<FilterEntity>(this as FilterEntity, _$identity);

  /// Serializes this FilterEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.flowRateLph, flowRateLph) || other.flowRateLph == flowRateLph)&&(identical(other.mediaVolumeLiters, mediaVolumeLiters) || other.mediaVolumeLiters == mediaVolumeLiters)&&(identical(other.lastCleanedAt, lastCleanedAt) || other.lastCleanedAt == lastCleanedAt)&&(identical(other.mediaReplacedAt, mediaReplacedAt) || other.mediaReplacedAt == mediaReplacedAt)&&(identical(other.cleaningIntervalDays, cleaningIntervalDays) || other.cleaningIntervalDays == cleaningIntervalDays)&&(identical(other.mediaReplacementIntervalDays, mediaReplacementIntervalDays) || other.mediaReplacementIntervalDays == mediaReplacementIntervalDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,filterType,brand,model,flowRateLph,mediaVolumeLiters,lastCleanedAt,mediaReplacedAt,cleaningIntervalDays,mediaReplacementIntervalDays,notes,createdAt,updatedAt);

@override
String toString() {
  return 'FilterEntity(id: $id, tankId: $tankId, name: $name, filterType: $filterType, brand: $brand, model: $model, flowRateLph: $flowRateLph, mediaVolumeLiters: $mediaVolumeLiters, lastCleanedAt: $lastCleanedAt, mediaReplacedAt: $mediaReplacedAt, cleaningIntervalDays: $cleaningIntervalDays, mediaReplacementIntervalDays: $mediaReplacementIntervalDays, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FilterEntityCopyWith<$Res>  {
  factory $FilterEntityCopyWith(FilterEntity value, $Res Function(FilterEntity) _then) = _$FilterEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String name, FilterType filterType, String? brand, String? model, double? flowRateLph, double? mediaVolumeLiters, DateTime? lastCleanedAt, DateTime? mediaReplacedAt, int cleaningIntervalDays, int mediaReplacementIntervalDays, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$FilterEntityCopyWithImpl<$Res>
    implements $FilterEntityCopyWith<$Res> {
  _$FilterEntityCopyWithImpl(this._self, this._then);

  final FilterEntity _self;
  final $Res Function(FilterEntity) _then;

/// Create a copy of FilterEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? filterType = null,Object? brand = freezed,Object? model = freezed,Object? flowRateLph = freezed,Object? mediaVolumeLiters = freezed,Object? lastCleanedAt = freezed,Object? mediaReplacedAt = freezed,Object? cleaningIntervalDays = null,Object? mediaReplacementIntervalDays = null,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as FilterType,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,flowRateLph: freezed == flowRateLph ? _self.flowRateLph : flowRateLph // ignore: cast_nullable_to_non_nullable
as double?,mediaVolumeLiters: freezed == mediaVolumeLiters ? _self.mediaVolumeLiters : mediaVolumeLiters // ignore: cast_nullable_to_non_nullable
as double?,lastCleanedAt: freezed == lastCleanedAt ? _self.lastCleanedAt : lastCleanedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mediaReplacedAt: freezed == mediaReplacedAt ? _self.mediaReplacedAt : mediaReplacedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cleaningIntervalDays: null == cleaningIntervalDays ? _self.cleaningIntervalDays : cleaningIntervalDays // ignore: cast_nullable_to_non_nullable
as int,mediaReplacementIntervalDays: null == mediaReplacementIntervalDays ? _self.mediaReplacementIntervalDays : mediaReplacementIntervalDays // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FilterEntity].
extension FilterEntityPatterns on FilterEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilterEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilterEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilterEntity value)  $default,){
final _that = this;
switch (_that) {
case _FilterEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilterEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FilterEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  FilterType filterType,  String? brand,  String? model,  double? flowRateLph,  double? mediaVolumeLiters,  DateTime? lastCleanedAt,  DateTime? mediaReplacedAt,  int cleaningIntervalDays,  int mediaReplacementIntervalDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilterEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.filterType,_that.brand,_that.model,_that.flowRateLph,_that.mediaVolumeLiters,_that.lastCleanedAt,_that.mediaReplacedAt,_that.cleaningIntervalDays,_that.mediaReplacementIntervalDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  FilterType filterType,  String? brand,  String? model,  double? flowRateLph,  double? mediaVolumeLiters,  DateTime? lastCleanedAt,  DateTime? mediaReplacedAt,  int cleaningIntervalDays,  int mediaReplacementIntervalDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FilterEntity():
return $default(_that.id,_that.tankId,_that.name,_that.filterType,_that.brand,_that.model,_that.flowRateLph,_that.mediaVolumeLiters,_that.lastCleanedAt,_that.mediaReplacedAt,_that.cleaningIntervalDays,_that.mediaReplacementIntervalDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String name,  FilterType filterType,  String? brand,  String? model,  double? flowRateLph,  double? mediaVolumeLiters,  DateTime? lastCleanedAt,  DateTime? mediaReplacedAt,  int cleaningIntervalDays,  int mediaReplacementIntervalDays,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FilterEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.filterType,_that.brand,_that.model,_that.flowRateLph,_that.mediaVolumeLiters,_that.lastCleanedAt,_that.mediaReplacedAt,_that.cleaningIntervalDays,_that.mediaReplacementIntervalDays,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilterEntity extends FilterEntity {
  const _FilterEntity({this.id, required this.tankId, required this.name, required this.filterType, this.brand, this.model, this.flowRateLph, this.mediaVolumeLiters, this.lastCleanedAt, this.mediaReplacedAt, this.cleaningIntervalDays = 14, this.mediaReplacementIntervalDays = 90, this.notes, this.createdAt, this.updatedAt}): super._();
  factory _FilterEntity.fromJson(Map<String, dynamic> json) => _$FilterEntityFromJson(json);

/// Unique identifier (null for new filters)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Filter name/label
@override final  String name;
/// Filter type
@override final  FilterType filterType;
/// Brand name
@override final  String? brand;
/// Model number/name
@override final  String? model;
/// Flow rate in liters per hour
@override final  double? flowRateLph;
/// Media volume capacity in liters
@override final  double? mediaVolumeLiters;
/// Last cleaned date
@override final  DateTime? lastCleanedAt;
/// Last media replacement date
@override final  DateTime? mediaReplacedAt;
/// Recommended cleaning interval in days
@override@JsonKey() final  int cleaningIntervalDays;
/// Recommended media replacement interval in days
@override@JsonKey() final  int mediaReplacementIntervalDays;
/// Notes/additional info
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of FilterEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterEntityCopyWith<_FilterEntity> get copyWith => __$FilterEntityCopyWithImpl<_FilterEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilterEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.flowRateLph, flowRateLph) || other.flowRateLph == flowRateLph)&&(identical(other.mediaVolumeLiters, mediaVolumeLiters) || other.mediaVolumeLiters == mediaVolumeLiters)&&(identical(other.lastCleanedAt, lastCleanedAt) || other.lastCleanedAt == lastCleanedAt)&&(identical(other.mediaReplacedAt, mediaReplacedAt) || other.mediaReplacedAt == mediaReplacedAt)&&(identical(other.cleaningIntervalDays, cleaningIntervalDays) || other.cleaningIntervalDays == cleaningIntervalDays)&&(identical(other.mediaReplacementIntervalDays, mediaReplacementIntervalDays) || other.mediaReplacementIntervalDays == mediaReplacementIntervalDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,filterType,brand,model,flowRateLph,mediaVolumeLiters,lastCleanedAt,mediaReplacedAt,cleaningIntervalDays,mediaReplacementIntervalDays,notes,createdAt,updatedAt);

@override
String toString() {
  return 'FilterEntity(id: $id, tankId: $tankId, name: $name, filterType: $filterType, brand: $brand, model: $model, flowRateLph: $flowRateLph, mediaVolumeLiters: $mediaVolumeLiters, lastCleanedAt: $lastCleanedAt, mediaReplacedAt: $mediaReplacedAt, cleaningIntervalDays: $cleaningIntervalDays, mediaReplacementIntervalDays: $mediaReplacementIntervalDays, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FilterEntityCopyWith<$Res> implements $FilterEntityCopyWith<$Res> {
  factory _$FilterEntityCopyWith(_FilterEntity value, $Res Function(_FilterEntity) _then) = __$FilterEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String name, FilterType filterType, String? brand, String? model, double? flowRateLph, double? mediaVolumeLiters, DateTime? lastCleanedAt, DateTime? mediaReplacedAt, int cleaningIntervalDays, int mediaReplacementIntervalDays, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$FilterEntityCopyWithImpl<$Res>
    implements _$FilterEntityCopyWith<$Res> {
  __$FilterEntityCopyWithImpl(this._self, this._then);

  final _FilterEntity _self;
  final $Res Function(_FilterEntity) _then;

/// Create a copy of FilterEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? filterType = null,Object? brand = freezed,Object? model = freezed,Object? flowRateLph = freezed,Object? mediaVolumeLiters = freezed,Object? lastCleanedAt = freezed,Object? mediaReplacedAt = freezed,Object? cleaningIntervalDays = null,Object? mediaReplacementIntervalDays = null,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_FilterEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as FilterType,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,flowRateLph: freezed == flowRateLph ? _self.flowRateLph : flowRateLph // ignore: cast_nullable_to_non_nullable
as double?,mediaVolumeLiters: freezed == mediaVolumeLiters ? _self.mediaVolumeLiters : mediaVolumeLiters // ignore: cast_nullable_to_non_nullable
as double?,lastCleanedAt: freezed == lastCleanedAt ? _self.lastCleanedAt : lastCleanedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mediaReplacedAt: freezed == mediaReplacedAt ? _self.mediaReplacedAt : mediaReplacedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cleaningIntervalDays: null == cleaningIntervalDays ? _self.cleaningIntervalDays : cleaningIntervalDays // ignore: cast_nullable_to_non_nullable
as int,mediaReplacementIntervalDays: null == mediaReplacementIntervalDays ? _self.mediaReplacementIntervalDays : mediaReplacementIntervalDays // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
