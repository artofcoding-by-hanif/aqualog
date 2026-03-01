// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tank_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TankImageEntity {

/// Unique identifier (null for new images)
 int? get id;/// Foreign key to tank
 int get tankId;/// Image file path (local storage)
 String get imagePath;/// Optional caption/description
 String? get caption;/// Whether this is the cover/primary image for the tank
 bool get isCover;/// Date the photo was taken (if available)
 DateTime? get takenAt;/// Created timestamp
 DateTime? get createdAt;
/// Create a copy of TankImageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TankImageEntityCopyWith<TankImageEntity> get copyWith => _$TankImageEntityCopyWithImpl<TankImageEntity>(this as TankImageEntity, _$identity);

  /// Serializes this TankImageEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TankImageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,imagePath,caption,isCover,takenAt,createdAt);

@override
String toString() {
  return 'TankImageEntity(id: $id, tankId: $tankId, imagePath: $imagePath, caption: $caption, isCover: $isCover, takenAt: $takenAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TankImageEntityCopyWith<$Res>  {
  factory $TankImageEntityCopyWith(TankImageEntity value, $Res Function(TankImageEntity) _then) = _$TankImageEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int tankId, String imagePath, String? caption, bool isCover, DateTime? takenAt, DateTime? createdAt
});




}
/// @nodoc
class _$TankImageEntityCopyWithImpl<$Res>
    implements $TankImageEntityCopyWith<$Res> {
  _$TankImageEntityCopyWithImpl(this._self, this._then);

  final TankImageEntity _self;
  final $Res Function(TankImageEntity) _then;

/// Create a copy of TankImageEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = null,Object? imagePath = null,Object? caption = freezed,Object? isCover = null,Object? takenAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,takenAt: freezed == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TankImageEntity].
extension TankImageEntityPatterns on TankImageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TankImageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TankImageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TankImageEntity value)  $default,){
final _that = this;
switch (_that) {
case _TankImageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TankImageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TankImageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int tankId,  String imagePath,  String? caption,  bool isCover,  DateTime? takenAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TankImageEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.imagePath,_that.caption,_that.isCover,_that.takenAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int tankId,  String imagePath,  String? caption,  bool isCover,  DateTime? takenAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TankImageEntity():
return $default(_that.id,_that.tankId,_that.imagePath,_that.caption,_that.isCover,_that.takenAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int tankId,  String imagePath,  String? caption,  bool isCover,  DateTime? takenAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TankImageEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.imagePath,_that.caption,_that.isCover,_that.takenAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TankImageEntity extends TankImageEntity {
  const _TankImageEntity({this.id, required this.tankId, required this.imagePath, this.caption, this.isCover = false, this.takenAt, this.createdAt}): super._();
  factory _TankImageEntity.fromJson(Map<String, dynamic> json) => _$TankImageEntityFromJson(json);

/// Unique identifier (null for new images)
@override final  int? id;
/// Foreign key to tank
@override final  int tankId;
/// Image file path (local storage)
@override final  String imagePath;
/// Optional caption/description
@override final  String? caption;
/// Whether this is the cover/primary image for the tank
@override@JsonKey() final  bool isCover;
/// Date the photo was taken (if available)
@override final  DateTime? takenAt;
/// Created timestamp
@override final  DateTime? createdAt;

/// Create a copy of TankImageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TankImageEntityCopyWith<_TankImageEntity> get copyWith => __$TankImageEntityCopyWithImpl<_TankImageEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TankImageEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TankImageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tankId,imagePath,caption,isCover,takenAt,createdAt);

@override
String toString() {
  return 'TankImageEntity(id: $id, tankId: $tankId, imagePath: $imagePath, caption: $caption, isCover: $isCover, takenAt: $takenAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TankImageEntityCopyWith<$Res> implements $TankImageEntityCopyWith<$Res> {
  factory _$TankImageEntityCopyWith(_TankImageEntity value, $Res Function(_TankImageEntity) _then) = __$TankImageEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int tankId, String imagePath, String? caption, bool isCover, DateTime? takenAt, DateTime? createdAt
});




}
/// @nodoc
class __$TankImageEntityCopyWithImpl<$Res>
    implements _$TankImageEntityCopyWith<$Res> {
  __$TankImageEntityCopyWithImpl(this._self, this._then);

  final _TankImageEntity _self;
  final $Res Function(_TankImageEntity) _then;

/// Create a copy of TankImageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = null,Object? imagePath = null,Object? caption = freezed,Object? isCover = null,Object? takenAt = freezed,Object? createdAt = freezed,}) {
  return _then(_TankImageEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: null == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,takenAt: freezed == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
