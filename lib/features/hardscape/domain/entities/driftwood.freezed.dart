// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driftwood.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriftwoodEntity {

/// Unique identifier (null for new driftwood)
 int? get id;/// Foreign key to tank
 int get tankId;/// Driftwood name/label
 String get name;/// Type of driftwood
 DriftwoodType get driftwoodType;/// Whether the wood has been properly cured/waterlogged
 bool get isCured;/// Whether the wood is currently releasing tannins
 bool get isReleasingTannins;/// Quantity of pieces
 int get quantity;/// Length in cm (longest dimension)
 double? get lengthCm;/// Width in cm
 double? get widthCm;/// Height in cm
 double? get heightCm;/// Purchase price
 double? get purchasePrice;/// Source/store where purchased
 String? get source;/// Date added to tank
 DateTime? get dateAdded;/// Date curing was started (soaking)
 DateTime? get curingStartDate;/// Photo URL or path
 String? get photoUrl;/// Notes/additional info
 String? get notes;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of DriftwoodEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriftwoodEntityCopyWith<DriftwoodEntity> get copyWith => _$DriftwoodEntityCopyWithImpl<DriftwoodEntity>(this as DriftwoodEntity, _$identity);

  /// Serializes this DriftwoodEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriftwoodEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.driftwoodType, driftwoodType) || other.driftwoodType == driftwoodType)&&(identical(other.isCured, isCured) || other.isCured == isCured)&&(identical(other.isReleasingTannins, isReleasingTannins) || other.isReleasingTannins == isReleasingTannins)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.widthCm, widthCm) || other.widthCm == widthCm)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.curingStartDate, curingStartDate) || other.curingStartDate == curingStartDate)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,driftwoodType,isCured,isReleasingTannins,quantity,lengthCm,widthCm,heightCm,purchasePrice,source,dateAdded,curingStartDate,photoUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'DriftwoodEntity(id: $id, tankId: $tankId, name: $name, driftwoodType: $driftwoodType, isCured: $isCured, isReleasingTannins: $isReleasingTannins, quantity: $quantity, lengthCm: $lengthCm, widthCm: $widthCm, heightCm: $heightCm, purchasePrice: $purchasePrice, source: $source, dateAdded: $dateAdded, curingStartDate: $curingStartDate, photoUrl: $photoUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DriftwoodEntityCopyWith<$Res>  {
  factory $DriftwoodEntityCopyWith(DriftwoodEntity value, $Res Function(DriftwoodEntity) _then) = _$DriftwoodEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String name, DriftwoodType driftwoodType, bool isCured, bool isReleasingTannins, int quantity, double? lengthCm, double? widthCm, double? heightCm, double? purchasePrice, String? source, DateTime? dateAdded, DateTime? curingStartDate, String? photoUrl, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$DriftwoodEntityCopyWithImpl<$Res>
    implements $DriftwoodEntityCopyWith<$Res> {
  _$DriftwoodEntityCopyWithImpl(this._self, this._then);

  final DriftwoodEntity _self;
  final $Res Function(DriftwoodEntity) _then;

/// Create a copy of DriftwoodEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? driftwoodType = null,Object? isCured = null,Object? isReleasingTannins = null,Object? quantity = null,Object? lengthCm = freezed,Object? widthCm = freezed,Object? heightCm = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? dateAdded = freezed,Object? curingStartDate = freezed,Object? photoUrl = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,driftwoodType: null == driftwoodType ? _self.driftwoodType : driftwoodType // ignore: cast_nullable_to_non_nullable
as DriftwoodType,isCured: null == isCured ? _self.isCured : isCured // ignore: cast_nullable_to_non_nullable
as bool,isReleasingTannins: null == isReleasingTannins ? _self.isReleasingTannins : isReleasingTannins // ignore: cast_nullable_to_non_nullable
as bool,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,widthCm: freezed == widthCm ? _self.widthCm : widthCm // ignore: cast_nullable_to_non_nullable
as double?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,curingStartDate: freezed == curingStartDate ? _self.curingStartDate : curingStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriftwoodEntity].
extension DriftwoodEntityPatterns on DriftwoodEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriftwoodEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriftwoodEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriftwoodEntity value)  $default,){
final _that = this;
switch (_that) {
case _DriftwoodEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriftwoodEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DriftwoodEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  DriftwoodType driftwoodType,  bool isCured,  bool isReleasingTannins,  int quantity,  double? lengthCm,  double? widthCm,  double? heightCm,  double? purchasePrice,  String? source,  DateTime? dateAdded,  DateTime? curingStartDate,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriftwoodEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.driftwoodType,_that.isCured,_that.isReleasingTannins,_that.quantity,_that.lengthCm,_that.widthCm,_that.heightCm,_that.purchasePrice,_that.source,_that.dateAdded,_that.curingStartDate,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String name,  DriftwoodType driftwoodType,  bool isCured,  bool isReleasingTannins,  int quantity,  double? lengthCm,  double? widthCm,  double? heightCm,  double? purchasePrice,  String? source,  DateTime? dateAdded,  DateTime? curingStartDate,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DriftwoodEntity():
return $default(_that.id,_that.tankId,_that.name,_that.driftwoodType,_that.isCured,_that.isReleasingTannins,_that.quantity,_that.lengthCm,_that.widthCm,_that.heightCm,_that.purchasePrice,_that.source,_that.dateAdded,_that.curingStartDate,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String name,  DriftwoodType driftwoodType,  bool isCured,  bool isReleasingTannins,  int quantity,  double? lengthCm,  double? widthCm,  double? heightCm,  double? purchasePrice,  String? source,  DateTime? dateAdded,  DateTime? curingStartDate,  String? photoUrl,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DriftwoodEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.name,_that.driftwoodType,_that.isCured,_that.isReleasingTannins,_that.quantity,_that.lengthCm,_that.widthCm,_that.heightCm,_that.purchasePrice,_that.source,_that.dateAdded,_that.curingStartDate,_that.photoUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriftwoodEntity extends DriftwoodEntity {
  const _DriftwoodEntity({this.id, required this.tankId, required this.name, required this.driftwoodType, this.isCured = false, this.isReleasingTannins = true, this.quantity = 1, this.lengthCm, this.widthCm, this.heightCm, this.purchasePrice, this.source, this.dateAdded, this.curingStartDate, this.photoUrl, this.notes, this.createdAt, this.updatedAt}): super._();
  factory _DriftwoodEntity.fromJson(Map<String, dynamic> json) => _$DriftwoodEntityFromJson(json);

/// Unique identifier (null for new driftwood)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Driftwood name/label
@override final  String name;
/// Type of driftwood
@override final  DriftwoodType driftwoodType;
/// Whether the wood has been properly cured/waterlogged
@override@JsonKey() final  bool isCured;
/// Whether the wood is currently releasing tannins
@override@JsonKey() final  bool isReleasingTannins;
/// Quantity of pieces
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
/// Date curing was started (soaking)
@override final  DateTime? curingStartDate;
/// Photo URL or path
@override final  String? photoUrl;
/// Notes/additional info
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of DriftwoodEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriftwoodEntityCopyWith<_DriftwoodEntity> get copyWith => __$DriftwoodEntityCopyWithImpl<_DriftwoodEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriftwoodEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriftwoodEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.name, name) || other.name == name)&&(identical(other.driftwoodType, driftwoodType) || other.driftwoodType == driftwoodType)&&(identical(other.isCured, isCured) || other.isCured == isCured)&&(identical(other.isReleasingTannins, isReleasingTannins) || other.isReleasingTannins == isReleasingTannins)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.widthCm, widthCm) || other.widthCm == widthCm)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.source, source) || other.source == source)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.curingStartDate, curingStartDate) || other.curingStartDate == curingStartDate)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,name,driftwoodType,isCured,isReleasingTannins,quantity,lengthCm,widthCm,heightCm,purchasePrice,source,dateAdded,curingStartDate,photoUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'DriftwoodEntity(id: $id, tankId: $tankId, name: $name, driftwoodType: $driftwoodType, isCured: $isCured, isReleasingTannins: $isReleasingTannins, quantity: $quantity, lengthCm: $lengthCm, widthCm: $widthCm, heightCm: $heightCm, purchasePrice: $purchasePrice, source: $source, dateAdded: $dateAdded, curingStartDate: $curingStartDate, photoUrl: $photoUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DriftwoodEntityCopyWith<$Res> implements $DriftwoodEntityCopyWith<$Res> {
  factory _$DriftwoodEntityCopyWith(_DriftwoodEntity value, $Res Function(_DriftwoodEntity) _then) = __$DriftwoodEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String name, DriftwoodType driftwoodType, bool isCured, bool isReleasingTannins, int quantity, double? lengthCm, double? widthCm, double? heightCm, double? purchasePrice, String? source, DateTime? dateAdded, DateTime? curingStartDate, String? photoUrl, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$DriftwoodEntityCopyWithImpl<$Res>
    implements _$DriftwoodEntityCopyWith<$Res> {
  __$DriftwoodEntityCopyWithImpl(this._self, this._then);

  final _DriftwoodEntity _self;
  final $Res Function(_DriftwoodEntity) _then;

/// Create a copy of DriftwoodEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? name = null,Object? driftwoodType = null,Object? isCured = null,Object? isReleasingTannins = null,Object? quantity = null,Object? lengthCm = freezed,Object? widthCm = freezed,Object? heightCm = freezed,Object? purchasePrice = freezed,Object? source = freezed,Object? dateAdded = freezed,Object? curingStartDate = freezed,Object? photoUrl = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DriftwoodEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,driftwoodType: null == driftwoodType ? _self.driftwoodType : driftwoodType // ignore: cast_nullable_to_non_nullable
as DriftwoodType,isCured: null == isCured ? _self.isCured : isCured // ignore: cast_nullable_to_non_nullable
as bool,isReleasingTannins: null == isReleasingTannins ? _self.isReleasingTannins : isReleasingTannins // ignore: cast_nullable_to_non_nullable
as bool,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,widthCm: freezed == widthCm ? _self.widthCm : widthCm // ignore: cast_nullable_to_non_nullable
as double?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,curingStartDate: freezed == curingStartDate ? _self.curingStartDate : curingStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
