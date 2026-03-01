import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant.freezed.dart';
part 'plant.g.dart';

/// Type of aquarium plant
enum PlantType {
  @JsonValue('stem')
  stem,
  @JsonValue('rosette')
  rosette,
  @JsonValue('carpet')
  carpet,
  @JsonValue('floating')
  floating,
  @JsonValue('moss')
  moss,
  @JsonValue('fern')
  fern,
  @JsonValue('rhizome')
  rhizome,
  @JsonValue('bulb')
  bulb,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case PlantType.stem:
        return 'Stem Plant';
      case PlantType.rosette:
        return 'Rosette';
      case PlantType.carpet:
        return 'Carpet';
      case PlantType.floating:
        return 'Floating';
      case PlantType.moss:
        return 'Moss';
      case PlantType.fern:
        return 'Fern';
      case PlantType.rhizome:
        return 'Rhizome';
      case PlantType.bulb:
        return 'Bulb';
      case PlantType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case PlantType.stem:
        return '🌿';
      case PlantType.rosette:
        return '🌱';
      case PlantType.carpet:
        return '🟢';
      case PlantType.floating:
        return '🍃';
      case PlantType.moss:
        return '🌲';
      case PlantType.fern:
        return '🌴';
      case PlantType.rhizome:
        return '🪴';
      case PlantType.bulb:
        return '🧅';
      case PlantType.other:
        return '🌿';
    }
  }
}

/// Lighting requirement level
enum LightingRequirement {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('very_high')
  veryHigh;

  String get displayName {
    switch (this) {
      case LightingRequirement.low:
        return 'Low';
      case LightingRequirement.medium:
        return 'Medium';
      case LightingRequirement.high:
        return 'High';
      case LightingRequirement.veryHigh:
        return 'Very High';
    }
  }

  String get icon {
    switch (this) {
      case LightingRequirement.low:
        return '🌑';
      case LightingRequirement.medium:
        return '🌓';
      case LightingRequirement.high:
        return '🌕';
      case LightingRequirement.veryHigh:
        return '☀️';
    }
  }
}

/// CO2 requirement level
enum CO2Requirement {
  @JsonValue('none')
  none,
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high;

  String get displayName {
    switch (this) {
      case CO2Requirement.none:
        return 'None';
      case CO2Requirement.low:
        return 'Low';
      case CO2Requirement.medium:
        return 'Medium';
      case CO2Requirement.high:
        return 'High';
    }
  }

  String get icon {
    switch (this) {
      case CO2Requirement.none:
        return '🚫';
      case CO2Requirement.low:
        return '💨';
      case CO2Requirement.medium:
        return '💨💨';
      case CO2Requirement.high:
        return '💨💨💨';
    }
  }
}

/// Growth rate
enum GrowthRate {
  @JsonValue('slow')
  slow,
  @JsonValue('medium')
  medium,
  @JsonValue('fast')
  fast;

  String get displayName {
    switch (this) {
      case GrowthRate.slow:
        return 'Slow';
      case GrowthRate.medium:
        return 'Medium';
      case GrowthRate.fast:
        return 'Fast';
    }
  }

  String get icon {
    switch (this) {
      case GrowthRate.slow:
        return '🐢';
      case GrowthRate.medium:
        return '🐇';
      case GrowthRate.fast:
        return '🚀';
    }
  }
}

/// Placement zone in tank
enum PlacementZone {
  @JsonValue('foreground')
  foreground,
  @JsonValue('midground')
  midground,
  @JsonValue('background')
  background,
  @JsonValue('floating')
  floating;

  String get displayName {
    switch (this) {
      case PlacementZone.foreground:
        return 'Foreground';
      case PlacementZone.midground:
        return 'Midground';
      case PlacementZone.background:
        return 'Background';
      case PlacementZone.floating:
        return 'Floating';
    }
  }

  String get icon {
    switch (this) {
      case PlacementZone.foreground:
        return '⬇️';
      case PlacementZone.midground:
        return '↔️';
      case PlacementZone.background:
        return '⬆️';
      case PlacementZone.floating:
        return '🎈';
    }
  }
}

/// Difficulty level for plant care
enum PlantDifficultyLevel {
  @JsonValue('easy')
  easy,
  @JsonValue('moderate')
  moderate,
  @JsonValue('difficult')
  difficult,
  @JsonValue('expert')
  expert;

  String get displayName {
    switch (this) {
      case PlantDifficultyLevel.easy:
        return 'Easy';
      case PlantDifficultyLevel.moderate:
        return 'Moderate';
      case PlantDifficultyLevel.difficult:
        return 'Difficult';
      case PlantDifficultyLevel.expert:
        return 'Expert';
    }
  }

  String get icon {
    switch (this) {
      case PlantDifficultyLevel.easy:
        return '🟢';
      case PlantDifficultyLevel.moderate:
        return '🟡';
      case PlantDifficultyLevel.difficult:
        return '🟠';
      case PlantDifficultyLevel.expert:
        return '🔴';
    }
  }
}

/// Plant entity for aquarium plants
@freezed
abstract class PlantEntity with _$PlantEntity {
  const PlantEntity._();

  const factory PlantEntity({
    /// Unique identifier (null for new plants)
    int? id,

    /// Tank this plant belongs to
    required int tankId,

    /// Species scientific name
    required String species,

    /// Common name
    String? commonName,

    /// Type of plant
    @Default(PlantType.stem) PlantType plantType,

    /// Number of this species in tank
    @Default(1) int quantity,

    /// Placement zone in tank
    PlacementZone? placementZone,

    /// Lighting requirement
    LightingRequirement? lightingRequirement,

    /// CO2 requirement
    @Default(CO2Requirement.none) CO2Requirement co2Requirement,

    /// Growth rate
    GrowthRate? growthRate,

    /// Difficulty level
    PlantDifficultyLevel? difficultyLevel,

    /// Maximum height in cm
    double? maxHeightCm,

    /// Current height in cm
    double? currentHeightCm,

    /// Minimum temperature in Celsius
    double? minTempCelsius,

    /// Maximum temperature in Celsius
    double? maxTempCelsius,

    /// Minimum pH
    double? minPh,

    /// Maximum pH
    double? maxPh,

    /// Date added to tank
    DateTime? dateAdded,

    /// Date removed from tank
    DateTime? dateRemoved,

    /// Is this plant propagated from another
    @Default(false) bool isPropagated,

    /// Parent plant ID (if propagated)
    int? parentPlantId,

    /// Purchase price
    double? purchasePrice,

    /// Source/store where purchased
    String? source,

    /// Notes/additional info
    String? notes,

    /// Photo URL or path
    String? photoUrl,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _PlantEntity;

  factory PlantEntity.fromJson(Map<String, dynamic> json) =>
      _$PlantEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Display name (common name or species)
  String get displayName => commonName ?? species;

  /// Full name with species
  String get fullName {
    if (commonName != null && commonName!.isNotEmpty) {
      return '$commonName ($species)';
    }
    return species;
  }

  /// Whether the plant has been removed
  bool get isRemoved => dateRemoved != null;

  /// Whether the plant is active (not removed)
  bool get isActive => !isRemoved;

  /// Days in tank
  int? get daysInTank {
    if (dateAdded == null) return null;
    final endDate = dateRemoved ?? DateTime.now();
    return endDate.difference(dateAdded!).inDays;
  }

  /// Temperature range display
  String? get temperatureRangeDisplay {
    if (minTempCelsius == null && maxTempCelsius == null) return null;
    if (minTempCelsius != null && maxTempCelsius != null) {
      return '${minTempCelsius!.toStringAsFixed(0)}-${maxTempCelsius!.toStringAsFixed(0)}°C';
    }
    if (minTempCelsius != null)
      return '>${minTempCelsius!.toStringAsFixed(0)}°C';
    return '<${maxTempCelsius!.toStringAsFixed(0)}°C';
  }

  /// pH range display
  String? get phRangeDisplay {
    if (minPh == null && maxPh == null) return null;
    if (minPh != null && maxPh != null) {
      return '${minPh!.toStringAsFixed(1)}-${maxPh!.toStringAsFixed(1)}';
    }
    if (minPh != null) return '>${minPh!.toStringAsFixed(1)}';
    return '<${maxPh!.toStringAsFixed(1)}';
  }

  /// Height display
  String? get heightDisplay {
    if (currentHeightCm != null && maxHeightCm != null) {
      return '${currentHeightCm!.toStringAsFixed(0)}/${maxHeightCm!.toStringAsFixed(0)} cm';
    }
    if (maxHeightCm != null) return 'Max ${maxHeightCm!.toStringAsFixed(0)} cm';
    if (currentHeightCm != null)
      return '${currentHeightCm!.toStringAsFixed(0)} cm';
    return null;
  }

  /// Status display
  String get statusDisplay {
    if (isRemoved) return 'Removed';
    if (isPropagated) return 'Propagated';
    return 'Active';
  }

  /// Quantity display
  String get quantityDisplay {
    if (quantity == 1) return '1 plant';
    return '$quantity plants';
  }

  /// Type icon with name
  String get typeWithIcon => '${plantType.icon} ${plantType.displayName}';

  /// Requirements summary
  String get requirementsSummary {
    final parts = <String>[];
    if (lightingRequirement != null) {
      parts.add(
        '${lightingRequirement!.icon} ${lightingRequirement!.displayName}',
      );
    }
    if (co2Requirement != CO2Requirement.none) {
      parts.add('CO₂: ${co2Requirement.displayName}');
    }
    if (difficultyLevel != null) {
      parts.add('${difficultyLevel!.icon} ${difficultyLevel!.displayName}');
    }
    return parts.isEmpty ? 'No requirements specified' : parts.join(' • ');
  }
}
