// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RockEntity {

/// Unique identifier (null for new rocks)
 int? get id;/// Foreign key to tank
 int get tankId;/// Rock name/label
 String get name;/// Type of rock
 RockType get rockType;/// Weight in kilograms
 double? get weightKg;/// Quantity of this rock type
 int get quantity;/// Length in cm (longest dimension)
 double? get lengthCm;/// Width in cm
 double? get widthCm;/// Height in cm
 double? get heightCm;/// Purchase price
 double? get purchasePrice;/// Source/store where purchased
 String? get source;/// Date added to tank
 DateTime? get dateAdded;/// Photo URL or path
 String? get photoUrl;/// Notes/additional info
 String? get notes;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of RockEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RockEntityCopyWith<RockEntity> get copyWith => _$RockEntityCopyWithImpl<RockEntity>(this as RockEntity, _$identity);

  /// Serializes this RockEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RockEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.rockType, rockType) || other.rockType == rockType)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.widthCm, widthCm) || other.widthCm == widthCm)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,rockType,weightKg,quantity,lengthCm,widthCm,heightCm,purchasePrice,source,dateAdded,photoUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'RockEntity(id: $id, tankId: $tankId, name: $name, rockType: $rockType, weightKg: $weightKg, quantity: $quantity, lengthCm: $lengthCm, widthCm: $widthCm, heightCm: $heightCm, purchasePrice: $purchasePrice, source: $source, dateAdded: $dateAdded, photoUrl: $photoUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RockEntityCopyWith<$Res>  {
  factory $RockEntityCopyWith(RockEntity value, $Res Function(RockEntity) _then) = _$RockEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String name, RockType rockType, double? weightKg, int quantity, double? lengthCm, double? widthCm, double? heightCm, double? purchasePrice, String? source, DateTime? dateAdded, String? photoUrl, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$RockEntityCopyWithImpl<$Res>
    implements $RockEntityCopyWith<$Res> {
  _$RockEntityCopyWithImpl(this._self, this._then);

  final RockEntity _self;
  final $Res Function(RockEntity) _then;

/// Create a copy of RockEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? rockType = null,Object? weightKg = freezed,Object? quantity = null,Object? lengthCm = freezed,Object? widthCm = freezed,Object? heightCm = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? dateAdded = freezed,Object? photoUrl = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rockType: null == rockType ? _self.rockType : rockType // ignore: cast_nullable_to_non_nullable
as RockType,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,widthCm: freezed == widthCm ? _self.widthCm : widthCm // ignore: cast_nullable_to_non_nullable
as double?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [RockEntity].
extension RockEntityPatterns on RockEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RockEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RockEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RockEntity value)  $default,){
final _that = this;
switch (_that) {
case _RockEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RockEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RockEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  RockType rockType,  double? weightKg,  int quantity,  double? lengthCm,  double? widthCm,  double? heightCm,  double? purchasePrice,  String? source,  DateTime? dateAdded,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RockEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.rockType,_that.weightKg,_that.quantity,_that.lengthCm,_that.widthCm,_that.heightCm,_that.purchasePrice,_that.source,_that.dateAdded,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  RockType rockType,  double? weightKg,  int quantity,  double? lengthCm,  double? widthCm,  double? heightCm,  double? purchasePrice,  String? source,  DateTime? dateAdded,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RockEntity():
return $default(_that.id,_that.tankId,_that.name,_that.rockType,_that.weightKg,_that.quantity,_that.lengthCm,_that.widthCm,_that.heightCm,_that.purchasePrice,_that.source,_that.dateAdded,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String name,  RockType rockType,  double? weightKg,  int quantity,  double? lengthCm,  double? widthCm,  double? heightCm,  double? purchasePrice,  String? source,  DateTime? dateAdded,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RockEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.rockType,_that.weightKg,_that.quantity,_that.lengthCm,_that.widthCm,_that.heightCm,_that.purchasePrice,_that.source,_that.dateAdded,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RockEntity extends RockEntity {
  const _RockEntity({this.id, required this.tankId, required this.name, required this.rockType, this.weightKg, this.quantity = 1, this.lengthCm, this.widthCm, this.heightCm, this.purchasePrice, this.source, this.dateAdded, this.photoUrl, this.notes, this.createdAt, this.updatedAt}): super._();
  factory _RockEntity.fromJson(Map<String, dynamic> json) => _$RockEntityFromJson(json);

/// Unique identifier (null for new rocks)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Rock name/label
@override final  String name;
/// Type of rock
@override final  RockType rockType;
/// Weight in kilograms
@override final  double? weightKg;
/// Quantity of this rock type
@override@JsonKey() final  int quantity;
/// Length in cm (longest dimension)
@override final  double? lengthCm;
/// Width in cm
@override final  double? widthCm;
/// Height in cm
@override final  double? heightCm;
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

/// Create a copy of RockEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RockEntityCopyWith<_RockEntity> get copyWith => __$RockEntityCopyWithImpl<_RockEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RockEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RockEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.rockType, rockType) || other.rockType == rockType)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.widthCm, widthCm) || other.widthCm == widthCm)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,rockType,weightKg,quantity,lengthCm,widthCm,heightCm,purchasePrice,source,dateAdded,photoUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'RockEntity(id: $id, tankId: $tankId, name: $name, rockType: $rockType, weightKg: $weightKg, quantity: $quantity, lengthCm: $lengthCm, widthCm: $widthCm, heightCm: $heightCm, purchasePrice: $purchasePrice, source: $source, dateAdded: $dateAdded, photoUrl: $photoUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RockEntityCopyWith<$Res> implements $RockEntityCopyWith<$Res> {
  factory _$RockEntityCopyWith(_RockEntity value, $Res Function(_RockEntity) _then) = __$RockEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String name, RockType rockType, double? weightKg, int quantity, double? lengthCm, double? widthCm, double? heightCm, double? purchasePrice, String? source, DateTime? dateAdded, String? photoUrl, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$RockEntityCopyWithImpl<$Res>
    implements _$RockEntityCopyWith<$Res> {
  __$RockEntityCopyWithImpl(this._self, this._then);

  final _RockEntity _self;
  final $Res Function(_RockEntity) _then;

/// Create a copy of RockEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? rockType = null,Object? weightKg = freezed,Object? quantity = null,Object? lengthCm = freezed,Object? widthCm = freezed,Object? heightCm = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? dateAdded = freezed,Object? photoUrl = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_RockEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rockType: null == rockType ? _self.rockType : rockType // ignore: cast_nullable_to_non_nullable
as RockType,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,widthCm: freezed == widthCm ? _self.widthCm : widthCm // ignore: cast_nullable_to_non_nullable
as double?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
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
