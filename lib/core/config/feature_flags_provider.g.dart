// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flags_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing feature flag state with runtime overrides

@ProviderFor(FeatureFlagsNotifier)
final featureFlagsProvider = FeatureFlagsNotifierProvider._();

/// Notifier for managing feature flag state with runtime overrides
final class FeatureFlagsNotifierProvider
    extends $NotifierProvider<FeatureFlagsNotifier, Map<FeatureFlag, bool>> {
  /// Notifier for managing feature flag state with runtime overrides
  FeatureFlagsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featureFlagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featureFlagsNotifierHash();

  @$internal
  @override
  FeatureFlagsNotifier create() => FeatureFlagsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<FeatureFlag, bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<FeatureFlag, bool>>(value),
    );
  }
}

String _$featureFlagsNotifierHash() =>
    r'694fedf4015a431ad2ae027e6f4f20ad399e20a2';

/// Notifier for managing feature flag state with runtime overrides

abstract class _$FeatureFlagsNotifier
    extends $Notifier<Map<FeatureFlag, bool>> {
  Map<FeatureFlag, bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<FeatureFlag, bool>, Map<FeatureFlag, bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<FeatureFlag, bool>, Map<FeatureFlag, bool>>,
              Map<FeatureFlag, bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider to check if a specific feature flag is enabled

@ProviderFor(featureEnabled)
final featureEnabledProvider = FeatureEnabledFamily._();

/// Provider to check if a specific feature flag is enabled

final class FeatureEnabledProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if a specific feature flag is enabled
  FeatureEnabledProvider._({
    required FeatureEnabledFamily super.from,
    required FeatureFlag super.argument,
  }) : super(
         retry: null,
         name: r'featureEnabledProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$featureEnabledHash();

  @override
  String toString() {
    return r'featureEnabledProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as FeatureFlag;
    return featureEnabled(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FeatureEnabledProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$featureEnabledHash() => r'5e833bce6f5447001bb0711e2ebf1b071dc64801';

/// Provider to check if a specific feature flag is enabled

final class FeatureEnabledFamily extends $Family
    with $FunctionalFamilyOverride<bool, FeatureFlag> {
  FeatureEnabledFamily._()
    : super(
        retry: null,
        name: r'featureEnabledProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to check if a specific feature flag is enabled

  FeatureEnabledProvider call(FeatureFlag flag) =>
      FeatureEnabledProvider._(argument: flag, from: this);

  @override
  String toString() => r'featureEnabledProvider';
}
