// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantEntity {

/// Unique identifier (null for new plants)
 int? get id;/// Tank this plant belongs to
 int get tankId;/// Species scientific name
 String get species;/// Common name
 String? get commonName;/// Type of plant
 PlantType get plantType;/// Number of this species in tank
 int get quantity;/// Placement zone in tank
 PlacementZone? get placementZone;/// Lighting requirement
 LightingRequirement? get lightingRequirement;/// CO2 requirement
 CO2Requirement get co2Requirement;/// Growth rate
 GrowthRate? get growthRate;/// Difficulty level
 PlantDifficultyLevel? get difficultyLevel;/// Maximum height in cm
 double? get maxHeightCm;/// Current height in cm
 double? get currentHeightCm;/// Minimum temperature in Celsius
 double? get minTempCelsius;/// Maximum temperature in Celsius
 double? get maxTempCelsius;/// Minimum pH
 double? get minPh;/// Maximum pH
 double? get maxPh;/// Date added to tank
 DateTime? get dateAdded;/// Date removed from tank
 DateTime? get dateRemoved;/// Is this plant propagated from another
 bool get isPropagated;/// Parent plant ID (if propagated)
 int? get parentPlantId;/// Purchase price
 double? get purchasePrice;/// Source/store where purchased
 String? get source;/// Notes/additional info
 String? get notes;/// Photo URL or path
 String? get photoUrl;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of PlantEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlantEntityCopyWith<PlantEntity> get copyWith => _$PlantEntityCopyWithImpl<PlantEntity>(this as PlantEntity, _$identity);

  /// Serializes this PlantEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.species, species) || other.species == species)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.plantType, plantType) || other.plantType == plantType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.placementZone, placementZone) || other.placementZone == placementZone)&&(identical(other.lightingRequirement, lightingRequirement) || other.lightingRequirement == lightingRequirement)&&(identical(other.co2Requirement, co2Requirement) || other.co2Requirement == co2Requirement)&&(identical(other.growthRate, growthRate) || other.growthRate == growthRate)&&(identical(other.difficultyLevel, difficultyLevel) || other.difficultyLevel == difficultyLevel)&&(identical(other.maxHeightCm, maxHeightCm) || other.maxHeightCm == maxHeightCm)&&(identical(other.currentHeightCm, currentHeightCm) || other.currentHeightCm == currentHeightCm)&&(identical(other.minTempCelsius, minTempCelsius) || other.minTempCelsius == minTempCelsius)&&(identical(other.maxTempCelsius, maxTempCelsius) || other.maxTempCelsius == maxTempCelsius)&&(identical(other.minPh, minPh) || other.minPh == minPh)&&(identical(other.maxPh, maxPh) || other.maxPh == maxPh)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.dateRemoved, dateRemoved) || other.dateRemoved == dateRemoved)&&(identical(other.isPropagated, isPropagated) || other.isPropagated == isPropagated)&&(identical(other.parentPlantId, parentPlantId) || other.parentPlantId == parentPlantId)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,species,commonName,plantType,quantity,placementZone,lightingRequirement,co2Requirement,growthRate,difficultyLevel,maxHeightCm,currentHeightCm,minTempCelsius,maxTempCelsius,minPh,maxPh,dateAdded,dateRemoved,isPropagated,parentPlantId,purchasePrice,source,notes,photoUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'PlantEntity(id: $id, tankId: $tankId, species: $species, commonName: $commonName, plantType: $plantType, quantity: $quantity, placementZone: $placementZone, lightingRequirement: $lightingRequirement, co2Requirement: $co2Requirement, growthRate: $growthRate, difficultyLevel: $difficultyLevel, maxHeightCm: $maxHeightCm, currentHeightCm: $currentHeightCm, minTempCelsius: $minTempCelsius, maxTempCelsius: $maxTempCelsius, minPh: $minPh, maxPh: $maxPh, dateAdded: $dateAdded, dateRemoved: $dateRemoved, isPropagated: $isPropagated, parentPlantId: $parentPlantId, purchasePrice: $purchasePrice, source: $source, notes: $notes, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlantEntityCopyWith<$Res>  {
  factory $PlantEntityCopyWith(PlantEntity value, $Res Function(PlantEntity) _then) = _$PlantEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String species, String? commonName, PlantType plantType, int quantity, PlacementZone? placementZone, LightingRequirement? lightingRequirement, CO2Requirement co2Requirement, GrowthRate? growthRate, PlantDifficultyLevel? difficultyLevel, double? maxHeightCm, double? currentHeightCm, double? minTempCelsius, double? maxTempCelsius, double? minPh, double? maxPh, DateTime? dateAdded, DateTime? dateRemoved, bool isPropagated, int? parentPlantId, double? purchasePrice, String? source, String? notes, String? photoUrl, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PlantEntityCopyWithImpl<$Res>
    implements $PlantEntityCopyWith<$Res> {
  _$PlantEntityCopyWithImpl(this._self, this._then);

  final PlantEntity _self;
  final $Res Function(PlantEntity) _then;

/// Create a copy of PlantEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? species = null,Object? commonName = freezed,Object? plantType = null,Object? quantity = null,Object? placementZone = freezed,Object? lightingRequirement = freezed,Object? co2Requirement = null,Object? growthRate = freezed,Object? difficultyLevel = freezed,Object? maxHeightCm = freezed,Object? currentHeightCm = freezed,Object? minTempCelsius = freezed,Object? maxTempCelsius = freezed,Object? minPh = freezed,Object? maxPh = freezed,Object? dateAdded = freezed,Object? dateRemoved = freezed,Object? isPropagated = null,Object? parentPlantId = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? notes = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,commonName: freezed == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String?,plantType: null == plantType ? _self.plantType : plantType // ignore: cast_nullable_to_non_nullable
as PlantType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,placementZone: freezed == placementZone ? _self.placementZone : placementZone // ignore: cast_nullable_to_non_nullable
as PlacementZone?,lightingRequirement: freezed == lightingRequirement ? _self.lightingRequirement : lightingRequirement // ignore: cast_nullable_to_non_nullable
as LightingRequirement?,co2Requirement: null == co2Requirement ? _self.co2Requirement : co2Requirement // ignore: cast_nullable_to_non_nullable
as CO2Requirement,growthRate: freezed == growthRate ? _self.growthRate : growthRate // ignore: cast_nullable_to_non_nullable
as GrowthRate?,difficultyLevel: freezed == difficultyLevel ? _self.difficultyLevel : difficultyLevel // ignore: cast_nullable_to_non_nullable
as PlantDifficultyLevel?,maxHeightCm: freezed == maxHeightCm ? _self.maxHeightCm : maxHeightCm // ignore: cast_nullable_to_non_nullable
as double?,currentHeightCm: freezed == currentHeightCm ? _self.currentHeightCm : currentHeightCm // ignore: cast_nullable_to_non_nullable
as double?,minTempCelsius: freezed == minTempCelsius ? _self.minTempCelsius : minTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,maxTempCelsius: freezed == maxTempCelsius ? _self.maxTempCelsius : maxTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,minPh: freezed == minPh ? _self.minPh : minPh // ignore: cast_nullable_to_non_nullable
as double?,maxPh: freezed == maxPh ? _self.maxPh : maxPh // ignore: cast_nullable_to_non_nullable
as double?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,dateRemoved: freezed == dateRemoved ? _self.dateRemoved : dateRemoved // ignore: cast_nullable_to_non_nullable
as DateTime?,isPropagated: null == isPropagated ? _self.isPropagated : isPropagated // ignore: cast_nullable_to_non_nullable
as bool,parentPlantId: freezed == parentPlantId ? _self.parentPlantId : parentPlantId // ignore: cast_nullable_to_non_nullable
as int?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlantEntity].
extension PlantEntityPatterns on PlantEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlantEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlantEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlantEntity value)  $default,){
final _that = this;
switch (_that) {
case _PlantEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlantEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PlantEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String species,  String? commonName,  PlantType plantType,  int quantity,  PlacementZone? placementZone,  LightingRequirement? lightingRequirement,  CO2Requirement co2Requirement,  GrowthRate? growthRate,  PlantDifficultyLevel? difficultyLevel,  double? maxHeightCm,  double? currentHeightCm,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  DateTime? dateAdded,  DateTime? dateRemoved,  bool isPropagated,  int? parentPlantId,  double? purchasePrice,  String? source,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlantEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.plantType,_that.quantity,_that.placementZone,_that.lightingRequirement,_that.co2Requirement,_that.growthRate,_that.difficultyLevel,_that.maxHeightCm,_that.currentHeightCm,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.dateAdded,_that.dateRemoved,_that.isPropagated,_that.parentPlantId,_that.purchasePrice,_that.source,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String species,  String? commonName,  PlantType plantType,  int quantity,  PlacementZone? placementZone,  LightingRequirement? lightingRequirement,  CO2Requirement co2Requirement,  GrowthRate? growthRate,  PlantDifficultyLevel? difficultyLevel,  double? maxHeightCm,  double? currentHeightCm,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  DateTime? dateAdded,  DateTime? dateRemoved,  bool isPropagated,  int? parentPlantId,  double? purchasePrice,  String? source,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlantEntity():
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.plantType,_that.quantity,_that.placementZone,_that.lightingRequirement,_that.co2Requirement,_that.growthRate,_that.difficultyLevel,_that.maxHeightCm,_that.currentHeightCm,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.dateAdded,_that.dateRemoved,_that.isPropagated,_that.parentPlantId,_that.purchasePrice,_that.source,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String species,  String? commonName,  PlantType plantType,  int quantity,  PlacementZone? placementZone,  LightingRequirement? lightingRequirement,  CO2Requirement co2Requirement,  GrowthRate? growthRate,  PlantDifficultyLevel? difficultyLevel,  double? maxHeightCm,  double? currentHeightCm,  double? minTempCelsius,  double? maxTempCelsius,  double? minPh,  double? maxPh,  DateTime? dateAdded,  DateTime? dateRemoved,  bool isPropagated,  int? parentPlantId,  double? purchasePrice,  String? source,  String? notes,  String? photoUrl,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlantEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.species,_that.commonName,_that.plantType,_that.quantity,_that.placementZone,_that.lightingRequirement,_that.co2Requirement,_that.growthRate,_that.difficultyLevel,_that.maxHeightCm,_that.currentHeightCm,_that.minTempCelsius,_that.maxTempCelsius,_that.minPh,_that.maxPh,_that.dateAdded,_that.dateRemoved,_that.isPropagated,_that.parentPlantId,_that.purchasePrice,_that.source,_that.notes,_that.photoUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlantEntity extends PlantEntity {
  const _PlantEntity({this.id, required this.tankId, required this.species, this.commonName, this.plantType = PlantType.stem, this.quantity = 1, this.placementZone, this.lightingRequirement, this.co2Requirement = CO2Requirement.none, this.growthRate, this.difficultyLevel, this.maxHeightCm, this.currentHeightCm, this.minTempCelsius, this.maxTempCelsius, this.minPh, this.maxPh, this.dateAdded, this.dateRemoved, this.isPropagated = false, this.parentPlantId, this.purchasePrice, this.source, this.notes, this.photoUrl, this.createdAt, this.updatedAt}): super._();
  factory _PlantEntity.fromJson(Map<String, dynamic> json) => _$PlantEntityFromJson(json);

/// Unique identifier (null for new plants)
@override final  int? id;
/// Tank this plant belongs to
@override final  int tankId;
/// Species scientific name
@override final  String species;
/// Common name
@override final  String? commonName;
/// Type of plant
@override@JsonKey() final  PlantType plantType;
/// Number of this species in tank
@override@JsonKey() final  int quantity;
/// Placement zone in tank
@override final  PlacementZone? placementZone;
/// Lighting requirement
@override final  LightingRequirement? lightingRequirement;
/// CO2 requirement
@override@JsonKey() final  CO2Requirement co2Requirement;
/// Growth rate
@override final  GrowthRate? growthRate;
/// Difficulty level
@override final  PlantDifficultyLevel? difficultyLevel;
/// Maximum height in cm
@override final  double? maxHeightCm;
/// Current height in cm
@override final  double? currentHeightCm;
/// Minimum temperature in Celsius
@override final  double? minTempCelsius;
/// Maximum temperature in Celsius
@override final  double? maxTempCelsius;
/// Minimum pH
@override final  double? minPh;
/// Maximum pH
@override final  double? maxPh;
/// Date added to tank
@override final  DateTime? dateAdded;
/// Date removed from tank
@override final  DateTime? dateRemoved;
/// Is this plant propagated from another
@override@JsonKey() final  bool isPropagated;
/// Parent plant ID (if propagated)
@override final  int? parentPlantId;
/// Purchase price
@override final  double? purchasePrice;
/// Source/store where purchased
@override final  String? source;
/// Notes/additional info
@override final  String? notes;
/// Photo URL or path
@override final  String? photoUrl;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of PlantEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlantEntityCopyWith<_PlantEntity> get copyWith => __$PlantEntityCopyWithImpl<_PlantEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlantEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.species, species) || other.species == species)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.plantType, plantType) || other.plantType == plantType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.placementZone, placementZone) || other.placementZone == placementZone)&&(identical(other.lightingRequirement, lightingRequirement) || other.lightingRequirement == lightingRequirement)&&(identical(other.co2Requirement, co2Requirement) || other.co2Requirement == co2Requirement)&&(identical(other.growthRate, growthRate) || other.growthRate == growthRate)&&(identical(other.difficultyLevel, difficultyLevel) || other.difficultyLevel == difficultyLevel)&&(identical(other.maxHeightCm, maxHeightCm) || other.maxHeightCm == maxHeightCm)&&(identical(other.currentHeightCm, currentHeightCm) || other.currentHeightCm == currentHeightCm)&&(identical(other.minTempCelsius, minTempCelsius) || other.minTempCelsius == minTempCelsius)&&(identical(other.maxTempCelsius, maxTempCelsius) || other.maxTempCelsius == maxTempCelsius)&&(identical(other.minPh, minPh) || other.minPh == minPh)&&(identical(other.maxPh, maxPh) || other.maxPh == maxPh)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.dateRemoved, dateRemoved) || other.dateRemoved == dateRemoved)&&(identical(other.isPropagated, isPropagated) || other.isPropagated == isPropagated)&&(identical(other.parentPlantId, parentPlantId) || other.parentPlantId == parentPlantId)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tankId,species,commonName,plantType,quantity,placementZone,lightingRequirement,co2Requirement,growthRate,difficultyLevel,maxHeightCm,currentHeightCm,minTempCelsius,maxTempCelsius,minPh,maxPh,dateAdded,dateRemoved,isPropagated,parentPlantId,purchasePrice,source,notes,photoUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'PlantEntity(id: $id, tankId: $tankId, species: $species, commonName: $commonName, plantType: $plantType, quantity: $quantity, placementZone: $placementZone, lightingRequirement: $lightingRequirement, co2Requirement: $co2Requirement, growthRate: $growthRate, difficultyLevel: $difficultyLevel, maxHeightCm: $maxHeightCm, currentHeightCm: $currentHeightCm, minTempCelsius: $minTempCelsius, maxTempCelsius: $maxTempCelsius, minPh: $minPh, maxPh: $maxPh, dateAdded: $dateAdded, dateRemoved: $dateRemoved, isPropagated: $isPropagated, parentPlantId: $parentPlantId, purchasePrice: $purchasePrice, source: $source, notes: $notes, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlantEntityCopyWith<$Res> implements $PlantEntityCopyWith<$Res> {
  factory _$PlantEntityCopyWith(_PlantEntity value, $Res Function(_PlantEntity) _then) = __$PlantEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String species, String? commonName, PlantType plantType, int quantity, PlacementZone? placementZone, LightingRequirement? lightingRequirement, CO2Requirement co2Requirement, GrowthRate? growthRate, PlantDifficultyLevel? difficultyLevel, double? maxHeightCm, double? currentHeightCm, double? minTempCelsius, double? maxTempCelsius, double? minPh, double? maxPh, DateTime? dateAdded, DateTime? dateRemoved, bool isPropagated, int? parentPlantId, double? purchasePrice, String? source, String? notes, String? photoUrl, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PlantEntityCopyWithImpl<$Res>
    implements _$PlantEntityCopyWith<$Res> {
  __$PlantEntityCopyWithImpl(this._self, this._then);

  final _PlantEntity _self;
  final $Res Function(_PlantEntity) _then;

/// Create a copy of PlantEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? species = null,Object? commonName = freezed,Object? plantType = null,Object? quantity = null,Object? placementZone = freezed,Object? lightingRequirement = freezed,Object? co2Requirement = null,Object? growthRate = freezed,Object? difficultyLevel = freezed,Object? maxHeightCm = freezed,Object? currentHeightCm = freezed,Object? minTempCelsius = freezed,Object? maxTempCelsius = freezed,Object? minPh = freezed,Object? maxPh = freezed,Object? dateAdded = freezed,Object? dateRemoved = freezed,Object? isPropagated = null,Object? parentPlantId = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? notes = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_PlantEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,commonName: freezed == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String?,plantType: null == plantType ? _self.plantType : plantType // ignore: cast_nullable_to_non_nullable
as PlantType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,placementZone: freezed == placementZone ? _self.placementZone : placementZone // ignore: cast_nullable_to_non_nullable
as PlacementZone?,lightingRequirement: freezed == lightingRequirement ? _self.lightingRequirement : lightingRequirement // ignore: cast_nullable_to_non_nullable
as LightingRequirement?,co2Requirement: null == co2Requirement ? _self.co2Requirement : co2Requirement // ignore: cast_nullable_to_non_nullable
as CO2Requirement,growthRate: freezed == growthRate ? _self.growthRate : growthRate // ignore: cast_nullable_to_non_nullable
as GrowthRate?,difficultyLevel: freezed == difficultyLevel ? _self.difficultyLevel : difficultyLevel // ignore: cast_nullable_to_non_nullable
as PlantDifficultyLevel?,maxHeightCm: freezed == maxHeightCm ? _self.maxHeightCm : maxHeightCm // ignore: cast_nullable_to_non_nullable
as double?,currentHeightCm: freezed == currentHeightCm ? _self.currentHeightCm : currentHeightCm // ignore: cast_nullable_to_non_nullable
as double?,minTempCelsius: freezed == minTempCelsius ? _self.minTempCelsius : minTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,maxTempCelsius: freezed == maxTempCelsius ? _self.maxTempCelsius : maxTempCelsius // ignore: cast_nullable_to_non_nullable
as double?,minPh: freezed == minPh ? _self.minPh : minPh // ignore: cast_nullable_to_non_nullable
as double?,maxPh: freezed == maxPh ? _self.maxPh : maxPh // ignore: cast_nullable_to_non_nullable
as double?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,dateRemoved: freezed == dateRemoved ? _self.dateRemoved : dateRemoved // ignore: cast_nullable_to_non_nullable
as DateTime?,isPropagated: null == isPropagated ? _self.isPropagated : isPropagated // ignore: cast_nullable_to_non_nullable
as bool,parentPlantId: freezed == parentPlantId ? _self.parentPlantId : parentPlantId // ignore: cast_nullable_to_non_nullable
as int?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
