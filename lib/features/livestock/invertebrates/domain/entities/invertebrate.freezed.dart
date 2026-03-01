// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invertebrate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvertebrateEntity {

/// Unique identifier (null for new invertebrates)
 int? get id;/// Tank this invertebrate belongs to
 int get tankId;/// Species scientific name
 String get species;/// Common name
 String? get commonName;/// Type of invertebrate
 InvertebrateType get invertebrateType;/// Number of this species in tank
 int get quantity;/// Water type preference
 InvertWaterType get waterType;/// Care level difficulty
 InvertCareLevel? get careLevel;/// Maximum adult size in cm
 double? get maxSizeCm;/// Current size in cm
 double? get currentSizeCm;/// Minimum tank size in liters
 double? get minTankSizeLiters;/// Minimum temperature in Celsius
 double? get minTempCelsius;/// Maximum temperature in Celsius
 double? get maxTempCelsius;/// Minimum pH
 double? get minPh;/// Maximum pH
 double? get maxPh;/// Lifespan in years
 int? get lifespanYears;/// Date added to tank
 DateTime? get dateAdded;/// Date of death (if deceased)
 DateTime? get dateDeceased;/// Purchase price
 double? get purchasePrice;/// Source/store where purchased
 String? get source;/// Is this invertebrate quarantined
 bool get isQuarantined;/// Quarantine end date
 DateTime? get quarantineEndDate;/// Is this a colony (for shrimp breeding)
 bool get isBreedingColony;/// Notes/additional info
 String? get notes;/// Photo URL or path
 String? get photoUrl;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of InvertebrateEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvertebrateEntityCopyWith<InvertebrateEntity> get copyWith => _$InvertebrateEntityCopyWithImpl<InvertebrateEntity>(this as InvertebrateEntity, _$identity);

  /// Serializes this InvertebrateEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvertebrateEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.species, species) || other.species == species)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.invertebrateType, invertebrateType) || other.invertebrateType == invertebrateType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.waterType, waterType) || other.waterType == waterType)&&(identical(other.careLevel, careLevel) || other.careLevel == careLevel)&&(identical(other.maxSizeCm, maxSizeCm) || other.maxSizeCm == maxSizeCm)&&(identical(other.currentSizeCm, currentSizeCm) || other.currentSizeCm == currentSizeCm)&&(identical(other.minTankSizeLiters, minTankSizeLiters) || other.minTankSizeLiters == minTankSizeLiters)&&(identical(other.minTempCelsius, minTempCelsius) || other.minTempCelsius == minTempCelsius)&&(identical(other.maxTempCelsius, maxTempCelsius) || other.maxTempCelsius == maxTempCelsius)&&(identical(other.minPh, minPh) || other.minPh == minPh)&&(identical(other.maxPh, maxPh) || other.maxPh == maxPh)&&(identical(other.lifespanYears, lifespanYears) || other.lifespanYears == lifespanYears)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.dateDeceased, dateDeceased) || other.dateDeceased == dateDeceased)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.isQuarantined, isQuarantined) || other.isQuarantined == isQuarantined)&&(identical(other.quarantineEndDate, quarantineEndDate) || other.quarantineEndDate == quarantineEndDate)&&(identical(other.isBreedingColony, isBreedingColony) || other.isBreedingColony == isBreedingColony)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,species,commonName,invertebrateType,quantity,waterType,careLevel,maxSizeCm,currentSizeCm,minTankSizeLiters,minTempCelsius,maxTempCelsius,minPh,maxPh,lifespanYears,dateAdded,dateDeceased,purchasePrice,source,isQuarantined,quarantineEndDate,isBreedingColony,notes,photoUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'InvertebrateEntity(id: $id, tankId: $tankId, species: $species, commonName: $commonName, invertebrateType: $invertebrateType, quantity: $quantity, waterType: $waterType, careLevel: $careLevel, maxSizeCm: $maxSizeCm, currentSizeCm: $currentSizeCm, minTankSizeLiters: $minTankSizeLiters, minTempCelsius: $minTempCelsius, maxTempCelsius: $maxTempCelsius, minPh: $minPh, maxPh: $maxPh, lifespanYears: $lifespanYears, dateAdded: $dateAdded, dateDeceased: $dateDeceased, purchasePrice: $purchasePrice, source: $source, isQuarantined: $isQuarantined, quarantineEndDate: $quarantineEndDate, isBreedingColony: $isBreedingColony, notes: $notes, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $InvertebrateEntityCopyWith<$Res>  {
  factory $InvertebrateEntityCopyWith(InvertebrateEntity value, $Res Function(InvertebrateEntity) _then) = _$InvertebrateEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String species, String? commonName, InvertebrateType invertebrateType, int quantity, InvertWaterType waterType, InvertCareLevel? careLevel, double? maxSizeCm, double? currentSizeCm, double? minTankSizeLiters, double? minTempCelsius, double? maxTempCelsius, double? minPh, double? maxPh, int? lifespanYears, DateTime? dateAdded, DateTime? dateDeceased, double? purchasePrice, String? source, bool isQuarantined, DateTime? quarantineEndDate, bool isBreedingColony, String? notes, String? photoUrl, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$InvertebrateEntityCopyWithImpl<$Res>
    implements $InvertebrateEntityCopyWith<$Res> {
  _$InvertebrateEntityCopyWithImpl(this._self, this._then);

  final InvertebrateEntity _self;
  final $Res Function(InvertebrateEntity) _then;

/// Create a copy of InvertebrateEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? species = null,Object? commonName = freezed,Object? invertebrateType = null,Object? quantity = null,Object? waterType = null,Object? careLevel = freezed,Object? maxSizeCm = freezed,Object? currentSizeCm = freezed,Object? minTankSizeLiters = freezed,Object? minTempCelsius = freezed,Object? maxTempCelsius = freezed,Object? minPh = freezed,Object? maxPh = freezed,Object? lifespanYears = freezed,Object? dateAdded = freezed,Object? dateDeceased = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? isQuarantined = null,Object? quarantineEndDate = freezed,Object? isBreedingColony = null,Object? notes = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,commonName: freezed == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String?,invertebrateType: null == invertebrateType ? _self.invertebrateType : invertebrateType // ignore: cast_nullable_to_non_nullable
as InvertebrateType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,waterType: null == waterType ? _self.waterType : waterType // ignore: cast_nullable_to_non_nullable
as InvertWaterType,careLevel: freezed == careLevel ? _self.careLevel : careLevel // ignore: cast_nullable_to_non_nullable
as InvertCareLevel?,maxSizeCm: freezed == maxSizeCm ? _self.maxSizeCm : maxSizeCm // ignore: cast_nullable_to_non_nullable
as double?,currentSizeCm: freezed == currentSizeCm ? _self.currentSizeCm : currentSizeCm // ignore: cast_nullable_to_non_nullable
as double?,minTankSizeLiters: freezed == minTankSizeLiters ? _self.minTankSizeLiters : minTankSizeLiters // ignore: cast_nullable_to_non_nullable
as double?,minTempCelsius: freezed == minTempCelsius ? _self.minTempCelsius : minTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,maxTempCelsius: freezed == maxTempCelsius ? _self.maxTempCelsius : maxTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,minPh: freezed == minPh ? _self.minPh : minPh // ignore: cast_nullable_to_non_nullable
as double?,maxPh: freezed == maxPh ? _self.maxPh : maxPh // ignore: cast_nullable_to_non_nullable
as double?,lifespanYears: freezed == lifespanYears ? _self.lifespanYears : lifespanYears // ignore: cast_nullable_to_non_nullable
as int?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,dateDeceased: freezed == dateDeceased ? _self.dateDeceased : dateDeceased // ignore: cast_nullable_to_non_nullable
as DateTime?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,isQuarantined: null == isQuarantined ? _self.isQuarantined : isQuarantined // ignore: cast_nullable_to_non_nullable
as bool,quarantineEndDate: freezed == quarantineEndDate ? _self.quarantineEndDate : quarantineEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isBreedingColony: null == isBreedingColony ? _self.isBreedingColony : isBreedingColony // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvertebrateEntity].
extension InvertebrateEntityPatterns on InvertebrateEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvertebrateEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvertebrateEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvertebrateEntity value)  $default,){
final _that = this;
switch (_that) {
case _InvertebrateEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvertebrateEntity value)?  $default,){
final _that = this;
switch (_that) {
case _InvertebrateEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String species,  String? commonName,  InvertebrateType invertebrateType,  int quantity,  InvertWaterType waterType,  InvertCareLevel? careLevel,  double? maxSizeCm,  double? currentSizeCm,  double? minTankSizeLiters,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  int? lifespanYears,  DateTime? dateAdded,  DateTime? dateDeceased,  double? purchasePrice,  String? source,  bool isQuarantined,  DateTime? quarantineEndDate,  bool isBreedingColony,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvertebrateEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.invertebrateType,_that.quantity,_that.waterType,_that.careLevel,_that.maxSizeCm,_that.currentSizeCm,_that.minTankSizeLiters,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.lifespanYears,_that.dateAdded,_that.dateDeceased,_that.purchasePrice,_that.source,_that.isQuarantined,_that.quarantineEndDate,_that.isBreedingColony,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String species,  String? commonName,  InvertebrateType invertebrateType,  int quantity,  InvertWaterType waterType,  InvertCareLevel? careLevel,  double? maxSizeCm,  double? currentSizeCm,  double? minTankSizeLiters,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  int? lifespanYears,  DateTime? dateAdded,  DateTime? dateDeceased,  double? purchasePrice,  String? source,  bool isQuarantined,  DateTime? quarantineEndDate,  bool isBreedingColony,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _InvertebrateEntity():
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.invertebrateType,_that.quantity,_that.waterType,_that.careLevel,_that.maxSizeCm,_that.currentSizeCm,_that.minTankSizeLiters,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.lifespanYears,_that.dateAdded,_that.dateDeceased,_that.purchasePrice,_that.source,_that.isQuarantined,_that.quarantineEndDate,_that.isBreedingColony,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String species,  String? commonName,  InvertebrateType invertebrateType,  int quantity,  InvertWaterType waterType,  InvertCareLevel? careLevel,  double? maxSizeCm,  double? currentSizeCm,  double? minTankSizeLiters,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  int? lifespanYears,  DateTime? dateAdded,  DateTime? dateDeceased,  double? purchasePrice,  String? source,  bool isQuarantined,  DateTime? quarantineEndDate,  bool isBreedingColony,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _InvertebrateEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.invertebrateType,_that.quantity,_that.waterType,_that.careLevel,_that.maxSizeCm,_that.currentSizeCm,_that.minTankSizeLiters,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.lifespanYears,_that.dateAdded,_that.dateDeceased,_that.purchasePrice,_that.source,_that.isQuarantined,_that.quarantineEndDate,_that.isBreedingColony,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvertebrateEntity extends InvertebrateEntity {
  const _InvertebrateEntity({this.id, required this.tankId, required this.species, this.commonName, this.invertebrateType = InvertebrateType.shrimp, this.quantity = 1, this.waterType = InvertWaterType.freshwater, this.careLevel, this.maxSizeCm, this.currentSizeCm, this.minTankSizeLiters, this.minTempCelsius, this.maxTempCelsius, this.minPh, this.maxPh, this.lifespanYears, this.dateAdded, this.dateDeceased, this.purchasePrice, this.source, this.isQuarantined = false, this.quarantineEndDate, this.isBreedingColony = false, this.notes, this.photoUrl, this.createdAt, this.updatedAt}): super._();
  factory _InvertebrateEntity.fromJson(Map<String, dynamic> json) => _$InvertebrateEntityFromJson(json);

/// Unique identifier (null for new invertebrates)
@override final  int? id;
/// Tank this invertebrate belongs to
@override final  int tankId;
/// Species scientific name
@override final  String species;
/// Common name
@override final  String? commonName;
/// Type of invertebrate
@override@JsonKey() final  InvertebrateType invertebrateType;
/// Number of this species in tank
@override@JsonKey() final  int quantity;
/// Water type preference
@override@JsonKey() final  InvertWaterType waterType;
/// Care level difficulty
@override final  InvertCareLevel? careLevel;
/// Maximum adult size in cm
@override final  double? maxSizeCm;
/// Current size in cm
@override final  double? currentSizeCm;
/// Minimum tank size in liters
@override final  double? minTankSizeLiters;
/// Minimum temperature in Celsius
@override final  double? minTempCelsius;
/// Maximum temperature in Celsius
@override final  double? maxTempCelsius;
/// Minimum pH
@override final  double? minPh;
/// Maximum pH
@override final  double? maxPh;
/// Lifespan in years
@override final  int? lifespanYears;
/// Date added to tank
@override final  DateTime? dateAdded;
/// Date of death (if deceased)
@override final  DateTime? dateDeceased;
/// Purchase price
@override final  double? purchasePrice;
/// Source/store where purchased
@override final  String? source;
/// Is this invertebrate quarantined
@override@JsonKey() final  bool isQuarantined;
/// Quarantine end date
@override final  DateTime? quarantineEndDate;
/// Is this a colony (for shrimp breeding)
@override@JsonKey() final  bool isBreedingColony;
/// Notes/additional info
@override final  String? notes;
/// Photo URL or path
@override final  String? photoUrl;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of InvertebrateEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvertebrateEntityCopyWith<_InvertebrateEntity> get copyWith => __$InvertebrateEntityCopyWithImpl<_InvertebrateEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvertebrateEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvertebrateEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.species, species) || other.species == species)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.invertebrateType, invertebrateType) || other.invertebrateType == invertebrateType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.waterType, waterType) || other.waterType == waterType)&&(identical(other.careLevel, careLevel) || other.careLevel == careLevel)&&(identical(other.maxSizeCm, maxSizeCm) || other.maxSizeCm == maxSizeCm)&&(identical(other.currentSizeCm, currentSizeCm) || other.currentSizeCm == currentSizeCm)&&(identical(other.minTankSizeLiters, minTankSizeLiters) || other.minTankSizeLiters == minTankSizeLiters)&&(identical(other.minTempCelsius, minTempCelsius) || other.minTempCelsius == minTempCelsius)&&(identical(other.maxTempCelsius, maxTempCelsius) || other.maxTempCelsius == maxTempCelsius)&&(identical(other.minPh, minPh) || other.minPh == minPh)&&(identical(other.maxPh, maxPh) || other.maxPh == maxPh)&&(identical(other.lifespanYears, lifespanYears) || other.lifespanYears == lifespanYears)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.dateDeceased, dateDeceased) || other.dateDeceased == dateDeceased)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.isQuarantined, isQuarantined) || other.isQuarantined == isQuarantined)&&(identical(other.quarantineEndDate, quarantineEndDate) || other.quarantineEndDate == quarantineEndDate)&&(identical(other.isBreedingColony, isBreedingColony) || other.isBreedingColony == isBreedingColony)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,species,commonName,invertebrateType,quantity,waterType,careLevel,maxSizeCm,currentSizeCm,minTankSizeLiters,minTempCelsius,maxTempCelsius,minPh,maxPh,lifespanYears,dateAdded,dateDeceased,purchasePrice,source,isQuarantined,quarantineEndDate,isBreedingColony,notes,photoUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'InvertebrateEntity(id: $id, tankId: $tankId, species: $species, commonName: $commonName, invertebrateType: $invertebrateType, quantity: $quantity, waterType: $waterType, careLevel: $careLevel, maxSizeCm: $maxSizeCm, currentSizeCm: $currentSizeCm, minTankSizeLiters: $minTankSizeLiters, minTempCelsius: $minTempCelsius, maxTempCelsius: $maxTempCelsius, minPh: $minPh, maxPh: $maxPh, lifespanYears: $lifespanYears, dateAdded: $dateAdded, dateDeceased: $dateDeceased, purchasePrice: $purchasePrice, source: $source, isQuarantined: $isQuarantined, quarantineEndDate: $quarantineEndDate, isBreedingColony: $isBreedingColony, notes: $notes, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$InvertebrateEntityCopyWith<$Res> implements $InvertebrateEntityCopyWith<$Res> {
  factory _$InvertebrateEntityCopyWith(_InvertebrateEntity value, $Res Function(_InvertebrateEntity) _then) = __$InvertebrateEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String species, String? commonName, InvertebrateType invertebrateType, int quantity, InvertWaterType waterType, InvertCareLevel? careLevel, double? maxSizeCm, double? currentSizeCm, double? minTankSizeLiters, double? minTempCelsius, double? maxTempCelsius, double? minPh, double? maxPh, int? lifespanYears, DateTime? dateAdded, DateTime? dateDeceased, double? purchasePrice, String? source, bool isQuarantined, DateTime? quarantineEndDate, bool isBreedingColony, String? notes, String? photoUrl, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$InvertebrateEntityCopyWithImpl<$Res>
    implements _$InvertebrateEntityCopyWith<$Res> {
  __$InvertebrateEntityCopyWithImpl(this._self, this._then);

  final _InvertebrateEntity _self;
  final $Res Function(_InvertebrateEntity) _then;

/// Create a copy of InvertebrateEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? species = null,Object? commonName = freezed,Object? invertebrateType = null,Object? quantity = null,Object? waterType = null,Object? careLevel = freezed,Object? maxSizeCm = freezed,Object? currentSizeCm = freezed,Object? minTankSizeLiters = freezed,Object? minTempCelsius = freezed,Object? maxTempCelsius = freezed,Object? minPh = freezed,Object? maxPh = freezed,Object? lifespanYears = freezed,Object? dateAdded = freezed,Object? dateDeceased = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? isQuarantined = null,Object? quarantineEndDate = freezed,Object? isBreedingColony = null,Object? notes = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_InvertebrateEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,commonName: freezed == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String?,invertebrateType: null == invertebrateType ? _self.invertebrateType : invertebrateType // ignore: cast_nullable_to_non_nullable
as InvertebrateType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,waterType: null == waterType ? _self.waterType : waterType // ignore: cast_nullable_to_non_nullable
as InvertWaterType,careLevel: freezed == careLevel ? _self.careLevel : careLevel // ignore: cast_nullable_to_non_nullable
as InvertCareLevel?,maxSizeCm: freezed == maxSizeCm ? _self.maxSizeCm : maxSizeCm // ignore: cast_nullable_to_non_nullable
as double?,currentSizeCm: freezed == currentSizeCm ? _self.currentSizeCm : currentSizeCm // ignore: cast_nullable_to_non_nullable
as double?,minTankSizeLiters: freezed == minTankSizeLiters ? _self.minTankSizeLiters : minTankSizeLiters // ignore: cast_nullable_to_non_nullable
as double?,minTempCelsius: freezed == minTempCelsius ? _self.minTempCelsius : minTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,maxTempCelsius: freezed == maxTempCelsius ? _self.maxTempCelsius : maxTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,minPh: freezed == minPh ? _self.minPh : minPh // ignore: cast_nullable_to_non_nullable
as double?,maxPh: freezed == maxPh ? _self.maxPh : maxPh // ignore: cast_nullable_to_non_nullable
as double?,lifespanYears: freezed == lifespanYears ? _self.lifespanYears : lifespanYears // ignore: cast_nullable_to_non_nullable
as int?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,dateDeceased: freezed == dateDeceased ? _self.dateDeceased : dateDeceased // ignore: cast_nullable_to_non_nullable
as DateTime?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,isQuarantined: null == isQuarantined ? _self.isQuarantined : isQuarantined // ignore: cast_nullable_to_non_nullable
as bool,quarantineEndDate: freezed == quarantineEndDate ? _self.quarantineEndDate : quarantineEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isBreedingColony: null == isBreedingColony ? _self.isBreedingColony : isBreedingColony // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
