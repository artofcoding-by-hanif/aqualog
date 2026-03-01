// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for LocalStorage singleton

@ProviderFor(localStorage)
final localStorageProvider = LocalStorageProvider._();

/// Provider for LocalStorage singleton

final class LocalStorageProvider
    extends $FunctionalProvider<LocalStorage, LocalStorage, LocalStorage>
    with $Provider<LocalStorage> {
  /// Provider for LocalStorage singleton
  LocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localStorageHash();

  @$internal
  @override
  $ProviderElement<LocalStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalStorage create(Ref ref) {
    return localStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalStorage>(value),
    );
  }
}

String _$localStorageHash() => r'aa29b28e2b89e13519fff55fdf5de191cad0d7e2';

/// Provider for SettingsRepository

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Provider for SettingsRepository

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  /// Provider for SettingsRepository
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'46f6de604920a790dd57594eb9e51e91cbaa116a';

/// Notifier for managing app settings

@ProviderFor(AppSettingsNotifier)
final appSettingsProvider = AppSettingsNotifierProvider._();

/// Notifier for managing app settings
final class AppSettingsNotifierProvider
    extends $AsyncNotifierProvider<AppSettingsNotifier, AppSettings> {
  /// Notifier for managing app settings
  AppSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingsNotifierHash();

  @$internal
  @override
  AppSettingsNotifier create() => AppSettingsNotifier();
}

String _$appSettingsNotifierHash() =>
    r'0968070279739882f6934fbd0c7484a2dbd8fabb';

/// Notifier for managing app settings

abstract class _$AppSettingsNotifier extends $AsyncNotifier<AppSettings> {
  FutureOr<AppSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppSettings>, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppSettings>, AppSettings>,
              AsyncValue<AppSettings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider for current theme mode (for MaterialApp)

@ProviderFor(appThemeMode)
final appThemeModeProvider = AppThemeModeProvider._();

/// Provider for current theme mode (for MaterialApp)

final class AppThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// Provider for current theme mode (for MaterialApp)
  AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return appThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeHash() => r'1607681580083d57772717c9df1c486500e91d4e';

/// Provider for current volume unit

@ProviderFor(currentVolumeUnit)
final currentVolumeUnitProvider = CurrentVolumeUnitProvider._();

/// Provider for current volume unit

final class CurrentVolumeUnitProvider
    extends $FunctionalProvider<VolumeUnit, VolumeUnit, VolumeUnit>
    with $Provider<VolumeUnit> {
  /// Provider for current volume unit
  CurrentVolumeUnitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentVolumeUnitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentVolumeUnitHash();

  @$internal
  @override
  $ProviderElement<VolumeUnit> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VolumeUnit create(Ref ref) {
    return currentVolumeUnit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VolumeUnit value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VolumeUnit>(value),
    );
  }
}

String _$currentVolumeUnitHash() => r'f3149d48a6749c615100b29542afdbe5ee2beefc';

/// Provider for current temperature unit

@ProviderFor(currentTemperatureUnit)
final currentTemperatureUnitProvider = CurrentTemperatureUnitProvider._();

/// Provider for current temperature unit

final class CurrentTemperatureUnitProvider
    extends
        $FunctionalProvider<TemperatureUnit, TemperatureUnit, TemperatureUnit>
    with $Provider<TemperatureUnit> {
  /// Provider for current temperature unit
  CurrentTemperatureUnitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentTemperatureUnitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentTemperatureUnitHash();

  @$internal
  @override
  $ProviderElement<TemperatureUnit> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TemperatureUnit create(Ref ref) {
    return currentTemperatureUnit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TemperatureUnit value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TemperatureUnit>(value),
    );
  }
}

String _$currentTemperatureUnitHash() =>
    r'7d731432212bc7ea0cb723780a64382214d76f86';

/// Provider for reminders enabled status

@ProviderFor(remindersEnabled)
final remindersEnabledProvider = RemindersEnabledProvider._();

/// Provider for reminders enabled status

final class RemindersEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for reminders enabled status
  RemindersEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return remindersEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$remindersEnabledHash() => r'e1e58730f86ed79e3044a155bee8df9d9f73daae';

/// Provider for onboarding completed status

@ProviderFor(onboardingCompleted)
final onboardingCompletedProvider = OnboardingCompletedProvider._();

/// Provider for onboarding completed status

final class OnboardingCompletedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider for onboarding completed status
  OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return onboardingCompleted(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingCompletedHash() =>
    r'ca693818c8dfec823fbb57fad74e5f0bacf63319';
