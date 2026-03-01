// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fish.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FishEntity {

/// Unique identifier (null for new fish)
 int? get id;/// Foreign key to tank
 int get tankId;/// Species scientific name
 String get species;/// Common name
 String? get commonName;/// Number of this species in tank
 int get quantity;/// Water type preference
 WaterType get waterType;/// Fish temperament
 FishTemperament? get temperament;/// Diet type
 FishDiet? get diet;/// Care level difficulty
 CareLevel? get careLevel;/// Swimming level in tank
 SwimmingLevel? get swimmingLevel;/// Maximum adult size in cm
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
 String? get source;/// Is this fish quarantined
 bool get isQuarantined;/// Quarantine end date
 DateTime? get quarantineEndDate;/// Notes/additional info
 String? get notes;/// Photo URL or path
 String? get photoUrl;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of FishEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FishEntityCopyWith<FishEntity> get copyWith => _$FishEntityCopyWithImpl<FishEntity>(this as FishEntity, _$identity);

  /// Serializes this FishEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FishEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.species, species) || other.species == species)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.waterType, waterType) || other.waterType == waterType)&&(identical(other.temperament, temperament) || other.temperament == temperament)&&(identical(other.diet, diet) || other.diet == diet)&&(identical(other.careLevel, careLevel) || other.careLevel == careLevel)&&(identical(other.swimmingLevel, swimmingLevel) || other.swimmingLevel == swimmingLevel)&&(identical(other.maxSizeCm, maxSizeCm) || other.maxSizeCm == maxSizeCm)&&(identical(other.currentSizeCm, currentSizeCm) || other.currentSizeCm == currentSizeCm)&&(identical(other.minTankSizeLiters, minTankSizeLiters) || other.minTankSizeLiters == minTankSizeLiters)&&(identical(other.minTempCelsius, minTempCelsius) || other.minTempCelsius == minTempCelsius)&&(identical(other.maxTempCelsius, maxTempCelsius) || other.maxTempCelsius == maxTempCelsius)&&(identical(other.minPh, minPh) || other.minPh == minPh)&&(identical(other.maxPh, maxPh) || other.maxPh == maxPh)&&(identical(other.lifespanYears, lifespanYears) || other.lifespanYears == lifespanYears)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.dateDeceased, dateDeceased) || other.dateDeceased == dateDeceased)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.isQuarantined, isQuarantined) || other.isQuarantined == isQuarantined)&&(identical(other.quarantineEndDate, quarantineEndDate) || other.quarantineEndDate == quarantineEndDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,species,commonName,quantity,waterType,temperament,diet,careLevel,swimmingLevel,maxSizeCm,currentSizeCm,minTankSizeLiters,minTempCelsius,maxTempCelsius,minPh,maxPh,lifespanYears,dateAdded,dateDeceased,purchasePrice,source,isQuarantined,quarantineEndDate,notes,photoUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'FishEntity(id: $id, tankId: $tankId, species: $species, commonName: $commonName, quantity: $quantity, waterType: $waterType, temperament: $temperament, diet: $diet, careLevel: $careLevel, swimmingLevel: $swimmingLevel, maxSizeCm: $maxSizeCm, currentSizeCm: $currentSizeCm, minTankSizeLiters: $minTankSizeLiters, minTempCelsius: $minTempCelsius, maxTempCelsius: $maxTempCelsius, minPh: $minPh, maxPh: $maxPh, lifespanYears: $lifespanYears, dateAdded: $dateAdded, dateDeceased: $dateDeceased, purchasePrice: $purchasePrice, source: $source, isQuarantined: $isQuarantined, quarantineEndDate: $quarantineEndDate, notes: $notes, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FishEntityCopyWith<$Res>  {
  factory $FishEntityCopyWith(FishEntity value, $Res Function(FishEntity) _then) = _$FishEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String species, String? commonName, int quantity, WaterType waterType, FishTemperament? temperament, FishDiet? diet, CareLevel? careLevel, SwimmingLevel? swimmingLevel, double? maxSizeCm, double? currentSizeCm, double? minTankSizeLiters, double? minTempCelsius, double? maxTempCelsius, double? minPh, double? maxPh, int? lifespanYears, DateTime? dateAdded, DateTime? dateDeceased, double? purchasePrice, String? source, bool isQuarantined, DateTime? quarantineEndDate, String? notes, String? photoUrl, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$FishEntityCopyWithImpl<$Res>
    implements $FishEntityCopyWith<$Res> {
  _$FishEntityCopyWithImpl(this._self, this._then);

  final FishEntity _self;
  final $Res Function(FishEntity) _then;

/// Create a copy of FishEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? species = null,Object? commonName = freezed,Object? quantity = null,Object? waterType = null,Object? temperament = freezed,Object? diet = freezed,Object? careLevel = freezed,Object? swimmingLevel = freezed,Object? maxSizeCm = freezed,Object? currentSizeCm = freezed,Object? minTankSizeLiters = freezed,Object? minTempCelsius = freezed,Object? maxTempCelsius = freezed,Object? minPh = freezed,Object? maxPh = freezed,Object? lifespanYears = freezed,Object? dateAdded = freezed,Object? dateDeceased = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? isQuarantined = null,Object? quarantineEndDate = freezed,Object? notes = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,commonName: freezed == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,waterType: null == waterType ? _self.waterType : waterType // ignore: cast_nullable_to_non_nullable
as WaterType,temperament: freezed == temperament ? _self.temperament : temperament // ignore: cast_nullable_to_non_nullable
as FishTemperament?,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as FishDiet?,careLevel: freezed == careLevel ? _self.careLevel : careLevel // ignore: cast_nullable_to_non_nullable
as CareLevel?,swimmingLevel: freezed == swimmingLevel ? _self.swimmingLevel : swimmingLevel // ignore: cast_nullable_to_non_nullable
as SwimmingLevel?,maxSizeCm: freezed == maxSizeCm ? _self.maxSizeCm : maxSizeCm // ignore: cast_nullable_to_non_nullable
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
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FishEntity].
extension FishEntityPatterns on FishEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FishEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FishEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FishEntity value)  $default,){
final _that = this;
switch (_that) {
case _FishEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FishEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FishEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String species,  String? commonName,  int quantity,  WaterType waterType,  FishTemperament? temperament,  FishDiet? diet,  CareLevel? careLevel,  SwimmingLevel? swimmingLevel,  double? maxSizeCm,  double? currentSizeCm,  double? minTankSizeLiters,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  int? lifespanYears,  DateTime? dateAdded,  DateTime? dateDeceased,  double? purchasePrice,  String? source,  bool isQuarantined,  DateTime? quarantineEndDate,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FishEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.quantity,_that.waterType,_that.temperament,_that.diet,_that.careLevel,_that.swimmingLevel,_that.maxSizeCm,_that.currentSizeCm,_that.minTankSizeLiters,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.lifespanYears,_that.dateAdded,_that.dateDeceased,_that.purchasePrice,_that.source,_that.isQuarantined,_that.quarantineEndDate,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String species,  String? commonName,  int quantity,  WaterType waterType,  FishTemperament? temperament,  FishDiet? diet,  CareLevel? careLevel,  SwimmingLevel? swimmingLevel,  double? maxSizeCm,  double? currentSizeCm,  double? minTankSizeLiters,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  int? lifespanYears,  DateTime? dateAdded,  DateTime? dateDeceased,  double? purchasePrice,  String? source,  bool isQuarantined,  DateTime? quarantineEndDate,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FishEntity():
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.quantity,_that.waterType,_that.temperament,_that.diet,_that.careLevel,_that.swimmingLevel,_that.maxSizeCm,_that.currentSizeCm,_that.minTankSizeLiters,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.lifespanYears,_that.dateAdded,_that.dateDeceased,_that.purchasePrice,_that.source,_that.isQuarantined,_that.quarantineEndDate,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String species,  String? commonName,  int quantity,  WaterType waterType,  FishTemperament? temperament,  FishDiet? diet,  CareLevel? careLevel,  SwimmingLevel? swimmingLevel,  double? maxSizeCm,  double? currentSizeCm,  double? minTankSizeLiters,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  int? lifespanYears,  DateTime? dateAdded,  DateTime? dateDeceased,  double? purchasePrice,  String? source,  bool isQuarantined,  DateTime? quarantineEndDate,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FishEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.quantity,_that.waterType,_that.temperament,_that.diet,_that.careLevel,_that.swimmingLevel,_that.maxSizeCm,_that.currentSizeCm,_that.minTankSizeLiters,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.lifespanYears,_that.dateAdded,_that.dateDeceased,_that.purchasePrice,_that.source,_that.isQuarantined,_that.quarantineEndDate,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FishEntity extends FishEntity {
  const _FishEntity({this.id, required this.tankId, required this.species, this.commonName, this.quantity = 1, this.waterType = WaterType.freshwater, this.temperament, this.diet, this.careLevel, this.swimmingLevel, this.maxSizeCm, this.currentSizeCm, this.minTankSizeLiters, this.minTempCelsius, this.maxTempCelsius, this.minPh, this.maxPh, this.lifespanYears, this.dateAdded, this.dateDeceased, this.purchasePrice, this.source, this.isQuarantined = false, this.quarantineEndDate, this.notes, this.photoUrl, this.createdAt, this.updatedAt}): super._();
  factory _FishEntity.fromJson(Map<String, dynamic> json) => _$FishEntityFromJson(json);

/// Unique identifier (null for new fish)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Species scientific name
@override final  String species;
/// Common name
@override final  String? commonName;
/// Number of this species in tank
@override@JsonKey() final  int quantity;
/// Water type preference
@override@JsonKey() final  WaterType waterType;
/// Fish temperament
@override final  FishTemperament? temperament;
/// Diet type
@override final  FishDiet? diet;
/// Care level difficulty
@override final  CareLevel? careLevel;
/// Swimming level in tank
@override final  SwimmingLevel? swimmingLevel;
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
/// Is this fish quarantined
@override@JsonKey() final  bool isQuarantined;
/// Quarantine end date
@override final  DateTime? quarantineEndDate;
/// Notes/additional info
@override final  String? notes;
/// Photo URL or path
@override final  String? photoUrl;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of FishEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FishEntityCopyWith<_FishEntity> get copyWith => __$FishEntityCopyWithImpl<_FishEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FishEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FishEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.species, species) || other.species == species)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.waterType, waterType) || other.waterType == waterType)&&(identical(other.temperament, temperament) || other.temperament == temperament)&&(identical(other.diet, diet) || other.diet == diet)&&(identical(other.careLevel, careLevel) || other.careLevel == careLevel)&&(identical(other.swimmingLevel, swimmingLevel) || other.swimmingLevel == swimmingLevel)&&(identical(other.maxSizeCm, maxSizeCm) || other.maxSizeCm == maxSizeCm)&&(identical(other.currentSizeCm, currentSizeCm) || other.currentSizeCm == currentSizeCm)&&(identical(other.minTankSizeLiters, minTankSizeLiters) || other.minTankSizeLiters == minTankSizeLiters)&&(identical(other.minTempCelsius, minTempCelsius) || other.minTempCelsius == minTempCelsius)&&(identical(other.maxTempCelsius, maxTempCelsius) || other.maxTempCelsius == maxTempCelsius)&&(identical(other.minPh, minPh) || other.minPh == minPh)&&(identical(other.maxPh, maxPh) || other.maxPh == maxPh)&&(identical(other.lifespanYears, lifespanYears) || other.lifespanYears == lifespanYears)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.dateDeceased, dateDeceased) || other.dateDeceased == dateDeceased)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.isQuarantined, isQuarantined) || other.isQuarantined == isQuarantined)&&(identical(other.quarantineEndDate, quarantineEndDate) || other.quarantineEndDate == quarantineEndDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,species,commonName,quantity,waterType,temperament,diet,careLevel,swimmingLevel,maxSizeCm,currentSizeCm,minTankSizeLiters,minTempCelsius,maxTempCelsius,minPh,maxPh,lifespanYears,dateAdded,dateDeceased,purchasePrice,source,isQuarantined,quarantineEndDate,notes,photoUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'FishEntity(id: $id, tankId: $tankId, species: $species, commonName: $commonName, quantity: $quantity, waterType: $waterType, temperament: $temperament, diet: $diet, careLevel: $careLevel, swimmingLevel: $swimmingLevel, maxSizeCm: $maxSizeCm, currentSizeCm: $currentSizeCm, minTankSizeLiters: $minTankSizeLiters, minTempCelsius: $minTempCelsius, maxTempCelsius: $maxTempCelsius, minPh: $minPh, maxPh: $maxPh, lifespanYears: $lifespanYears, dateAdded: $dateAdded, dateDeceased: $dateDeceased, purchasePrice: $purchasePrice, source: $source, isQuarantined: $isQuarantined, quarantineEndDate: $quarantineEndDate, notes: $notes, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FishEntityCopyWith<$Res> implements $FishEntityCopyWith<$Res> {
  factory _$FishEntityCopyWith(_FishEntity value, $Res Function(_FishEntity) _then) = __$FishEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String species, String? commonName, int quantity, WaterType waterType, FishTemperament? temperament, FishDiet? diet, CareLevel? careLevel, SwimmingLevel? swimmingLevel, double? maxSizeCm, double? currentSizeCm, double? minTankSizeLiters, double? minTempCelsius, double? maxTempCelsius, double? minPh, double? maxPh, int? lifespanYears, DateTime? dateAdded, DateTime? dateDeceased, double? purchasePrice, String? source, bool isQuarantined, DateTime? quarantineEndDate, String? notes, String? photoUrl, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$FishEntityCopyWithImpl<$Res>
    implements _$FishEntityCopyWith<$Res> {
  __$FishEntityCopyWithImpl(this._self, this._then);

  final _FishEntity _self;
  final $Res Function(_FishEntity) _then;

/// Create a copy of FishEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? species = null,Object? commonName = freezed,Object? quantity = null,Object? waterType = null,Object? temperament = freezed,Object? diet = freezed,Object? careLevel = freezed,Object? swimmingLevel = freezed,Object? maxSizeCm = freezed,Object? currentSizeCm = freezed,Object? minTankSizeLiters = freezed,Object? minTempCelsius = freezed,Object? maxTempCelsius = freezed,Object? minPh = freezed,Object? maxPh = freezed,Object? lifespanYears = freezed,Object? dateAdded = freezed,Object? dateDeceased = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? isQuarantined = null,Object? quarantineEndDate = freezed,Object? notes = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_FishEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,commonName: freezed == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,waterType: null == waterType ? _self.waterType : waterType // ignore: cast_nullable_to_non_nullable
as WaterType,temperament: freezed == temperament ? _self.temperament : temperament // ignore: cast_nullable_to_non_nullable
as FishTemperament?,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as FishDiet?,careLevel: freezed == careLevel ? _self.careLevel : careLevel // ignore: cast_nullable_to_non_nullable
as CareLevel?,swimmingLevel: freezed == swimmingLevel ? _self.swimmingLevel : swimmingLevel // ignore: cast_nullable_to_non_nullable
as SwimmingLevel?,maxSizeCm: freezed == maxSizeCm ? _self.maxSizeCm : maxSizeCm // ignore: cast_nullable_to_non_nullable
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
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
