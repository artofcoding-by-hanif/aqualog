import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/local_storage.dart';
import 'app_settings.dart';
import 'settings_repository.dart';

part 'settings_provider.g.dart';

/// Provider for LocalStorage singleton
@Riverpod(keepAlive: true)
LocalStorage localStorage(Ref ref) {
  return LocalStorage.instance;
}

/// Provider for SettingsRepository
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  final storage = ref.watch(localStorageProvider);
  return SettingsRepository(storage);
}

/// Notifier for managing app settings
@Riverpod(keepAlive: true)
class AppSettingsNotifier extends _$AppSettingsNotifier {
  @override
  Future<AppSettings> build() async {
    final repo = ref.watch(settingsRepositoryProvider);
    return repo.loadSettings();
  }

  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  /// Update theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateThemeMode(mode));
  }

  /// Update volume unit
  Future<void> setVolumeUnit(VolumeUnit unit) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateVolumeUnit(unit));
  }

  /// Update temperature unit
  Future<void> setTemperatureUnit(TemperatureUnit unit) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateTemperatureUnit(unit));
  }

  /// Update reminders enabled
  Future<void> setRemindersEnabled(bool enabled) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateRemindersEnabled(enabled));
  }

  /// Update default reminder time
  Future<void> setDefaultReminderTime(int hour, int minute) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateDefaultReminderTime(hour, minute));
  }

  /// Update show parameter trends
  Future<void> setShowParameterTrends(bool show) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateShowParameterTrends(show));
  }

  /// Update default trend days
  Future<void> setDefaultTrendDays(int days) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateDefaultTrendDays(days));
  }

  /// Update haptic feedback
  Future<void> setHapticFeedback(bool enabled) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateHapticFeedback(enabled));
  }

  /// Update onboarding completed
  Future<void> setOnboardingCompleted(bool completed) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.updateOnboardingCompleted(completed));
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.resetToDefaults());
  }
}

/// Provider for current theme mode (for MaterialApp)
@riverpod
ThemeMode appThemeMode(Ref ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.themeMode.toFlutterThemeMode(),
    loading: () => ThemeMode.system,
    error: (_, __) => ThemeMode.system,
  );
}

/// Provider for current volume unit
@riverpod
VolumeUnit currentVolumeUnit(Ref ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.volumeUnit,
    loading: () => VolumeUnit.liters,
    error: (_, __) => VolumeUnit.liters,
  );
}

/// Provider for current temperature unit
@riverpod
TemperatureUnit currentTemperatureUnit(Ref ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.temperatureUnit,
    loading: () => TemperatureUnit.celsius,
    error: (_, __) => TemperatureUnit.celsius,
  );
}

/// Provider for reminders enabled status
@riverpod
bool remindersEnabled(Ref ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.remindersEnabled,
    loading: () => true,
    error: (_, __) => true,
  );
}

/// Provider for onboarding completed status
@riverpod
bool onboardingCompleted(Ref ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.when(
    data: (settings) => settings.onboardingCompleted,
    loading: () => false,
    error: (_, __) => false,
  );
}
