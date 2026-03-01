// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maintenance_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MaintenanceLogEntity {

/// Unique identifier (null for new logs)
 int? get id;/// Foreign key to tank
 int get tankId;/// Type of maintenance performed
 MaintenanceType get maintenanceType;/// Title/summary of the maintenance
 String get title;/// Detailed notes
 String? get notes;/// For water changes: percentage of water changed
 double? get waterChangePercent;/// For water changes: liters of water changed
 double? get waterChangeLiters;/// When the maintenance was performed
 DateTime get performedAt;/// Duration of the maintenance in minutes
 int? get durationMinutes;/// Created timestamp
 DateTime? get createdAt;
/// Create a copy of MaintenanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceLogEntityCopyWith<MaintenanceLogEntity> get copyWith => _$MaintenanceLogEntityCopyWithImpl<MaintenanceLogEntity>(this as MaintenanceLogEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceLogEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.maintenanceType, maintenanceType) || other.maintenanceType == maintenanceType)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.waterChangePercent, waterChangePercent) || other.waterChangePercent == waterChangePercent)&&(identical(other.waterChangeLiters, waterChangeLiters) || other.waterChangeLiters == waterChangeLiters)&&(identical(other.performedAt, performedAt) || other.performedAt == performedAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tankId,maintenanceType,title,notes,waterChangePercent,waterChangeLiters,performedAt,durationMinutes,createdAt);

@override
String toString() {
  return 'MaintenanceLogEntity(id: $id, tankId: $tankId, maintenanceType: $maintenanceType, title: $title, notes: $notes, waterChangePercent: $waterChangePercent, waterChangeLiters: $waterChangeLiters, performedAt: $performedAt, durationMinutes: $durationMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MaintenanceLogEntityCopyWith<$Res>  {
  factory $MaintenanceLogEntityCopyWith(MaintenanceLogEntity value, $Res Function(MaintenanceLogEntity) _then) = _$MaintenanceLogEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, MaintenanceType maintenanceType, String title, String? notes, double? waterChangePercent, double? waterChangeLiters, DateTime performedAt, int? durationMinutes, DateTime? createdAt
});




}
/// @nodoc
class _$MaintenanceLogEntityCopyWithImpl<$Res>
    implements $MaintenanceLogEntityCopyWith<$Res> {
  _$MaintenanceLogEntityCopyWithImpl(this._self, this._then);

  final MaintenanceLogEntity _self;
  final $Res Function(MaintenanceLogEntity) _then;

/// Create a copy of MaintenanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? maintenanceType = null,Object? title = null,Object? notes = freezed,Object? waterChangePercent = freezed,Object? waterChangeLiters = freezed,Object? performedAt = null,Object? durationMinutes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,maintenanceType: null == maintenanceType ? _self.maintenanceType : maintenanceType // ignore: cast_nullable_to_non_nullable
as MaintenanceType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,waterChangePercent: freezed == waterChangePercent ? _self.waterChangePercent : waterChangePercent // ignore: cast_nullable_to_non_nullable
as double?,waterChangeLiters: freezed == waterChangeLiters ? _self.waterChangeLiters : waterChangeLiters // ignore: cast_nullable_to_non_nullable
as double?,performedAt: null == performedAt ? _self.performedAt : performedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaintenanceLogEntity].
extension MaintenanceLogEntityPatterns on MaintenanceLogEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceLogEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceLogEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceLogEntity value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceLogEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceLogEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceLogEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  MaintenanceType maintenanceType,  String title,  String? notes,  double? waterChangePercent,  double? waterChangeLiters,  DateTime performedAt,  int? durationMinutes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceLogEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.maintenanceType,_that.title,_that.notes,_that.waterChangePercent,_that.waterChangeLiters,_that.performedAt,_that.durationMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  MaintenanceType maintenanceType,  String title,  String? notes,  double? waterChangePercent,  double? waterChangeLiters,  DateTime performedAt,  int? durationMinutes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceLogEntity():
return $default(_that.id,_that.tankId,_that.maintenanceType,_that.title,_that.notes,_that.waterChangePercent,_that.waterChangeLiters,_that.performedAt,_that.durationMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  MaintenanceType maintenanceType,  String title,  String? notes,  double? waterChangePercent,  double? waterChangeLiters,  DateTime performedAt,  int? durationMinutes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceLogEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.maintenanceType,_that.title,_that.notes,_that.waterChangePercent,_that.waterChangeLiters,_that.performedAt,_that.durationMinutes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _MaintenanceLogEntity extends MaintenanceLogEntity {
  const _MaintenanceLogEntity({this.id, required this.tankId, required this.maintenanceType, required this.title, this.notes, this.waterChangePercent, this.waterChangeLiters, required this.performedAt, this.durationMinutes, this.createdAt}): super._();
  

/// Unique identifier (null for new logs)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Type of maintenance performed
@override final  MaintenanceType maintenanceType;
/// Title/summary of the maintenance
@override final  String title;
/// Detailed notes
@override final  String? notes;
/// For water changes: percentage of water changed
@override final  double? waterChangePercent;
/// For water changes: liters of water changed
@override final  double? waterChangeLiters;
/// When the maintenance was performed
@override final  DateTime performedAt;
/// Duration of the maintenance in minutes
@override final  int? durationMinutes;
/// Created timestamp
@override final  DateTime? createdAt;

/// Create a copy of MaintenanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceLogEntityCopyWith<_MaintenanceLogEntity> get copyWith => __$MaintenanceLogEntityCopyWithImpl<_MaintenanceLogEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceLogEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.maintenanceType, maintenanceType) || other.maintenanceType == maintenanceType)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.waterChangePercent, waterChangePercent) || other.waterChangePercent == waterChangePercent)&&(identical(other.waterChangeLiters, waterChangeLiters) || other.waterChangeLiters == waterChangeLiters)&&(identical(other.performedAt, performedAt) || other.performedAt == performedAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tankId,maintenanceType,title,notes,waterChangePercent,waterChangeLiters,performedAt,durationMinutes,createdAt);

@override
String toString() {
  return 'MaintenanceLogEntity(id: $id, tankId: $tankId, maintenanceType: $maintenanceType, title: $title, notes: $notes, waterChangePercent: $waterChangePercent, waterChangeLiters: $waterChangeLiters, performedAt: $performedAt, durationMinutes: $durationMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceLogEntityCopyWith<$Res> implements $MaintenanceLogEntityCopyWith<$Res> {
  factory _$MaintenanceLogEntityCopyWith(_MaintenanceLogEntity value, $Res Function(_MaintenanceLogEntity) _then) = __$MaintenanceLogEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, MaintenanceType maintenanceType, String title, String? notes, double? waterChangePercent, double? waterChangeLiters, DateTime performedAt, int? durationMinutes, DateTime? createdAt
});




}
/// @nodoc
class __$MaintenanceLogEntityCopyWithImpl<$Res>
    implements _$MaintenanceLogEntityCopyWith<$Res> {
  __$MaintenanceLogEntityCopyWithImpl(this._self, this._then);

  final _MaintenanceLogEntity _self;
  final $Res Function(_MaintenanceLogEntity) _then;

/// Create a copy of MaintenanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? maintenanceType = null,Object? title = null,Object? notes = freezed,Object? waterChangePercent = freezed,Object? waterChangeLiters = freezed,Object? performedAt = null,Object? durationMinutes = freezed,Object? createdAt = freezed,}) {
  return _then(_MaintenanceLogEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,maintenanceType: null == maintenanceType ? _self.maintenanceType : maintenanceType // ignore: cast_nullable_to_non_nullable
as MaintenanceType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,waterChangePercent: freezed == waterChangePercent ? _self.waterChangePercent : waterChangePercent // ignore: cast_nullable_to_non_nullable
as double?,waterChangeLiters: freezed == waterChangeLiters ? _self.waterChangeLiters : waterChangeLiters // ignore: cast_nullable_to_non_nullable
as double?,performedAt: null == performedAt ? _self.performedAt : performedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
