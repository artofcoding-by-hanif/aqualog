import 'package:freezed_annotation/freezed_annotation.dart';

part 'rock.freezed.dart';
part 'rock.g.dart';

/// Types of aquarium rocks
enum RockType {
  @JsonValue('dragon_stone')
  dragonStone,
  @JsonValue('seiryu')
  seiryu,
  @JsonValue('lava_rock')
  lavaRock,
  @JsonValue('slate')
  slate,
  @JsonValue('river_rock')
  riverRock,
  @JsonValue('petrified_wood')
  petrifiedWood,
  @JsonValue('texas_holey')
  texasHoley,
  @JsonValue('rainbow_rock')
  rainbowRock,
  @JsonValue('pagoda')
  pagoda,
  @JsonValue('elephant_skin')
  elephantSkin,
  @JsonValue('maple_leaf')
  mapleLeaf,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case RockType.dragonStone:
        return 'Dragon Stone (Ohko)';
      case RockType.seiryu:
        return 'Seiryu Stone';
      case RockType.lavaRock:
        return 'Lava Rock';
      case RockType.slate:
        return 'Slate';
      case RockType.riverRock:
        return 'River Rock';
      case RockType.petrifiedWood:
        return 'Petrified Wood';
      case RockType.texasHoley:
        return 'Texas Holey Rock';
      case RockType.rainbowRock:
        return 'Rainbow Rock';
      case RockType.pagoda:
        return 'Pagoda Stone';
      case RockType.elephantSkin:
        return 'Elephant Skin Stone';
      case RockType.mapleLeaf:
        return 'Maple Leaf Rock';
      case RockType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case RockType.dragonStone:
        return '🐉';
      case RockType.seiryu:
        return '🗻';
      case RockType.lavaRock:
        return '🌋';
      case RockType.slate:
        return '🪨';
      case RockType.riverRock:
        return '🏞️';
      case RockType.petrifiedWood:
        return '🪵';
      case RockType.texasHoley:
        return '🕳️';
      case RockType.rainbowRock:
        return '🌈';
      case RockType.pagoda:
        return '🏯';
      case RockType.elephantSkin:
        return '🐘';
      case RockType.mapleLeaf:
        return '🍁';
      case RockType.other:
        return '🪨';
    }
  }

  /// Description of the rock type and its properties
  String get description {
    switch (this) {
      case RockType.dragonStone:
        return 'Lightweight, porous, clay-based. Inert, safe for all tanks.';
      case RockType.seiryu:
        return 'Blue-gray limestone. May raise pH and hardness.';
      case RockType.lavaRock:
        return 'Porous volcanic rock. Great for beneficial bacteria.';
      case RockType.slate:
        return 'Flat, layered stone. Inert, good for caves.';
      case RockType.riverRock:
        return 'Smooth, rounded stones. Generally inert.';
      case RockType.petrifiedWood:
        return 'Fossilized wood. Inert, unique patterns.';
      case RockType.texasHoley:
        return 'Limestone with holes. Raises pH, good for cichlids.';
      case RockType.rainbowRock:
        return 'Colorful sandstone. May affect water chemistry.';
      case RockType.pagoda:
        return 'Layered sedimentary rock. Dramatic appearance.';
      case RockType.elephantSkin:
        return 'Textured gray stone. Generally inert.';
      case RockType.mapleLeaf:
        return 'Leaf-patterned stone. Inert, decorative.';
      case RockType.other:
        return 'Other rock type.';
    }
  }

  /// Whether this rock type typically affects water chemistry
  bool get affectsWaterChemistry {
    switch (this) {
      case RockType.seiryu:
      case RockType.texasHoley:
      case RockType.rainbowRock:
        return true;
      default:
        return false;
    }
  }
}

/// Rock entity - represents a rock/stone in the aquarium hardscape
@freezed
abstract class RockEntity with _$RockEntity {
  const RockEntity._();

  const factory RockEntity({
    /// Unique identifier (null for new rocks)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Rock name/label
    required String name,

    /// Type of rock
    required RockType rockType,

    /// Weight in kilograms
    double? weightKg,

    /// Quantity of this rock type
    @Default(1) int quantity,

    /// Length in cm (longest dimension)
    double? lengthCm,

    /// Width in cm
    double? widthCm,

    /// Height in cm
    double? heightCm,

    /// Purchase price
    double? purchasePrice,

    /// Source/store where purchased
    String? source,

    /// Date added to tank
    DateTime? dateAdded,

    /// Photo URL or path
    String? photoUrl,

    /// Notes/additional info
    String? notes,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _RockEntity;

  factory RockEntity.fromJson(Map<String, dynamic> json) =>
      _$RockEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Weight in pounds
  double? get weightLbs => weightKg != null ? weightKg! * 2.20462 : null;

  /// Display string for weight
  String? weightDisplay({bool usePounds = false}) {
    if (weightKg == null) return null;
    if (usePounds) {
      return '${weightLbs!.toStringAsFixed(1)} lbs';
    }
    return '${weightKg!.toStringAsFixed(1)} kg';
  }

  /// Whether dimensions are available
  bool get hasDimensions =>
      lengthCm != null || widthCm != null || heightCm != null;

  /// Display string for dimensions (L x W x H)
  String? get dimensionsDisplay {
    if (!hasDimensions) return null;
    final parts = <String>[];
    if (lengthCm != null) parts.add(lengthCm!.toStringAsFixed(1));
    if (widthCm != null) parts.add(widthCm!.toStringAsFixed(1));
    if (heightCm != null) parts.add(heightCm!.toStringAsFixed(1));
    return '${parts.join(' × ')} cm';
  }

  /// Days since added to tank
  int? get daysSinceAdded {
    if (dateAdded == null) return null;
    return DateTime.now().difference(dateAdded!).inDays;
  }

  /// Display string for time in tank
  String? get timeInTankDisplay {
    final days = daysSinceAdded;
    if (days == null) return null;
    if (days < 30) return '$days days';
    if (days < 365) return '${(days / 30).floor()} months';
    return '${(days / 365).floor()} years';
  }

  /// Full display name with type
  String get fullName {
    if (name.toLowerCase().contains(rockType.displayName.toLowerCase())) {
      return name;
    }
    return '$name (${rockType.displayName})';
  }

  /// Quantity display
  String get quantityDisplay {
    if (quantity == 1) return '1 piece';
    return '$quantity pieces';
  }

  /// Whether this rock may affect water chemistry
  bool get mayAffectWaterChemistry => rockType.affectsWaterChemistry;

  /// Warning message if rock affects water chemistry
  String? get waterChemistryWarning {
    if (!mayAffectWaterChemistry) return null;
    return '${rockType.displayName} may raise pH and water hardness. Monitor water parameters.';
  }
}
