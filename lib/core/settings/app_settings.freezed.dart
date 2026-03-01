// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppSettings {

 AppThemeMode get themeMode; VolumeUnit get volumeUnit; TemperatureUnit get temperatureUnit; bool get remindersEnabled; int get defaultReminderHour; int get defaultReminderMinute; bool get showParameterTrends; int get defaultTrendDays; bool get hapticFeedback; bool get onboardingCompleted;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.volumeUnit, volumeUnit) || other.volumeUnit == volumeUnit)&&(identical(other.temperatureUnit, temperatureUnit) || other.temperatureUnit == temperatureUnit)&&(identical(other.remindersEnabled, remindersEnabled) || other.remindersEnabled == remindersEnabled)&&(identical(other.defaultReminderHour, defaultReminderHour) || other.defaultReminderHour == defaultReminderHour)&&(identical(other.defaultReminderMinute, defaultReminderMinute) || other.defaultReminderMinute == defaultReminderMinute)&&(identical(other.showParameterTrends, showParameterTrends) || other.showParameterTrends == showParameterTrends)&&(identical(other.defaultTrendDays, defaultTrendDays) || other.defaultTrendDays == defaultTrendDays)&&(identical(other.hapticFeedback, hapticFeedback) || other.hapticFeedback == hapticFeedback)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,volumeUnit,temperatureUnit,remindersEnabled,defaultReminderHour,defaultReminderMinute,showParameterTrends,defaultTrendDays,hapticFeedback,onboardingCompleted);

@override
String toString() {
  return 'AppSettings(themeMode: $themeMode, volumeUnit: $volumeUnit, temperatureUnit: $temperatureUnit, remindersEnabled: $remindersEnabled, defaultReminderHour: $defaultReminderHour, defaultReminderMinute: $defaultReminderMinute, showParameterTrends: $showParameterTrends, defaultTrendDays: $defaultTrendDays, hapticFeedback: $hapticFeedback, onboardingCompleted: $onboardingCompleted)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 AppThemeMode themeMode, VolumeUnit volumeUnit, TemperatureUnit temperatureUnit, bool remindersEnabled, int defaultReminderHour, int defaultReminderMinute, bool showParameterTrends, int defaultTrendDays, bool hapticFeedback, bool onboardingCompleted
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? volumeUnit = null,Object? temperatureUnit = null,Object? remindersEnabled = null,Object? defaultReminderHour = null,Object? defaultReminderMinute = null,Object? showParameterTrends = null,Object? defaultTrendDays = null,Object? hapticFeedback = null,Object? onboardingCompleted = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,volumeUnit: null == volumeUnit ? _self.volumeUnit : volumeUnit // ignore: cast_nullable_to_non_nullable
as VolumeUnit,temperatureUnit: null == temperatureUnit ? _self.temperatureUnit : temperatureUnit // ignore: cast_nullable_to_non_nullable
as TemperatureUnit,remindersEnabled: null == remindersEnabled ? _self.remindersEnabled : remindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,defaultReminderHour: null == defaultReminderHour ? _self.defaultReminderHour : defaultReminderHour // ignore: cast_nullable_to_non_nullable
as int,defaultReminderMinute: null == defaultReminderMinute ? _self.defaultReminderMinute : defaultReminderMinute // ignore: cast_nullable_to_non_nullable
as int,showParameterTrends: null == showParameterTrends ? _self.showParameterTrends : showParameterTrends // ignore: cast_nullable_to_non_nullable
as bool,defaultTrendDays: null == defaultTrendDays ? _self.defaultTrendDays : defaultTrendDays // ignore: cast_nullable_to_non_nullable
as int,hapticFeedback: null == hapticFeedback ? _self.hapticFeedback : hapticFeedback // ignore: cast_nullable_to_non_nullable
as bool,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppThemeMode themeMode,  VolumeUnit volumeUnit,  TemperatureUnit temperatureUnit,  bool remindersEnabled,  int defaultReminderHour,  int defaultReminderMinute,  bool showParameterTrends,  int defaultTrendDays,  bool hapticFeedback,  bool onboardingCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.themeMode,_that.volumeUnit,_that.temperatureUnit,_that.remindersEnabled,_that.defaultReminderHour,_that.defaultReminderMinute,_that.showParameterTrends,_that.defaultTrendDays,_that.hapticFeedback,_that.onboardingCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppThemeMode themeMode,  VolumeUnit volumeUnit,  TemperatureUnit temperatureUnit,  bool remindersEnabled,  int defaultReminderHour,  int defaultReminderMinute,  bool showParameterTrends,  int defaultTrendDays,  bool hapticFeedback,  bool onboardingCompleted)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.themeMode,_that.volumeUnit,_that.temperatureUnit,_that.remindersEnabled,_that.defaultReminderHour,_that.defaultReminderMinute,_that.showParameterTrends,_that.defaultTrendDays,_that.hapticFeedback,_that.onboardingCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppThemeMode themeMode,  VolumeUnit volumeUnit,  TemperatureUnit temperatureUnit,  bool remindersEnabled,  int defaultReminderHour,  int defaultReminderMinute,  bool showParameterTrends,  int defaultTrendDays,  bool hapticFeedback,  bool onboardingCompleted)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.themeMode,_that.volumeUnit,_that.temperatureUnit,_that.remindersEnabled,_that.defaultReminderHour,_that.defaultReminderMinute,_that.showParameterTrends,_that.defaultTrendDays,_that.hapticFeedback,_that.onboardingCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppSettings implements AppSettings {
  const _AppSettings({this.themeMode = AppThemeMode.system, this.volumeUnit = VolumeUnit.liters, this.temperatureUnit = TemperatureUnit.celsius, this.remindersEnabled = true, this.defaultReminderHour = 9, this.defaultReminderMinute = 0, this.showParameterTrends = true, this.defaultTrendDays = 7, this.hapticFeedback = true, this.onboardingCompleted = false});
  factory _AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

@override@JsonKey() final  AppThemeMode themeMode;
@override@JsonKey() final  VolumeUnit volumeUnit;
@override@JsonKey() final  TemperatureUnit temperatureUnit;
@override@JsonKey() final  bool remindersEnabled;
@override@JsonKey() final  int defaultReminderHour;
@override@JsonKey() final  int defaultReminderMinute;
@override@JsonKey() final  bool showParameterTrends;
@override@JsonKey() final  int defaultTrendDays;
@override@JsonKey() final  bool hapticFeedback;
@override@JsonKey() final  bool onboardingCompleted;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.volumeUnit, volumeUnit) || other.volumeUnit == volumeUnit)&&(identical(other.temperatureUnit, temperatureUnit) || other.temperatureUnit == temperatureUnit)&&(identical(other.remindersEnabled, remindersEnabled) || other.remindersEnabled == remindersEnabled)&&(identical(other.defaultReminderHour, defaultReminderHour) || other.defaultReminderHour == defaultReminderHour)&&(identical(other.defaultReminderMinute, defaultReminderMinute) || other.defaultReminderMinute == defaultReminderMinute)&&(identical(other.showParameterTrends, showParameterTrends) || other.showParameterTrends == showParameterTrends)&&(identical(other.defaultTrendDays, defaultTrendDays) || other.defaultTrendDays == defaultTrendDays)&&(identical(other.hapticFeedback, hapticFeedback) || other.hapticFeedback == hapticFeedback)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,volumeUnit,temperatureUnit,remindersEnabled,defaultReminderHour,defaultReminderMinute,showParameterTrends,defaultTrendDays,hapticFeedback,onboardingCompleted);

@override
String toString() {
  return 'AppSettings(themeMode: $themeMode, volumeUnit: $volumeUnit, temperatureUnit: $temperatureUnit, remindersEnabled: $remindersEnabled, defaultReminderHour: $defaultReminderHour, defaultReminderMinute: $defaultReminderMinute, showParameterTrends: $showParameterTrends, defaultTrendDays: $defaultTrendDays, hapticFeedback: $hapticFeedback, onboardingCompleted: $onboardingCompleted)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 AppThemeMode themeMode, VolumeUnit volumeUnit, TemperatureUnit temperatureUnit, bool remindersEnabled, int defaultReminderHour, int defaultReminderMinute, bool showParameterTrends, int defaultTrendDays, bool hapticFeedback, bool onboardingCompleted
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? volumeUnit = null,Object? temperatureUnit = null,Object? remindersEnabled = null,Object? defaultReminderHour = null,Object? defaultReminderMinute = null,Object? showParameterTrends = null,Object? defaultTrendDays = null,Object? hapticFeedback = null,Object? onboardingCompleted = null,}) {
  return _then(_AppSettings(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,volumeUnit: null == volumeUnit ? _self.volumeUnit : volumeUnit // ignore: cast_nullable_to_non_nullable
as VolumeUnit,temperatureUnit: null == temperatureUnit ? _self.temperatureUnit : temperatureUnit // ignore: cast_nullable_to_non_nullable
as TemperatureUnit,remindersEnabled: null == remindersEnabled ? _self.remindersEnabled : remindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,defaultReminderHour: null == defaultReminderHour ? _self.defaultReminderHour : defaultReminderHour // ignore: cast_nullable_to_non_nullable
as int,defaultReminderMinute: null == defaultReminderMinute ? _self.defaultReminderMinute : defaultReminderMinute // ignore: cast_nullable_to_non_nullable
as int,showParameterTrends: null == showParameterTrends ? _self.showParameterTrends : showParameterTrends // ignore: cast_nullable_to_non_nullable
as bool,defaultTrendDays: null == defaultTrendDays ? _self.defaultTrendDays : defaultTrendDays // ignore: cast_nullable_to_non_nullable
as int,hapticFeedback: null == hapticFeedback ? _self.hapticFeedback : hapticFeedback // ignore: cast_nullable_to_non_nullable
as bool,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
