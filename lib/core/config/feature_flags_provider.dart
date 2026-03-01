import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'feature_flags.dart';

part 'feature_flags_provider.g.dart';

/// Notifier for managing feature flag state with runtime overrides
@riverpod
class FeatureFlagsNotifier extends _$FeatureFlagsNotifier {
  @override
  Map<FeatureFlag, bool> build() {
    return FeatureFlags.getAllFlags();
  }

  /// Check if a specific feature is enabled
  bool isEnabled(FeatureFlag flag) {
    return state[flag] ?? false;
  }

  /// Override a feature flag at runtime
  void setOverride(FeatureFlag flag, bool enabled) {
    FeatureFlags.setOverride(flag, enabled);
    state = FeatureFlags.getAllFlags();
  }

  /// Clear a runtime override
  void clearOverride(FeatureFlag flag) {
    FeatureFlags.clearOverride(flag);
    state = FeatureFlags.getAllFlags();
  }

  /// Clear all runtime overrides
  void clearAllOverrides() {
    FeatureFlags.clearAllOverrides();
    state = FeatureFlags.getAllFlags();
  }
}

/// Provider to check if a specific feature flag is enabled
@riverpod
bool featureEnabled(Ref ref, FeatureFlag flag) {
  final flags = ref.watch(featureFlagsProvider);
  return flags[flag] ?? false;
}

/// Extension for easier feature flag access in widgets
extension FeatureFlagWidgetRef on WidgetRef {
  /// Check if a feature flag is enabled
  bool isFeatureEnabled(FeatureFlag flag) {
    return watch(featureEnabledProvider(flag));
  }

  /// Override a feature flag at runtime
  void setFeatureOverride(FeatureFlag flag, bool enabled) {
    read(featureFlagsProvider.notifier).setOverride(flag, enabled);
  }
}

/// Extension for easier feature flag access in providers
extension FeatureFlagRef on Ref {
  /// Check if a feature flag is enabled
  bool isFeatureEnabled(FeatureFlag flag) {
    return watch(featureEnabledProvider(flag));
  }
}
