import 'package:freezed_annotation/freezed_annotation.dart';

part 'fish.freezed.dart';
part 'fish.g.dart';

/// Water type preference for fish
enum WaterType {
  @JsonValue('freshwater')
  freshwater,
  @JsonValue('saltwater')
  saltwater,
  @JsonValue('brackish')
  brackish;

  String get displayName {
    switch (this) {
      case WaterType.freshwater:
        return 'Freshwater';
      case WaterType.saltwater:
        return 'Saltwater';
      case WaterType.brackish:
        return 'Brackish';
    }
  }

  String get icon {
    switch (this) {
      case WaterType.freshwater:
        return '💧';
      case WaterType.saltwater:
        return '🌊';
      case WaterType.brackish:
        return '🏝️';
    }
  }
}

/// Fish temperament/behavior
enum FishTemperament {
  @JsonValue('peaceful')
  peaceful,
  @JsonValue('semi_aggressive')
  semiAggressive,
  @JsonValue('aggressive')
  aggressive,
  @JsonValue('territorial')
  territorial,
  @JsonValue('schooling')
  schooling,
  @JsonValue('shy')
  shy;

  String get displayName {
    switch (this) {
      case FishTemperament.peaceful:
        return 'Peaceful';
      case FishTemperament.semiAggressive:
        return 'Semi-Aggressive';
      case FishTemperament.aggressive:
        return 'Aggressive';
      case FishTemperament.territorial:
        return 'Territorial';
      case FishTemperament.schooling:
        return 'Schooling';
      case FishTemperament.shy:
        return 'Shy';
    }
  }

  String get icon {
    switch (this) {
      case FishTemperament.peaceful:
        return '😊';
      case FishTemperament.semiAggressive:
        return '😐';
      case FishTemperament.aggressive:
        return '😠';
      case FishTemperament.territorial:
        return '🏠';
      case FishTemperament.schooling:
        return '🐟';
      case FishTemperament.shy:
        return '🙈';
    }
  }

  String get description {
    switch (this) {
      case FishTemperament.peaceful:
        return 'Gets along well with most tank mates';
      case FishTemperament.semiAggressive:
        return 'May show aggression to similar species';
      case FishTemperament.aggressive:
        return 'May attack other fish, needs careful tank mate selection';
      case FishTemperament.territorial:
        return 'Defends specific areas, needs adequate space';
      case FishTemperament.schooling:
        return 'Thrives in groups of 6 or more';
      case FishTemperament.shy:
        return 'Needs hiding spots and peaceful tank mates';
    }
  }
}

/// Fish diet type
enum FishDiet {
  @JsonValue('carnivore')
  carnivore,
  @JsonValue('herbivore')
  herbivore,
  @JsonValue('omnivore')
  omnivore,
  @JsonValue('insectivore')
  insectivore,
  @JsonValue('piscivore')
  piscivore,
  @JsonValue('detritivore')
  detritivore;

  String get displayName {
    switch (this) {
      case FishDiet.carnivore:
        return 'Carnivore';
      case FishDiet.herbivore:
        return 'Herbivore';
      case FishDiet.omnivore:
        return 'Omnivore';
      case FishDiet.insectivore:
        return 'Insectivore';
      case FishDiet.piscivore:
        return 'Piscivore';
      case FishDiet.detritivore:
        return 'Detritivore';
    }
  }

  String get icon {
    switch (this) {
      case FishDiet.carnivore:
        return '🥩';
      case FishDiet.herbivore:
        return '🥬';
      case FishDiet.omnivore:
        return '🍽️';
      case FishDiet.insectivore:
        return '🦗';
      case FishDiet.piscivore:
        return '🐟';
      case FishDiet.detritivore:
        return '🍂';
    }
  }

  String get description {
    switch (this) {
      case FishDiet.carnivore:
        return 'Meat-based diet, frozen/live foods';
      case FishDiet.herbivore:
        return 'Plant-based diet, algae and vegetables';
      case FishDiet.omnivore:
        return 'Varied diet, accepts most foods';
      case FishDiet.insectivore:
        return 'Insect-based diet, larvae and bugs';
      case FishDiet.piscivore:
        return 'Fish-eating predator';
      case FishDiet.detritivore:
        return 'Feeds on organic debris and waste';
    }
  }
}

/// Care level difficulty
enum CareLevel {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('expert')
  expert;

  String get displayName {
    switch (this) {
      case CareLevel.beginner:
        return 'Beginner';
      case CareLevel.intermediate:
        return 'Intermediate';
      case CareLevel.advanced:
        return 'Advanced';
      case CareLevel.expert:
        return 'Expert';
    }
  }

  String get icon {
    switch (this) {
      case CareLevel.beginner:
        return '🟢';
      case CareLevel.intermediate:
        return '🟡';
      case CareLevel.advanced:
        return '🟠';
      case CareLevel.expert:
        return '🔴';
    }
  }

  String get description {
    switch (this) {
      case CareLevel.beginner:
        return 'Hardy, forgiving of mistakes';
      case CareLevel.intermediate:
        return 'Requires stable water parameters';
      case CareLevel.advanced:
        return 'Specific requirements, experience needed';
      case CareLevel.expert:
        return 'Challenging, specialized care required';
    }
  }
}

/// Swimming level in the tank
enum SwimmingLevel {
  @JsonValue('top')
  top,
  @JsonValue('middle')
  middle,
  @JsonValue('bottom')
  bottom,
  @JsonValue('all')
  all;

  String get displayName {
    switch (this) {
      case SwimmingLevel.top:
        return 'Top';
      case SwimmingLevel.middle:
        return 'Middle';
      case SwimmingLevel.bottom:
        return 'Bottom';
      case SwimmingLevel.all:
        return 'All Levels';
    }
  }

  String get icon {
    switch (this) {
      case SwimmingLevel.top:
        return '⬆️';
      case SwimmingLevel.middle:
        return '↔️';
      case SwimmingLevel.bottom:
        return '⬇️';
      case SwimmingLevel.all:
        return '↕️';
    }
  }
}

/// Fish entity - represents a fish in the aquarium
@freezed
abstract class FishEntity with _$FishEntity {
  const FishEntity._();

  const factory FishEntity({
    /// Unique identifier (null for new fish)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Species scientific name
    required String species,

    /// Common name
    String? commonName,

    /// Number of this species in tank
    @Default(1) int quantity,

    /// Water type preference
    @Default(WaterType.freshwater) WaterType waterType,

    /// Fish temperament
    FishTemperament? temperament,

    /// Diet type
    FishDiet? diet,

    /// Care level difficulty
    CareLevel? careLevel,

    /// Swimming level in tank
    SwimmingLevel? swimmingLevel,

    /// Maximum adult size in cm
    double? maxSizeCm,

    /// Current size in cm
    double? currentSizeCm,

    /// Minimum tank size in liters
    double? minTankSizeLiters,

    /// Minimum temperature in Celsius
    double? minTempCelsius,

    /// Maximum temperature in Celsius
    double? maxTempCelsius,

    /// Minimum pH
    double? minPh,

    /// Maximum pH
    double? maxPh,

    /// Lifespan in years
    int? lifespanYears,

    /// Date added to tank
    DateTime? dateAdded,

    /// Date of death (if deceased)
    DateTime? dateDeceased,

    /// Purchase price
    double? purchasePrice,

    /// Source/store where purchased
    String? source,

    /// Is this fish quarantined
    @Default(false) bool isQuarantined,

    /// Quarantine end date
    DateTime? quarantineEndDate,

    /// Notes/additional info
    String? notes,

    /// Photo URL or path
    String? photoUrl,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _FishEntity;

  factory FishEntity.fromJson(Map<String, dynamic> json) =>
      _$FishEntityFromJson(json);

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

  /// Whether the fish is alive
  bool get isAlive => dateDeceased == null;

  /// Whether the fish is deceased
  bool get isDeceased => dateDeceased != null;

  /// Days in tank
  int? get daysInTank {
    if (dateAdded == null) return null;
    final endDate = dateDeceased ?? DateTime.now();
    return endDate.difference(dateAdded!).inDays;
  }

  /// Age display string
  String get ageInTankDisplay {
    final days = daysInTank;
    if (days == null) return 'Unknown';
    if (days < 7) return '$days days';
    if (days < 30) return '${(days / 7).floor()} weeks';
    if (days < 365) return '${(days / 30).floor()} months';
    return '${(days / 365).floor()} years';
  }

  /// Max size in inches
  double? get maxSizeInches => maxSizeCm != null ? maxSizeCm! / 2.54 : null;

  /// Current size in inches
  double? get currentSizeInches =>
      currentSizeCm != null ? currentSizeCm! / 2.54 : null;

  /// Size display string
  String get sizeDisplay {
    if (currentSizeCm != null) {
      return '${currentSizeCm!.toStringAsFixed(1)} cm';
    }
    if (maxSizeCm != null) {
      return 'Max: ${maxSizeCm!.toStringAsFixed(1)} cm';
    }
    return 'Unknown';
  }

  /// Temperature range display
  String? get temperatureRangeDisplay {
    if (minTempCelsius == null && maxTempCelsius == null) return null;
    if (minTempCelsius != null && maxTempCelsius != null) {
      return '${minTempCelsius!.toStringAsFixed(0)}-${maxTempCelsius!.toStringAsFixed(0)}°C';
    }
    if (minTempCelsius != null) {
      return '>${minTempCelsius!.toStringAsFixed(0)}°C';
    }
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

  /// Whether fish is in quarantine
  bool get isInQuarantine {
    if (!isQuarantined) return false;
    if (quarantineEndDate == null) return true;
    return DateTime.now().isBefore(quarantineEndDate!);
  }

  /// Days remaining in quarantine
  int? get quarantineDaysRemaining {
    if (!isInQuarantine || quarantineEndDate == null) return null;
    return quarantineEndDate!.difference(DateTime.now()).inDays;
  }

  /// Status display
  String get statusDisplay {
    if (isDeceased) return 'Deceased';
    if (isInQuarantine) return 'Quarantined';
    return 'Active';
  }

  /// Quantity display with status
  String get quantityDisplay {
    if (quantity == 1) return '1 fish';
    return '$quantity fish';
  }

  /// Minimum school size recommendation
  int get recommendedMinSchoolSize {
    if (temperament == FishTemperament.schooling) return 6;
    return 1;
  }

  /// Whether school size is adequate
  bool get hasAdequateSchoolSize => quantity >= recommendedMinSchoolSize;

  /// School size warning
  String? get schoolSizeWarning {
    if (temperament != FishTemperament.schooling) return null;
    if (hasAdequateSchoolSize) return null;
    return 'Schooling fish - recommend at least $recommendedMinSchoolSize';
  }
}
