// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feeding_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedingLogEntity {

/// Unique identifier (null for new logs)
 int? get id;/// Foreign key to tank
 int get tankId;/// Type of food given
 FoodType get foodType;/// Food brand/name (optional)
 String? get foodName;/// Amount description (e.g., "pinch", "2 pellets", "1 cube")
 String? get amount;/// Fish response to the feeding
 FeedingResponse get response;/// When the feeding occurred
 DateTime get fedAt;/// Additional notes
 String? get notes;/// Created timestamp
 DateTime? get createdAt;
/// Create a copy of FeedingLogEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedingLogEntityCopyWith<FeedingLogEntity> get copyWith => _$FeedingLogEntityCopyWithImpl<FeedingLogEntity>(this as FeedingLogEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedingLogEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.foodType, foodType) || other.foodType == foodType)&&(identical(other.foodName, foodName) || other.foodName == foodName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.response, response) || other.response == response)&&(identical(other.fedAt, fedAt) || other.fedAt == fedAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tankId,foodType,foodName,amount,response,fedAt,notes,createdAt);

@override
String toString() {
  return 'FeedingLogEntity(id: $id, tankId: $tankId, foodType: $foodType, foodName: $foodName, amount: $amount, response: $response, fedAt: $fedAt, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FeedingLogEntityCopyWith<$Res>  {
  factory $FeedingLogEntityCopyWith(FeedingLogEntity value, $Res Function(FeedingLogEntity) _then) = _$FeedingLogEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, FoodType foodType, String? foodName, String? amount, FeedingResponse response, DateTime fedAt, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$FeedingLogEntityCopyWithImpl<$Res>
    implements $FeedingLogEntityCopyWith<$Res> {
  _$FeedingLogEntityCopyWithImpl(this._self, this._then);

  final FeedingLogEntity _self;
  final $Res Function(FeedingLogEntity) _then;

/// Create a copy of FeedingLogEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? foodType = null,Object? foodName = freezed,Object? amount = freezed,Object? response = null,Object? fedAt = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,foodType: null == foodType ? _self.foodType : foodType // ignore: cast_nullable_to_non_nullable
as FoodType,foodName: freezed == foodName ? _self.foodName : foodName // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as FeedingResponse,fedAt: null == fedAt ? _self.fedAt : fedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedingLogEntity].
extension FeedingLogEntityPatterns on FeedingLogEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedingLogEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedingLogEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedingLogEntity value)  $default,){
final _that = this;
switch (_that) {
case _FeedingLogEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedingLogEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FeedingLogEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  FoodType foodType,  String? foodName,  String? amount,  FeedingResponse response,  DateTime fedAt,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedingLogEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.foodType,_that.foodName,_that.amount,_that.response,_that.fedAt,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  FoodType foodType,  String? foodName,  String? amount,  FeedingResponse response,  DateTime fedAt,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _FeedingLogEntity():
return $default(_that.id,_that.tankId,_that.foodType,_that.foodName,_that.amount,_that.response,_that.fedAt,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  FoodType foodType,  String? foodName,  String? amount,  FeedingResponse response,  DateTime fedAt,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FeedingLogEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.foodType,_that.foodName,_that.amount,_that.response,_that.fedAt,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _FeedingLogEntity extends FeedingLogEntity {
  const _FeedingLogEntity({this.id, required this.tankId, required this.foodType, this.foodName, this.amount, this.response = FeedingResponse.unknown, required this.fedAt, this.notes, this.createdAt}): super._();
  

/// Unique identifier (null for new logs)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Type of food given
@override final  FoodType foodType;
/// Food brand/name (optional)
@override final  String? foodName;
/// Amount description (e.g., "pinch", "2 pellets", "1 cube")
@override final  String? amount;
/// Fish response to the feeding
@override@JsonKey() final  FeedingResponse response;
/// When the feeding occurred
@override final  DateTime fedAt;
/// Additional notes
@override final  String? notes;
/// Created timestamp
@override final  DateTime? createdAt;

/// Create a copy of FeedingLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedingLogEntityCopyWith<_FeedingLogEntity> get copyWith => __$FeedingLogEntityCopyWithImpl<_FeedingLogEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedingLogEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.foodType, foodType) || other.foodType == foodType)&&(identical(other.foodName, foodName) || other.foodName == foodName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.response, response) || other.response == response)&&(identical(other.fedAt, fedAt) || other.fedAt == fedAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tankId,foodType,foodName,amount,response,fedAt,notes,createdAt);

@override
String toString() {
  return 'FeedingLogEntity(id: $id, tankId: $tankId, foodType: $foodType, foodName: $foodName, amount: $amount, response: $response, fedAt: $fedAt, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FeedingLogEntityCopyWith<$Res> implements $FeedingLogEntityCopyWith<$Res> {
  factory _$FeedingLogEntityCopyWith(_FeedingLogEntity value, $Res Function(_FeedingLogEntity) _then) = __$FeedingLogEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, FoodType foodType, String? foodName, String? amount, FeedingResponse response, DateTime fedAt, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$FeedingLogEntityCopyWithImpl<$Res>
    implements _$FeedingLogEntityCopyWith<$Res> {
  __$FeedingLogEntityCopyWithImpl(this._self, this._then);

  final _FeedingLogEntity _self;
  final $Res Function(_FeedingLogEntity) _then;

/// Create a copy of FeedingLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? foodType = null,Object? foodName = freezed,Object? amount = freezed,Object? response = null,Object? fedAt = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_FeedingLogEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,foodType: null == foodType ? _self.foodType : foodType // ignore: cast_nullable_to_non_nullable
as FoodType,foodName: freezed == foodName ? _self.foodName : foodName // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as FeedingResponse,fedAt: null == fedAt ? _self.fedAt : fedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
