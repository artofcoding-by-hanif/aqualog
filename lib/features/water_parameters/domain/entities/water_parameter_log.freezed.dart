// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_parameter_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WaterParameterLogEntity {

/// Unique identifier (null for new logs)
 int? get id;/// Foreign key to tank
 int get tankId;/// When the measurement was taken
 DateTime get measuredAt;// ============================================================
// Core Parameters (most commonly tested)
// ============================================================
/// Temperature in Celsius
 double? get temperatureCelsius;/// pH level (0-14)
 double? get ph;/// Ammonia in ppm (NH3/NH4+)
 double? get ammoniaPpm;/// Nitrite in ppm (NO2)
 double? get nitritePpm;/// Nitrate in ppm (NO3)
 double? get nitratePpm;// ============================================================
// Hardness Parameters
// ============================================================
/// General Hardness (GH) in dGH
 double? get ghDgh;/// Carbonate Hardness (KH) in dKH
 double? get khDkh;// ============================================================
// Additional Freshwater Parameters
// ============================================================
/// Phosphate in ppm (PO4)
 double? get phosphatePpm;/// Dissolved oxygen in mg/L
 double? get oxygenMgL;/// Carbon dioxide in mg/L
 double? get co2MgL;/// TDS (Total Dissolved Solids) in ppm
 double? get tdsPpm;/// Chlorine in ppm
 double? get chlorinePpm;/// Iron in ppm (for planted tanks)
 double? get ironPpm;/// Copper in ppm
 double? get copperPpm;// ============================================================
// Saltwater/Reef Parameters
// ============================================================
/// Salinity in ppt (for saltwater)
 double? get salinityPpt;/// Calcium in ppm (for reef tanks)
 double? get calciumPpm;/// Magnesium in ppm (for reef tanks)
 double? get magnesiumPpm;/// Alkalinity in dKH (for reef tanks)
 double? get alkalinityDkh;// ============================================================
// Metadata
// ============================================================
/// Notes for this reading
 String? get notes;/// Created timestamp
 DateTime? get createdAt;
/// Create a copy of WaterParameterLogEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaterParameterLogEntityCopyWith<WaterParameterLogEntity> get copyWith => _$WaterParameterLogEntityCopyWithImpl<WaterParameterLogEntity>(this as WaterParameterLogEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaterParameterLogEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.measuredAt, measuredAt) || other.measuredAt == measuredAt)&&(identical(other.temperatureCelsius, temperatureCelsius) || other.temperatureCelsius == temperatureCelsius)&&(identical(other.ph, ph) || other.ph == ph)&&(identical(other.ammoniaPpm, ammoniaPpm) || other.ammoniaPpm == ammoniaPpm)&&(identical(other.nitritePpm, nitritePpm) || other.nitritePpm == nitritePpm)&&(identical(other.nitratePpm, nitratePpm) || other.nitratePpm == nitratePpm)&&(identical(other.ghDgh, ghDgh) || other.ghDgh == ghDgh)&&(identical(other.khDkh, khDkh) || other.khDkh == khDkh)&&(identical(other.phosphatePpm, phosphatePpm) || other.phosphatePpm == phosphatePpm)&&(identical(other.oxygenMgL, oxygenMgL) || other.oxygenMgL == oxygenMgL)&&(identical(other.co2MgL, co2MgL) || other.co2MgL == co2MgL)&&(identical(other.tdsPpm, tdsPpm) || other.tdsPpm == tdsPpm)&&(identical(other.chlorinePpm, chlorinePpm) || other.chlorinePpm == chlorinePpm)&&(identical(other.ironPpm, ironPpm) || other.ironPpm == ironPpm)&&(identical(other.copperPpm, copperPpm) || other.copperPpm == copperPpm)&&(identical(other.salinityPpt, salinityPpt) || other.salinityPpt == salinityPpt)&&(identical(other.calciumPpm, calciumPpm) || other.calciumPpm == calciumPpm)&&(identical(other.magnesiumPpm, magnesiumPpm) || other.magnesiumPpm == magnesiumPpm)&&(identical(other.alkalinityDkh, alkalinityDkh) || other.alkalinityDkh == alkalinityDkh)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,measuredAt,temperatureCelsius,ph,ammoniaPpm,nitritePpm,nitratePpm,ghDgh,khDkh,phosphatePpm,oxygenMgL,co2MgL,tdsPpm,chlorinePpm,ironPpm,copperPpm,salinityPpt,calciumPpm,magnesiumPpm,alkalinityDkh,notes,createdAt]);

@override
String toString() {
  return 'WaterParameterLogEntity(id: $id, tankId: $tankId, measuredAt: $measuredAt, temperatureCelsius: $temperatureCelsius, ph: $ph, ammoniaPpm: $ammoniaPpm, nitritePpm: $nitritePpm, nitratePpm: $nitratePpm, ghDgh: $ghDgh, khDkh: $khDkh, phosphatePpm: $phosphatePpm, oxygenMgL: $oxygenMgL, co2MgL: $co2MgL, tdsPpm: $tdsPpm, chlorinePpm: $chlorinePpm, ironPpm: $ironPpm, copperPpm: $copperPpm, salinityPpt: $salinityPpt, calciumPpm: $calciumPpm, magnesiumPpm: $magnesiumPpm, alkalinityDkh: $alkalinityDkh, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WaterParameterLogEntityCopyWith<$Res>  {
  factory $WaterParameterLogEntityCopyWith(WaterParameterLogEntity value, $Res Function(WaterParameterLogEntity) _then) = _$WaterParameterLogEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, DateTime measuredAt, double? temperatureCelsius, double? ph, double? ammoniaPpm, double? nitritePpm, double? nitratePpm, double? ghDgh, double? khDkh, double? phosphatePpm, double? oxygenMgL, double? co2MgL, double? tdsPpm, double? chlorinePpm, double? ironPpm, double? copperPpm, double? salinityPpt, double? calciumPpm, double? magnesiumPpm, double? alkalinityDkh, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$WaterParameterLogEntityCopyWithImpl<$Res>
    implements $WaterParameterLogEntityCopyWith<$Res> {
  _$WaterParameterLogEntityCopyWithImpl(this._self, this._then);

  final WaterParameterLogEntity _self;
  final $Res Function(WaterParameterLogEntity) _then;

/// Create a copy of WaterParameterLogEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? measuredAt = null,Object? temperatureCelsius = freezed,Object? ph = freezed,Object? ammoniaPpm = freezed,Object? nitritePpm = freezed,Object? nitratePpm = freezed,Object? ghDgh = freezed,Object? khDkh = freezed,Object? phosphatePpm = freezed,Object? oxygenMgL = freezed,Object? co2MgL = freezed,Object? tdsPpm = freezed,Object? chlorinePpm = freezed,Object? ironPpm = freezed,Object? copperPpm = freezed,Object? salinityPpt = freezed,Object? calciumPpm = freezed,Object? magnesiumPpm = freezed,Object? alkalinityDkh = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,measuredAt: null == measuredAt ? _self.measuredAt : measuredAt // ignore: cast_nullable_to_non_nullable
as DateTime,temperatureCelsius: freezed == temperatureCelsius ? _self.temperatureCelsius : temperatureCelsius // ignore: cast_nullable_to_non_nullable
as double?,ph: freezed == ph ? _self.ph : ph // ignore: cast_nullable_to_non_nullable
as double?,ammoniaPpm: freezed == ammoniaPpm ? _self.ammoniaPpm : ammoniaPpm // ignore: cast_nullable_to_non_nullable
as double?,nitritePpm: freezed == nitritePpm ? _self.nitritePpm : nitritePpm // ignore: cast_nullable_to_non_nullable
as double?,nitratePpm: freezed == nitratePpm ? _self.nitratePpm : nitratePpm // ignore: cast_nullable_to_non_nullable
as double?,ghDgh: freezed == ghDgh ? _self.ghDgh : ghDgh // ignore: cast_nullable_to_non_nullable
as double?,khDkh: freezed == khDkh ? _self.khDkh : khDkh // ignore: cast_nullable_to_non_nullable
as double?,phosphatePpm: freezed == phosphatePpm ? _self.phosphatePpm : phosphatePpm // ignore: cast_nullable_to_non_nullable
as double?,oxygenMgL: freezed == oxygenMgL ? _self.oxygenMgL : oxygenMgL // ignore: cast_nullable_to_non_nullable
as double?,co2MgL: freezed == co2MgL ? _self.co2MgL : co2MgL // ignore: cast_nullable_to_non_nullable
as double?,tdsPpm: freezed == tdsPpm ? _self.tdsPpm : tdsPpm // ignore: cast_nullable_to_non_nullable
as double?,chlorinePpm: freezed == chlorinePpm ? _self.chlorinePpm : chlorinePpm // ignore: cast_nullable_to_non_nullable
as double?,ironPpm: freezed == ironPpm ? _self.ironPpm : ironPpm // ignore: cast_nullable_to_non_nullable
as double?,copperPpm: freezed == copperPpm ? _self.copperPpm : copperPpm // ignore: cast_nullable_to_non_nullable
as double?,salinityPpt: freezed == salinityPpt ? _self.salinityPpt : salinityPpt // ignore: cast_nullable_to_non_nullable
as double?,calciumPpm: freezed == calciumPpm ? _self.calciumPpm : calciumPpm // ignore: cast_nullable_to_non_nullable
as double?,magnesiumPpm: freezed == magnesiumPpm ? _self.magnesiumPpm : magnesiumPpm // ignore: cast_nullable_to_non_nullable
as double?,alkalinityDkh: freezed == alkalinityDkh ? _self.alkalinityDkh : alkalinityDkh // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaterParameterLogEntity].
extension WaterParameterLogEntityPatterns on WaterParameterLogEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaterParameterLogEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaterParameterLogEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaterParameterLogEntity value)  $default,){
final _that = this;
switch (_that) {
case _WaterParameterLogEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaterParameterLogEntity value)?  $default,){
final _that = this;
switch (_that) {
case _WaterParameterLogEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  DateTime measuredAt,  double? temperatureCelsius,  double? ph,  double? ammoniaPpm,  double? nitritePpm,  double? nitratePpm,  double? ghDgh,  double? khDkh,  double? phosphatePpm,  double? oxygenMgL,  double? co2MgL,  double? tdsPpm,  double? chlorinePpm,  double? ironPpm,  double? copperPpm,  double? salinityPpt,  double? calciumPpm,  double? magnesiumPpm,  double? alkalinityDkh,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaterParameterLogEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.measuredAt,_that.temperatureCelsius,_that.ph,_that.ammoniaPpm,_that.nitritePpm,_that.nitratePpm,_that.ghDgh,_that.khDkh,_that.phosphatePpm,_that.oxygenMgL,_that.co2MgL,_that.tdsPpm,_that.chlorinePpm,_that.ironPpm,_that.copperPpm,_that.salinityPpt,_that.calciumPpm,_that.magnesiumPpm,_that.alkalinityDkh,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  DateTime measuredAt,  double? temperatureCelsius,  double? ph,  double? ammoniaPpm,  double? nitritePpm,  double? nitratePpm,  double? ghDgh,  double? khDkh,  double? phosphatePpm,  double? oxygenMgL,  double? co2MgL,  double? tdsPpm,  double? chlorinePpm,  double? ironPpm,  double? copperPpm,  double? salinityPpt,  double? calciumPpm,  double? magnesiumPpm,  double? alkalinityDkh,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WaterParameterLogEntity():
return $default(_that.id,_that.tankId,_that.measuredAt,_that.temperatureCelsius,_that.ph,_that.ammoniaPpm,_that.nitritePpm,_that.nitratePpm,_that.ghDgh,_that.khDkh,_that.phosphatePpm,_that.oxygenMgL,_that.co2MgL,_that.tdsPpm,_that.chlorinePpm,_that.ironPpm,_that.copperPpm,_that.salinityPpt,_that.calciumPpm,_that.magnesiumPpm,_that.alkalinityDkh,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  DateTime measuredAt,  double? temperatureCelsius,  double? ph,  double? ammoniaPpm,  double? nitritePpm,  double? nitratePpm,  double? ghDgh,  double? khDkh,  double? phosphatePpm,  double? oxygenMgL,  double? co2MgL,  double? tdsPpm,  double? chlorinePpm,  double? ironPpm,  double? copperPpm,  double? salinityPpt,  double? calciumPpm,  double? magnesiumPpm,  double? alkalinityDkh,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WaterParameterLogEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.measuredAt,_that.temperatureCelsius,_that.ph,_that.ammoniaPpm,_that.nitritePpm,_that.nitratePpm,_that.ghDgh,_that.khDkh,_that.phosphatePpm,_that.oxygenMgL,_that.co2MgL,_that.tdsPpm,_that.chlorinePpm,_that.ironPpm,_that.copperPpm,_that.salinityPpt,_that.calciumPpm,_that.magnesiumPpm,_that.alkalinityDkh,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _WaterParameterLogEntity extends WaterParameterLogEntity {
  const _WaterParameterLogEntity({this.id, required this.tankId, required this.measuredAt, this.temperatureCelsius, this.ph, this.ammoniaPpm, this.nitritePpm, this.nitratePpm, this.ghDgh, this.khDkh, this.phosphatePpm, this.oxygenMgL, this.co2MgL, this.tdsPpm, this.chlorinePpm, this.ironPpm, this.copperPpm, this.salinityPpt, this.calciumPpm, this.magnesiumPpm, this.alkalinityDkh, this.notes, this.createdAt}): super._();
  

/// Unique identifier (null for new logs)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// When the measurement was taken
@override final  DateTime measuredAt;
// ============================================================
// Core Parameters (most commonly tested)
// ============================================================
/// Temperature in Celsius
@override final  double? temperatureCelsius;
/// pH level (0-14)
@override final  double? ph;
/// Ammonia in ppm (NH3/NH4+)
@override final  double? ammoniaPpm;
/// Nitrite in ppm (NO2)
@override final  double? nitritePpm;
/// Nitrate in ppm (NO3)
@override final  double? nitratePpm;
// ============================================================
// Hardness Parameters
// ============================================================
/// General Hardness (GH) in dGH
@override final  double? ghDgh;
/// Carbonate Hardness (KH) in dKH
@override final  double? khDkh;
// ============================================================
// Additional Freshwater Parameters
// ============================================================
/// Phosphate in ppm (PO4)
@override final  double? phosphatePpm;
/// Dissolved oxygen in mg/L
@override final  double? oxygenMgL;
/// Carbon dioxide in mg/L
@override final  double? co2MgL;
/// TDS (Total Dissolved Solids) in ppm
@override final  double? tdsPpm;
/// Chlorine in ppm
@override final  double? chlorinePpm;
/// Iron in ppm (for planted tanks)
@override final  double? ironPpm;
/// Copper in ppm
@override final  double? copperPpm;
// ============================================================
// Saltwater/Reef Parameters
// ============================================================
/// Salinity in ppt (for saltwater)
@override final  double? salinityPpt;
/// Calcium in ppm (for reef tanks)
@override final  double? calciumPpm;
/// Magnesium in ppm (for reef tanks)
@override final  double? magnesiumPpm;
/// Alkalinity in dKH (for reef tanks)
@override final  double? alkalinityDkh;
// ============================================================
// Metadata
// ============================================================
/// Notes for this reading
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;

/// Create a copy of WaterParameterLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaterParameterLogEntityCopyWith<_WaterParameterLogEntity> get copyWith => __$WaterParameterLogEntityCopyWithImpl<_WaterParameterLogEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaterParameterLogEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.measuredAt, measuredAt) || other.measuredAt == measuredAt)&&(identical(other.temperatureCelsius, temperatureCelsius) || other.temperatureCelsius == temperatureCelsius)&&(identical(other.ph, ph) || other.ph == ph)&&(identical(other.ammoniaPpm, ammoniaPpm) || other.ammoniaPpm == ammoniaPpm)&&(identical(other.nitritePpm, nitritePpm) || other.nitritePpm == nitritePpm)&&(identical(other.nitratePpm, nitratePpm) || other.nitratePpm == nitratePpm)&&(identical(other.ghDgh, ghDgh) || other.ghDgh == ghDgh)&&(identical(other.khDkh, khDkh) || other.khDkh == khDkh)&&(identical(other.phosphatePpm, phosphatePpm) || other.phosphatePpm == phosphatePpm)&&(identical(other.oxygenMgL, oxygenMgL) || other.oxygenMgL == oxygenMgL)&&(identical(other.co2MgL, co2MgL) || other.co2MgL == co2MgL)&&(identical(other.tdsPpm, tdsPpm) || other.tdsPpm == tdsPpm)&&(identical(other.chlorinePpm, chlorinePpm) || other.chlorinePpm == chlorinePpm)&&(identical(other.ironPpm, ironPpm) || other.ironPpm == ironPpm)&&(identical(other.copperPpm, copperPpm) || other.copperPpm == copperPpm)&&(identical(other.salinityPpt, salinityPpt) || other.salinityPpt == salinityPpt)&&(identical(other.calciumPpm, calciumPpm) || other.calciumPpm == calciumPpm)&&(identical(other.magnesiumPpm, magnesiumPpm) || other.magnesiumPpm == magnesiumPpm)&&(identical(other.alkalinityDkh, alkalinityDkh) || other.alkalinityDkh == alkalinityDkh)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,measuredAt,temperatureCelsius,ph,ammoniaPpm,nitritePpm,nitratePpm,ghDgh,khDkh,phosphatePpm,oxygenMgL,co2MgL,tdsPpm,chlorinePpm,ironPpm,copperPpm,salinityPpt,calciumPpm,magnesiumPpm,alkalinityDkh,notes,createdAt]);

@override
String toString() {
  return 'WaterParameterLogEntity(id: $id, tankId: $tankId, measuredAt: $measuredAt, temperatureCelsius: $temperatureCelsius, ph: $ph, ammoniaPpm: $ammoniaPpm, nitritePpm: $nitritePpm, nitratePpm: $nitratePpm, ghDgh: $ghDgh, khDkh: $khDkh, phosphatePpm: $phosphatePpm, oxygenMgL: $oxygenMgL, co2MgL: $co2MgL, tdsPpm: $tdsPpm, chlorinePpm: $chlorinePpm, ironPpm: $ironPpm, copperPpm: $copperPpm, salinityPpt: $salinityPpt, calciumPpm: $calciumPpm, magnesiumPpm: $magnesiumPpm, alkalinityDkh: $alkalinityDkh, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WaterParameterLogEntityCopyWith<$Res> implements $WaterParameterLogEntityCopyWith<$Res> {
  factory _$WaterParameterLogEntityCopyWith(_WaterParameterLogEntity value, $Res Function(_WaterParameterLogEntity) _then) = __$WaterParameterLogEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, DateTime measuredAt, double? temperatureCelsius, double? ph, double? ammoniaPpm, double? nitritePpm, double? nitratePpm, double? ghDgh, double? khDkh, double? phosphatePpm, double? oxygenMgL, double? co2MgL, double? tdsPpm, double? chlorinePpm, double? ironPpm, double? copperPpm, double? salinityPpt, double? calciumPpm, double? magnesiumPpm, double? alkalinityDkh, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$WaterParameterLogEntityCopyWithImpl<$Res>
    implements _$WaterParameterLogEntityCopyWith<$Res> {
  __$WaterParameterLogEntityCopyWithImpl(this._self, this._then);

  final _WaterParameterLogEntity _self;
  final $Res Function(_WaterParameterLogEntity) _then;

/// Create a copy of WaterParameterLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? measuredAt = null,Object? temperatureCelsius = freezed,Object? ph = freezed,Object? ammoniaPpm = freezed,Object? nitritePpm = freezed,Object? nitratePpm = freezed,Object? ghDgh = freezed,Object? khDkh = freezed,Object? phosphatePpm = freezed,Object? oxygenMgL = freezed,Object? co2MgL = freezed,Object? tdsPpm = freezed,Object? chlorinePpm = freezed,Object? ironPpm = freezed,Object? copperPpm = freezed,Object? salinityPpt = freezed,Object? calciumPpm = freezed,Object? magnesiumPpm = freezed,Object? alkalinityDkh = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_WaterParameterLogEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,measuredAt: null == measuredAt ? _self.measuredAt : measuredAt // ignore: cast_nullable_to_non_nullable
as DateTime,temperatureCelsius: freezed == temperatureCelsius ? _self.temperatureCelsius : temperatureCelsius // ignore: cast_nullable_to_non_nullable
as double?,ph: freezed == ph ? _self.ph : ph // ignore: cast_nullable_to_non_nullable
as double?,ammoniaPpm: freezed == ammoniaPpm ? _self.ammoniaPpm : ammoniaPpm // ignore: cast_nullable_to_non_nullable
as double?,nitritePpm: freezed == nitritePpm ? _self.nitritePpm : nitritePpm // ignore: cast_nullable_to_non_nullable
as double?,nitratePpm: freezed == nitratePpm ? _self.nitratePpm : nitratePpm // ignore: cast_nullable_to_non_nullable
as double?,ghDgh: freezed == ghDgh ? _self.ghDgh : ghDgh // ignore: cast_nullable_to_non_nullable
as double?,khDkh: freezed == khDkh ? _self.khDkh : khDkh // ignore: cast_nullable_to_non_nullable
as double?,phosphatePpm: freezed == phosphatePpm ? _self.phosphatePpm : phosphatePpm // ignore: cast_nullable_to_non_nullable
as double?,oxygenMgL: freezed == oxygenMgL ? _self.oxygenMgL : oxygenMgL // ignore: cast_nullable_to_non_nullable
as double?,co2MgL: freezed == co2MgL ? _self.co2MgL : co2MgL // ignore: cast_nullable_to_non_nullable
as double?,tdsPpm: freezed == tdsPpm ? _self.tdsPpm : tdsPpm // ignore: cast_nullable_to_non_nullable
as double?,chlorinePpm: freezed == chlorinePpm ? _self.chlorinePpm : chlorinePpm // ignore: cast_nullable_to_non_nullable
as double?,ironPpm: freezed == ironPpm ? _self.ironPpm : ironPpm // ignore: cast_nullable_to_non_nullable
as double?,copperPpm: freezed == copperPpm ? _self.copperPpm : copperPpm // ignore: cast_nullable_to_non_nullable
as double?,salinityPpt: freezed == salinityPpt ? _self.salinityPpt : salinityPpt // ignore: cast_nullable_to_non_nullable
as double?,calciumPpm: freezed == calciumPpm ? _self.calciumPpm : calciumPpm // ignore: cast_nullable_to_non_nullable
as double?,magnesiumPpm: freezed == magnesiumPpm ? _self.magnesiumPpm : magnesiumPpm // ignore: cast_nullable_to_non_nullable
as double?,alkalinityDkh: freezed == alkalinityDkh ? _self.alkalinityDkh : alkalinityDkh // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
