// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  themeMode:
      $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
      AppThemeMode.system,
  volumeUnit:
      $enumDecodeNullable(_$VolumeUnitEnumMap, json['volumeUnit']) ??
      VolumeUnit.liters,
  temperatureUnit:
      $enumDecodeNullable(_$TemperatureUnitEnumMap, json['temperatureUnit']) ??
      TemperatureUnit.celsius,
  remindersEnabled: json['remindersEnabled'] as bool? ?? true,
  defaultReminderHour: (json['defaultReminderHour'] as num?)?.toInt() ?? 9,
  defaultReminderMinute: (json['defaultReminderMinute'] as num?)?.toInt() ?? 0,
  showParameterTrends: json['showParameterTrends'] as bool? ?? true,
  defaultTrendDays: (json['defaultTrendDays'] as num?)?.toInt() ?? 7,
  hapticFeedback: json['hapticFeedback'] as bool? ?? true,
  onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'volumeUnit': _$VolumeUnitEnumMap[instance.volumeUnit]!,
      'temperatureUnit': _$TemperatureUnitEnumMap[instance.temperatureUnit]!,
      'remindersEnabled': instance.remindersEnabled,
      'defaultReminderHour': instance.defaultReminderHour,
      'defaultReminderMinute': instance.defaultReminderMinute,
      'showParameterTrends': instance.showParameterTrends,
      'defaultTrendDays': instance.defaultTrendDays,
      'hapticFeedback': instance.hapticFeedback,
      'onboardingCompleted': instance.onboardingCompleted,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.system: 'system',
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
};

const _$VolumeUnitEnumMap = {
  VolumeUnit.liters: 'liters',
  VolumeUnit.gallons: 'gallons',
};

const _$TemperatureUnitEnumMap = {
  TemperatureUnit.celsius: 'celsius',
  TemperatureUnit.fahrenheit: 'fahrenheit',
};
