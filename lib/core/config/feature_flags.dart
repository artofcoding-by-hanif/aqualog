import 'app_config.dart';

/// All available feature flags in the application
enum FeatureFlag {
  // Core Features
  waterParameterTracking,
  livestockManagement,
  equipmentTracking,
  fertilizationSchedule,
  reminders,

  // Advanced Features
  dataExport,
  dataSync,
  cloudBackup,
  multiTankSupport,

  // Experimental Features
  aiRecommendations,
  communitySharing,
  advancedAnalytics,
  photoGallery,

  // Debug Features
  debugMenu,
  mockData,
  performanceOverlay,
}

/// Configuration for a single feature flag
class FeatureFlagConfig {
  final bool enabledInDev;
  final bool enabledInProd;
  final String description;

  const FeatureFlagConfig({
    required this.enabledInDev,
    required this.enabledInProd,
    required this.description,
  });

  bool get isEnabled => AppConfig.isDev ? enabledInDev : enabledInProd;
}

/// Central feature flag definitions with per-environment defaults
class FeatureFlags {
  FeatureFlags._();

  static final Map<FeatureFlag, FeatureFlagConfig> _flags = {
    // Core Features - enabled in both environments
    FeatureFlag.waterParameterTracking: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Track water parameters like pH, ammonia, nitrite, etc.',
    ),
    FeatureFlag.livestockManagement: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Manage fish, invertebrates, and other livestock',
    ),
    FeatureFlag.equipmentTracking: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Track filters, heaters, lights, and other equipment',
    ),
    FeatureFlag.fertilizationSchedule: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Schedule and track fertilizer dosing',
    ),
    FeatureFlag.reminders: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Set reminders for maintenance tasks',
    ),

    // Advanced Features - enabled in dev, some in prod
    FeatureFlag.dataExport: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Export data to CSV or JSON',
    ),
    FeatureFlag.dataSync: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Sync data across devices',
    ),
    FeatureFlag.cloudBackup: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Backup data to cloud storage',
    ),
    FeatureFlag.multiTankSupport: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: true,
      description: 'Manage multiple aquariums',
    ),

    // Experimental Features - dev only
    FeatureFlag.aiRecommendations: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'AI-powered recommendations for tank care',
    ),
    FeatureFlag.communitySharing: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Share tank profiles with the community',
    ),
    FeatureFlag.advancedAnalytics: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Advanced charts and trend analysis',
    ),
    FeatureFlag.photoGallery: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Photo gallery for tank progress',
    ),

    // Debug Features - dev only
    FeatureFlag.debugMenu: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Access debug menu and tools',
    ),
    FeatureFlag.mockData: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Use mock data for testing',
    ),
    FeatureFlag.performanceOverlay: const FeatureFlagConfig(
      enabledInDev: true,
      enabledInProd: false,
      description: 'Show performance overlay',
    ),
  };

  /// Runtime overrides (can be modified at runtime)
  static final Map<FeatureFlag, bool> _overrides = {};

  /// Check if a feature is enabled
  static bool isEnabled(FeatureFlag flag) {
    // Check for runtime override first
    if (_overrides.containsKey(flag)) {
      return _overrides[flag]!;
    }
    // Fall back to config-based value
    return _flags[flag]?.isEnabled ?? false;
  }

  /// Override a feature flag at runtime
  static void setOverride(FeatureFlag flag, bool enabled) {
    _overrides[flag] = enabled;
  }

  /// Clear a runtime override
  static void clearOverride(FeatureFlag flag) {
    _overrides.remove(flag);
  }

  /// Clear all runtime overrides
  static void clearAllOverrides() {
    _overrides.clear();
  }

  /// Get the configuration for a feature flag
  static FeatureFlagConfig? getConfig(FeatureFlag flag) => _flags[flag];

  /// Get all feature flags and their current state
  static Map<FeatureFlag, bool> getAllFlags() {
    return {for (var flag in FeatureFlag.values) flag: isEnabled(flag)};
  }
}

