import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// Theme mode setting
enum AppThemeMode {
  system,
  light,
  dark;

  ThemeMode toFlutterThemeMode() {
    switch (this) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  String get displayName {
    switch (this) {
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
    }
  }
}

/// Volume unit setting
enum VolumeUnit {
  liters,
  gallons;

  String get displayName {
    switch (this) {
      case VolumeUnit.liters:
        return 'Liters (L)';
      case VolumeUnit.gallons:
        return 'Gallons (gal)';
    }
  }

  String get abbreviation {
    switch (this) {
      case VolumeUnit.liters:
        return 'L';
      case VolumeUnit.gallons:
        return 'gal';
    }
  }

  /// Convert liters to this unit
  double fromLiters(double liters) {
    switch (this) {
      case VolumeUnit.liters:
        return liters;
      case VolumeUnit.gallons:
        return liters * 0.264172;
    }
  }

  /// Convert this unit to liters
  double toLiters(double value) {
    switch (this) {
      case VolumeUnit.liters:
        return value;
      case VolumeUnit.gallons:
        return value * 3.78541;
    }
  }
}

/// Temperature unit setting
enum TemperatureUnit {
  celsius,
  fahrenheit;

  String get displayName {
    switch (this) {
      case TemperatureUnit.celsius:
        return 'Celsius (°C)';
      case TemperatureUnit.fahrenheit:
        return 'Fahrenheit (°F)';
    }
  }

  String get abbreviation {
    switch (this) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
    }
  }

  /// Convert celsius to this unit
  double fromCelsius(double celsius) {
    switch (this) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return (celsius * 9 / 5) + 32;
    }
  }

  /// Convert this unit to celsius
  double toCelsius(double value) {
    switch (this) {
      case TemperatureUnit.celsius:
        return value;
      case TemperatureUnit.fahrenheit:
        return (value - 32) * 5 / 9;
    }
  }
}

/// App settings model
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(VolumeUnit.liters) VolumeUnit volumeUnit,
    @Default(TemperatureUnit.celsius) TemperatureUnit temperatureUnit,
    @Default(true) bool remindersEnabled,
    @Default(9) int defaultReminderHour,
    @Default(0) int defaultReminderMinute,
    @Default(true) bool showParameterTrends,
    @Default(7) int defaultTrendDays,
    @Default(true) bool hapticFeedback,
    @Default(false) bool onboardingCompleted,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
