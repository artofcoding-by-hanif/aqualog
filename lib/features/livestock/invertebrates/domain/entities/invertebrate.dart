import 'package:freezed_annotation/freezed_annotation.dart';

part 'invertebrate.freezed.dart';
part 'invertebrate.g.dart';

/// Type of invertebrate
enum InvertebrateType {
  @JsonValue('shrimp')
  shrimp,
  @JsonValue('snail')
  snail,
  @JsonValue('crab')
  crab,
  @JsonValue('crayfish')
  crayfish,
  @JsonValue('clam')
  clam,
  @JsonValue('starfish')
  starfish,
  @JsonValue('urchin')
  urchin,
  @JsonValue('coral')
  coral,
  @JsonValue('anemone')
  anemone,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case InvertebrateType.shrimp:
        return 'Shrimp';
      case InvertebrateType.snail:
        return 'Snail';
      case InvertebrateType.crab:
        return 'Crab';
      case InvertebrateType.crayfish:
        return 'Crayfish';
      case InvertebrateType.clam:
        return 'Clam';
      case InvertebrateType.starfish:
        return 'Starfish';
      case InvertebrateType.urchin:
        return 'Urchin';
      case InvertebrateType.coral:
        return 'Coral';
      case InvertebrateType.anemone:
        return 'Anemone';
      case InvertebrateType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case InvertebrateType.shrimp:
        return '🦐';
      case InvertebrateType.snail:
        return '🐌';
      case InvertebrateType.crab:
        return '🦀';
      case InvertebrateType.crayfish:
        return '🦞';
      case InvertebrateType.clam:
        return '🐚';
      case InvertebrateType.starfish:
        return '⭐';
      case InvertebrateType.urchin:
        return '🔮';
      case InvertebrateType.coral:
        return '🪸';
      case InvertebrateType.anemone:
        return '🌺';
      case InvertebrateType.other:
        return '🦑';
    }
  }

  String get description {
    switch (this) {
      case InvertebrateType.shrimp:
        return 'Freshwater or saltwater shrimp species';
      case InvertebrateType.snail:
        return 'Aquatic snails for algae control or decoration';
      case InvertebrateType.crab:
        return 'Freshwater or saltwater crabs';
      case InvertebrateType.crayfish:
        return 'Freshwater crayfish/crawfish';
      case InvertebrateType.clam:
        return 'Filter-feeding bivalves';
      case InvertebrateType.starfish:
        return 'Marine starfish/sea stars';
      case InvertebrateType.urchin:
        return 'Marine sea urchins';
      case InvertebrateType.coral:
        return 'Soft or hard corals';
      case InvertebrateType.anemone:
        return 'Sea anemones';
      case InvertebrateType.other:
        return 'Other invertebrate species';
    }
  }
}

/// Water type preference
enum InvertWaterType {
  @JsonValue('freshwater')
  freshwater,
  @JsonValue('saltwater')
  saltwater,
  @JsonValue('brackish')
  brackish;

  String get displayName {
    switch (this) {
      case InvertWaterType.freshwater:
        return 'Freshwater';
      case InvertWaterType.saltwater:
        return 'Saltwater';
      case InvertWaterType.brackish:
        return 'Brackish';
    }
  }

  String get icon {
    switch (this) {
      case InvertWaterType.freshwater:
        return '💧';
      case InvertWaterType.saltwater:
        return '🌊';
      case InvertWaterType.brackish:
        return '🏝️';
    }
  }
}

/// Care level difficulty
enum InvertCareLevel {
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
      case InvertCareLevel.beginner:
        return 'Beginner';
      case InvertCareLevel.intermediate:
        return 'Intermediate';
      case InvertCareLevel.advanced:
        return 'Advanced';
      case InvertCareLevel.expert:
        return 'Expert';
    }
  }

  String get icon {
    switch (this) {
      case InvertCareLevel.beginner:
        return '🟢';
      case InvertCareLevel.intermediate:
        return '🟡';
      case InvertCareLevel.advanced:
        return '🟠';
      case InvertCareLevel.expert:
        return '🔴';
    }
  }
}

/// Invertebrate entity for shrimp, snails, and other invertebrates
@freezed
abstract class InvertebrateEntity with _$InvertebrateEntity {
  const InvertebrateEntity._();

  const factory InvertebrateEntity({
    /// Unique identifier (null for new invertebrates)
    int? id,

    /// Tank this invertebrate belongs to
    required int tankId,

    /// Species scientific name
    required String species,

    /// Common name
    String? commonName,

    /// Type of invertebrate
    @Default(InvertebrateType.shrimp) InvertebrateType invertebrateType,

    /// Number of this species in tank
    @Default(1) int quantity,

    /// Water type preference
    @Default(InvertWaterType.freshwater) InvertWaterType waterType,

    /// Care level difficulty
    InvertCareLevel? careLevel,

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

    /// Is this invertebrate quarantined
    @Default(false) bool isQuarantined,

    /// Quarantine end date
    DateTime? quarantineEndDate,

    /// Is this a colony (for shrimp breeding)
    @Default(false) bool isBreedingColony,

    /// Notes/additional info
    String? notes,

    /// Photo URL or path
    String? photoUrl,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _InvertebrateEntity;

  factory InvertebrateEntity.fromJson(Map<String, dynamic> json) =>
      _$InvertebrateEntityFromJson(json);

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

  /// Whether the invertebrate is alive
  bool get isAlive => dateDeceased == null;

  /// Whether the invertebrate is deceased
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

  /// Whether invertebrate is in quarantine
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
    if (isBreedingColony) return 'Breeding Colony';
    return 'Active';
  }

  /// Quantity display with type
  String get quantityDisplay {
    if (isBreedingColony) return 'Colony (~$quantity)';
    if (quantity == 1) return '1 ${invertebrateType.displayName.toLowerCase()}';
    return '$quantity ${invertebrateType.displayName.toLowerCase()}s';
  }

  /// Type icon with name
  String get typeWithIcon =>
      '${invertebrateType.icon} ${invertebrateType.displayName}';
}
