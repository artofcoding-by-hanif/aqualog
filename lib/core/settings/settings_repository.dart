import 'dart:convert';

import '../storage/local_storage.dart';
import 'app_settings.dart';

/// Keys for storing settings
class SettingsKeys {
  SettingsKeys._();

  static const String settings = 'app_settings';
  static const String themeMode = 'theme_mode';
  static const String volumeUnit = 'volume_unit';
  static const String temperatureUnit = 'temperature_unit';
  static const String remindersEnabled = 'reminders_enabled';
  static const String defaultReminderHour = 'default_reminder_hour';
  static const String defaultReminderMinute = 'default_reminder_minute';
  static const String showParameterTrends = 'show_parameter_trends';
  static const String defaultTrendDays = 'default_trend_days';
  static const String hapticFeedback = 'haptic_feedback';
}

/// Repository for managing app settings persistence
class SettingsRepository {
  final LocalStorage _storage;

  SettingsRepository(this._storage);

  /// Load settings from storage
  Future<AppSettings> loadSettings() async {
    await _storage.initialize();

    final jsonStr = _storage.getString(SettingsKeys.settings);
    if (jsonStr != null) {
      try {
        final json = jsonDecode(jsonStr) as Map<String, dynamic>;
        return AppSettings.fromJson(json);
      } catch (_) {
        // If parsing fails, return defaults
        return const AppSettings();
      }
    }

    return const AppSettings();
  }

  /// Save settings to storage
  Future<void> saveSettings(AppSettings settings) async {
    await _storage.initialize();
    final jsonStr = jsonEncode(settings.toJson());
    await _storage.setString(SettingsKeys.settings, jsonStr);
  }

  /// Update a single setting
  Future<AppSettings> updateThemeMode(AppThemeMode mode) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(themeMode: mode);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateVolumeUnit(VolumeUnit unit) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(volumeUnit: unit);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateTemperatureUnit(TemperatureUnit unit) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(temperatureUnit: unit);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateRemindersEnabled(bool enabled) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(remindersEnabled: enabled);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateDefaultReminderTime(int hour, int minute) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(
      defaultReminderHour: hour,
      defaultReminderMinute: minute,
    );
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateShowParameterTrends(bool show) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(showParameterTrends: show);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateDefaultTrendDays(int days) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(defaultTrendDays: days);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateHapticFeedback(bool enabled) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(hapticFeedback: enabled);
    await saveSettings(updated);
    return updated;
  }

  Future<AppSettings> updateOnboardingCompleted(bool completed) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(onboardingCompleted: completed);
    await saveSettings(updated);
    return updated;
  }

  /// Reset all settings to defaults
  Future<AppSettings> resetToDefaults() async {
    const defaults = AppSettings();
    await saveSettings(defaults);
    return defaults;
  }
}
