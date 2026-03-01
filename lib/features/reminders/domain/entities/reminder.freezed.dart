// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReminderEntity {

/// Unique identifier (null for new reminders)
 int? get id;/// Tank ID this reminder belongs to (null for global reminders)
 int? get tankId;/// Filter ID this reminder is linked to (null for non-filter reminders)
 int? get filterId;/// Food type for feeding reminders (null for non-feeding reminders)
 FoodType? get foodType;/// Reminder title
 String get title;/// Description/notes
 String? get description;/// Type of reminder
 ReminderType get reminderType;/// Scheduled date/time
 DateTime get scheduledAt;/// Repeat frequency
 RepeatFrequency get repeatFrequency;/// Custom repeat interval in days (when repeatFrequency is custom)
 int? get customIntervalDays;/// Whether the reminder is enabled
 bool get isEnabled;/// Whether the reminder has been completed
 bool get isCompleted;/// Last completed timestamp
 DateTime? get lastCompletedAt;/// Created timestamp
 DateTime? get createdAt;/// Updated timestamp
 DateTime? get updatedAt;
/// Create a copy of ReminderEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderEntityCopyWith<ReminderEntity> get copyWith => _$ReminderEntityCopyWithImpl<ReminderEntity>(this as ReminderEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReminderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.filterId, filterId) || other.filterId == filterId)&&(identical(other.foodType, foodType) || other.foodType == foodType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.reminderType, reminderType) || other.reminderType == reminderType)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.repeatFrequency, repeatFrequency) || other.repeatFrequency == repeatFrequency)&&(identical(other.customIntervalDays, customIntervalDays) || other.customIntervalDays == customIntervalDays)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.lastCompletedAt, lastCompletedAt) || other.lastCompletedAt == lastCompletedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tankId,filterId,foodType,title,description,reminderType,scheduledAt,repeatFrequency,customIntervalDays,isEnabled,isCompleted,lastCompletedAt,createdAt,updatedAt);

@override
String toString() {
  return 'ReminderEntity(id: $id, tankId: $tankId, filterId: $filterId, foodType: $foodType, title: $title, description: $description, reminderType: $reminderType, scheduledAt: $scheduledAt, repeatFrequency: $repeatFrequency, customIntervalDays: $customIntervalDays, isEnabled: $isEnabled, isCompleted: $isCompleted, lastCompletedAt: $lastCompletedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReminderEntityCopyWith<$Res>  {
  factory $ReminderEntityCopyWith(ReminderEntity value, $Res Function(ReminderEntity) _then) = _$ReminderEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int? tankId, int? filterId, FoodType? foodType, String title, String? description, ReminderType reminderType, DateTime scheduledAt, RepeatFrequency repeatFrequency, int? customIntervalDays, bool isEnabled, bool isCompleted, DateTime? lastCompletedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ReminderEntityCopyWithImpl<$Res>
    implements $ReminderEntityCopyWith<$Res> {
  _$ReminderEntityCopyWithImpl(this._self, this._then);

  final ReminderEntity _self;
  final $Res Function(ReminderEntity) _then;

/// Create a copy of ReminderEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tankId = freezed,Object? filterId = freezed,Object? foodType = freezed,Object? title = null,Object? description = freezed,Object? reminderType = null,Object? scheduledAt = null,Object? repeatFrequency = null,Object? customIntervalDays = freezed,Object? isEnabled = null,Object? isCompleted = null,Object? lastCompletedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: freezed == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int?,filterId: freezed == filterId ? _self.filterId : filterId // ignore: cast_nullable_to_non_nullable
as int?,foodType: freezed == foodType ? _self.foodType : foodType // ignore: cast_nullable_to_non_nullable
as FoodType?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,reminderType: null == reminderType ? _self.reminderType : reminderType // ignore: cast_nullable_to_non_nullable
as ReminderType,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,repeatFrequency: null == repeatFrequency ? _self.repeatFrequency : repeatFrequency // ignore: cast_nullable_to_non_nullable
as RepeatFrequency,customIntervalDays: freezed == customIntervalDays ? _self.customIntervalDays : customIntervalDays // ignore: cast_nullable_to_non_nullable
as int?,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,lastCompletedAt: freezed == lastCompletedAt ? _self.lastCompletedAt : lastCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReminderEntity].
extension ReminderEntityPatterns on ReminderEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReminderEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReminderEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReminderEntity value)  $default,){
final _that = this;
switch (_that) {
case _ReminderEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReminderEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ReminderEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? tankId,  int? filterId,  FoodType? foodType,  String title,  String? description,  ReminderType reminderType,  DateTime scheduledAt,  RepeatFrequency repeatFrequency,  int? customIntervalDays,  bool isEnabled,  bool isCompleted,  DateTime? lastCompletedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReminderEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.filterId,_that.foodType,_that.title,_that.description,_that.reminderType,_that.scheduledAt,_that.repeatFrequency,_that.customIntervalDays,_that.isEnabled,_that.isCompleted,_that.lastCompletedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? tankId,  int? filterId,  FoodType? foodType,  String title,  String? description,  ReminderType reminderType,  DateTime scheduledAt,  RepeatFrequency repeatFrequency,  int? customIntervalDays,  bool isEnabled,  bool isCompleted,  DateTime? lastCompletedAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReminderEntity():
return $default(_that.id,_that.tankId,_that.filterId,_that.foodType,_that.title,_that.description,_that.reminderType,_that.scheduledAt,_that.repeatFrequency,_that.customIntervalDays,_that.isEnabled,_that.isCompleted,_that.lastCompletedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? tankId,  int? filterId,  FoodType? foodType,  String title,  String? description,  ReminderType reminderType,  DateTime scheduledAt,  RepeatFrequency repeatFrequency,  int? customIntervalDays,  bool isEnabled,  bool isCompleted,  DateTime? lastCompletedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReminderEntity() when $default != null:
return $default(_that.id,_that.tankId,_that.filterId,_that.foodType,_that.title,_that.description,_that.reminderType,_that.scheduledAt,_that.repeatFrequency,_that.customIntervalDays,_that.isEnabled,_that.isCompleted,_that.lastCompletedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ReminderEntity extends ReminderEntity {
  const _ReminderEntity({this.id, this.tankId, this.filterId, this.foodType, required this.title, this.description, required this.reminderType, required this.scheduledAt, this.repeatFrequency = RepeatFrequency.none, this.customIntervalDays, this.isEnabled = true, this.isCompleted = false, this.lastCompletedAt, this.createdAt, this.updatedAt}): super._();
  

/// Unique identifier (null for new reminders)
@override final  int? id;
/// Tank ID this reminder belongs to (null for global reminders)
@override final  int? tankId;
/// Filter ID this reminder is linked to (null for non-filter reminders)
@override final  int? filterId;
/// Food type for feeding reminders (null for non-feeding reminders)
@override final  FoodType? foodType;
/// Reminder title
@override final  String title;
/// Description/notes
@override final  String? description;
/// Type of reminder
@override final  ReminderType reminderType;
/// Scheduled date/time
@override final  DateTime scheduledAt;
/// Repeat frequency
@override@JsonKey() final  RepeatFrequency repeatFrequency;
/// Custom repeat interval in days (when repeatFrequency is custom)
@override final  int? customIntervalDays;
/// Whether the reminder is enabled
@override@JsonKey() final  bool isEnabled;
/// Whether the reminder has been completed
@override@JsonKey() final  bool isCompleted;
/// Last completed timestamp
@override final  DateTime? lastCompletedAt;
/// Created timestamp
@override final  DateTime? createdAt;
/// Updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of ReminderEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderEntityCopyWith<_ReminderEntity> get copyWith => __$ReminderEntityCopyWithImpl<_ReminderEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReminderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tankId, tankId) || other.tankId == tankId)&&(identical(other.filterId, filterId) || other.filterId == filterId)&&(identical(other.foodType, foodType) || other.foodType == foodType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.reminderType, reminderType) || other.reminderType == reminderType)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.repeatFrequency, repeatFrequency) || other.repeatFrequency == repeatFrequency)&&(identical(other.customIntervalDays, customIntervalDays) || other.customIntervalDays == customIntervalDays)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.lastCompletedAt, lastCompletedAt) || other.lastCompletedAt == lastCompletedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tankId,filterId,foodType,title,description,reminderType,scheduledAt,repeatFrequency,customIntervalDays,isEnabled,isCompleted,lastCompletedAt,createdAt,updatedAt);

@override
String toString() {
  return 'ReminderEntity(id: $id, tankId: $tankId, filterId: $filterId, foodType: $foodType, title: $title, description: $description, reminderType: $reminderType, scheduledAt: $scheduledAt, repeatFrequency: $repeatFrequency, customIntervalDays: $customIntervalDays, isEnabled: $isEnabled, isCompleted: $isCompleted, lastCompletedAt: $lastCompletedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReminderEntityCopyWith<$Res> implements $ReminderEntityCopyWith<$Res> {
  factory _$ReminderEntityCopyWith(_ReminderEntity value, $Res Function(_ReminderEntity) _then) = __$ReminderEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? tankId, int? filterId, FoodType? foodType, String title, String? description, ReminderType reminderType, DateTime scheduledAt, RepeatFrequency repeatFrequency, int? customIntervalDays, bool isEnabled, bool isCompleted, DateTime? lastCompletedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ReminderEntityCopyWithImpl<$Res>
    implements _$ReminderEntityCopyWith<$Res> {
  __$ReminderEntityCopyWithImpl(this._self, this._then);

  final _ReminderEntity _self;
  final $Res Function(_ReminderEntity) _then;

/// Create a copy of ReminderEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tankId = freezed,Object? filterId = freezed,Object? foodType = freezed,Object? title = null,Object? description = freezed,Object? reminderType = null,Object? scheduledAt = null,Object? repeatFrequency = null,Object? customIntervalDays = freezed,Object? isEnabled = null,Object? isCompleted = null,Object? lastCompletedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ReminderEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tankId: freezed == tankId ? _self.tankId : tankId // ignore: cast_nullable_to_non_nullable
as int?,filterId: freezed == filterId ? _self.filterId : filterId // ignore: cast_nullable_to_non_nullable
as int?,foodType: freezed == foodType ? _self.foodType : foodType // ignore: cast_nullable_to_non_nullable
as FoodType?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,reminderType: null == reminderType ? _self.reminderType : reminderType // ignore: cast_nullable_to_non_nullable
as ReminderType,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,repeatFrequency: null == repeatFrequency ? _self.repeatFrequency : repeatFrequency // ignore: cast_nullable_to_non_nullable
as RepeatFrequency,customIntervalDays: freezed == customIntervalDays ? _self.customIntervalDays : customIntervalDays // ignore: cast_nullable_to_non_nullable
as int?,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,lastCompletedAt: freezed == lastCompletedAt ? _self.lastCompletedAt : lastCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
