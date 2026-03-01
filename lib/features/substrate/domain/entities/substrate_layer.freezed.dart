// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'substrate_layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubstrateLayerEntity {

/// Unique identifier (null for new layers)
 int? get id;/// Foreign key to tank
 int get tankId;/// Layer name/label
 String get name;/// Type of substrate
 SubstrateType get substrateType;/// Brand name (e.g., ADA, Fluval, Seachem)
 String? get brand;/// Depth of this layer in cm
 double? get depthCm;/// Layer order (0 = bottom, higher = top)
 int get layerOrder;/// Volume in liters
 double? get volumeLiters;/// Weight in kg
 double? get weightKg;/// Color of the substrate
 String? get color;/// Purchase price
 double? get purchasePrice;/// Source/store where purchased
 String? get source;/// Date added to tank
 DateTime? get dateAdded;/// Photo URL or path
 String? get photoUrl;/// Notes/additional info
 String? get notes;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of SubstrateLayerEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubstrateLayerEntityCopyWith<SubstrateLayerEntity> get copyWith => _$SubstrateLayerEntityCopyWithImpl<SubstrateLayerEntity>(this as SubstrateLayerEntity, _$identity);

  /// Serializes this SubstrateLayerEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubstrateLayerEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.substrateType, substrateType) || other.substrateType == substrateType)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.depthCm, depthCm) || other.depthCm == depthCm)&&(identical(other.layerOrder, layerOrder) || other.layerOrder == layerOrder)&&(identical(other.volumeLiters, volumeLiters) || other.volumeLiters == volumeLiters)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.color, color) || other.color == color)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,substrateType,brand,depthCm,layerOrder,volumeLiters,weightKg,color,purchasePrice,source,dateAdded,photoUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'SubstrateLayerEntity(id: $id, tankId: $tankId, name: $name, substrateType: $substrateType, brand: $brand, depthCm: $depthCm, layerOrder: $layerOrder, volumeLiters: $volumeLiters, weightKg: $weightKg, color: $color, purchasePrice: $purchasePrice, source: $source, dateAdded: $dateAdded, photoUrl: $photoUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SubstrateLayerEntityCopyWith<$Res>  {
  factory $SubstrateLayerEntityCopyWith(SubstrateLayerEntity value, $Res Function(SubstrateLayerEntity) _then) = _$SubstrateLayerEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String name, SubstrateType substrateType, String? brand, double? depthCm, int layerOrder, double? volumeLiters, double? weightKg, String? color, double? purchasePrice, String? source, DateTime? dateAdded, String? photoUrl, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$SubstrateLayerEntityCopyWithImpl<$Res>
    implements $SubstrateLayerEntityCopyWith<$Res> {
  _$SubstrateLayerEntityCopyWithImpl(this._self, this._then);

  final SubstrateLayerEntity _self;
  final $Res Function(SubstrateLayerEntity) _then;

/// Create a copy of SubstrateLayerEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? substrateType = null,Object? brand = freezed,Object? depthCm = freezed,Object? layerOrder = null,Object? volumeLiters = freezed,Object? weightKg = freezed,Object? color = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? dateAdded = freezed,Object? photoUrl = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,substrateType: null == substrateType ? _self.substrateType : substrateType // ignore: cast_nullable_to_non_nullable
as SubstrateType,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,depthCm: freezed == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double?,layerOrder: null == layerOrder ? _self.layerOrder : layerOrder // ignore: cast_nullable_to_non_nullable
as int,volumeLiters: freezed == volumeLiters ? _self.volumeLiters : volumeLiters // ignore: cast_nullable_to_non_nullable
as double?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubstrateLayerEntity].
extension SubstrateLayerEntityPatterns on SubstrateLayerEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubstrateLayerEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubstrateLayerEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubstrateLayerEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubstrateLayerEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubstrateLayerEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubstrateLayerEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  SubstrateType substrateType,  String? brand,  double? depthCm,  int layerOrder,  double? volumeLiters,  double? weightKg,  String? color,  double? purchasePrice,  String? source,  DateTime? dateAdded,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubstrateLayerEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.substrateType,_that.brand,_that.depthCm,_that.layerOrder,_that.volumeLiters,_that.weightKg,_that.color,_that.purchasePrice,_that.source,_that.dateAdded,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  SubstrateType substrateType,  String? brand,  double? depthCm,  int layerOrder,  double? volumeLiters,  double? weightKg,  String? color,  double? purchasePrice,  String? source,  DateTime? dateAdded,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SubstrateLayerEntity():
return $default(_that.id,_that.tankId,_that.name,_that.substrateType,_that.brand,_that.depthCm,_that.layerOrder,_that.volumeLiters,_that.weightKg,_that.color,_that.purchasePrice,_that.source,_that.dateAdded,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String name,  SubstrateType substrateType,  String? brand,  double? depthCm,  int layerOrder,  double? volumeLiters,  double? weightKg,  String? color,  double? purchasePrice,  String? source,  DateTime? dateAdded,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SubstrateLayerEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.substrateType,_that.brand,_that.depthCm,_that.layerOrder,_that.volumeLiters,_that.weightKg,_that.color,_that.purchasePrice,_that.source,_that.dateAdded,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubstrateLayerEntity extends SubstrateLayerEntity {
  const _SubstrateLayerEntity({this.id, required this.tankId, required this.name, required this.substrateType, this.brand, this.depthCm, this.layerOrder = 0, this.volumeLiters, this.weightKg, this.color, this.purchasePrice, this.source, this.dateAdded, this.photoUrl, this.notes, this.createdAt, this.updatedAt}): super._();
  factory _SubstrateLayerEntity.fromJson(Map<String, dynamic> json) => _$SubstrateLayerEntityFromJson(json);

/// Unique identifier (null for new layers)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Layer name/label
@override final  String name;
/// Type of substrate
@override final  SubstrateType substrateType;
/// Brand name (e.g., ADA, Fluval, Seachem)
@override final  String? brand;
/// Depth of this layer in cm
@override final  double? depthCm;
/// Layer order (0 = bottom, higher = top)
@override@JsonKey() final  int layerOrder;
/// Volume in liters
@override final  double? volumeLiters;
/// Weight in kg
@override final  double? weightKg;
/// Color of the substrate
@override final  String? color;
/// Purchase price
@override final  double? purchasePrice;
/// Source/store where purchased
@override final  String? source;
/// Date added to tank
@override final  DateTime? dateAdded;
/// Photo URL or path
@override final  String? photoUrl;
/// Notes/additional info
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of SubstrateLayerEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubstrateLayerEntityCopyWith<_SubstrateLayerEntity> get copyWith => __$SubstrateLayerEntityCopyWithImpl<_SubstrateLayerEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubstrateLayerEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubstrateLayerEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.substrateType, substrateType) || other.substrateType == substrateType)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.depthCm, depthCm) || other.depthCm == depthCm)&&(identical(other.layerOrder, layerOrder) || other.layerOrder == layerOrder)&&(identical(other.volumeLiters, volumeLiters) || other.volumeLiters == volumeLiters)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.color, color) || other.color == color)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,substrateType,brand,depthCm,layerOrder,volumeLiters,weightKg,color,purchasePrice,source,dateAdded,photoUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'SubstrateLayerEntity(id: $id, tankId: $tankId, name: $name, substrateType: $substrateType, brand: $brand, depthCm: $depthCm, layerOrder: $layerOrder, volumeLiters: $volumeLiters, weightKg: $weightKg, color: $color, purchasePrice: $purchasePrice, source: $source, dateAdded: $dateAdded, photoUrl: $photoUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SubstrateLayerEntityCopyWith<$Res> implements $SubstrateLayerEntityCopyWith<$Res> {
  factory _$SubstrateLayerEntityCopyWith(_SubstrateLayerEntity value, $Res Function(_SubstrateLayerEntity) _then) = __$SubstrateLayerEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String name, SubstrateType substrateType, String? brand, double? depthCm, int layerOrder, double? volumeLiters, double? weightKg, String? color, double? purchasePrice, String? source, DateTime? dateAdded, String? photoUrl, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$SubstrateLayerEntityCopyWithImpl<$Res>
    implements _$SubstrateLayerEntityCopyWith<$Res> {
  __$SubstrateLayerEntityCopyWithImpl(this._self, this._then);

  final _SubstrateLayerEntity _self;
  final $Res Function(_SubstrateLayerEntity) _then;

/// Create a copy of SubstrateLayerEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? substrateType = null,Object? brand = freezed,Object? depthCm = freezed,Object? layerOrder = null,Object? volumeLiters = freezed,Object? weightKg = freezed,Object? color = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? dateAdded = freezed,Object? photoUrl = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SubstrateLayerEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,substrateType: null == substrateType ? _self.substrateType : substrateType // ignore: cast_nullable_to_non_nullable
as SubstrateType,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,depthCm: freezed == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double?,layerOrder: null == layerOrder ? _self.layerOrder : layerOrder // ignore: cast_nullable_to_non_nullable
as int,volumeLiters: freezed == volumeLiters ? _self.volumeLiters : volumeLiters // ignore: cast_nullable_to_non_nullable
as double?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
