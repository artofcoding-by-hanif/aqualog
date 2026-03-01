import 'package:freezed_annotation/freezed_annotation.dart';

part 'substrate_layer.freezed.dart';
part 'substrate_layer.g.dart';

/// Types of aquarium substrate
enum SubstrateType {
  @JsonValue('aqua_soil')
  aquaSoil,
  @JsonValue('gravel')
  gravel,
  @JsonValue('sand')
  sand,
  @JsonValue('crushed_coral')
  crushedCoral,
  @JsonValue('fluorite')
  fluorite,
  @JsonValue('eco_complete')
  ecoComplete,
  @JsonValue('stratum')
  stratum,
  @JsonValue('controsoil')
  controsoil,
  @JsonValue('amazonia')
  amazonia,
  @JsonValue('power_sand')
  powerSand,
  @JsonValue('lava_rock_substrate')
  lavaRockSubstrate,
  @JsonValue('peat')
  peat,
  @JsonValue('clay')
  clay,
  @JsonValue('root_tabs')
  rootTabs,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case SubstrateType.aquaSoil:
        return 'Aqua Soil';
      case SubstrateType.gravel:
        return 'Gravel';
      case SubstrateType.sand:
        return 'Sand';
      case SubstrateType.crushedCoral:
        return 'Crushed Coral';
      case SubstrateType.fluorite:
        return 'Fluorite';
      case SubstrateType.ecoComplete:
        return 'Eco-Complete';
      case SubstrateType.stratum:
        return 'Stratum';
      case SubstrateType.controsoil:
        return 'Controsoil';
      case SubstrateType.amazonia:
        return 'ADA Amazonia';
      case SubstrateType.powerSand:
        return 'Power Sand';
      case SubstrateType.lavaRockSubstrate:
        return 'Lava Rock Substrate';
      case SubstrateType.peat:
        return 'Peat';
      case SubstrateType.clay:
        return 'Clay';
      case SubstrateType.rootTabs:
        return 'Root Tabs';
      case SubstrateType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case SubstrateType.aquaSoil:
        return '🌱';
      case SubstrateType.gravel:
        return '🪨';
      case SubstrateType.sand:
        return '🏖️';
      case SubstrateType.crushedCoral:
        return '🐚';
      case SubstrateType.fluorite:
        return '💎';
      case SubstrateType.ecoComplete:
        return '🌿';
      case SubstrateType.stratum:
        return '🏔️';
      case SubstrateType.controsoil:
        return '🌾';
      case SubstrateType.amazonia:
        return '🌳';
      case SubstrateType.powerSand:
        return '⚡';
      case SubstrateType.lavaRockSubstrate:
        return '🌋';
      case SubstrateType.peat:
        return '🍂';
      case SubstrateType.clay:
        return '🏺';
      case SubstrateType.rootTabs:
        return '💊';
      case SubstrateType.other:
        return '📦';
    }
  }

  String get description {
    switch (this) {
      case SubstrateType.aquaSoil:
        return 'Nutrient-rich soil for planted tanks, lowers pH';
      case SubstrateType.gravel:
        return 'Inert decorative substrate, easy to clean';
      case SubstrateType.sand:
        return 'Fine substrate, good for bottom dwellers';
      case SubstrateType.crushedCoral:
        return 'Raises pH and hardness, good for African cichlids';
      case SubstrateType.fluorite:
        return 'Porous clay gravel, good for plants';
      case SubstrateType.ecoComplete:
        return 'Complete planted substrate with beneficial bacteria';
      case SubstrateType.stratum:
        return 'Volcanic soil for shrimp and plants';
      case SubstrateType.controsoil:
        return 'Active soil that buffers pH for shrimp';
      case SubstrateType.amazonia:
        return 'Premium aqua soil by ADA, rich in nutrients';
      case SubstrateType.powerSand:
        return 'Base layer substrate for long-term nutrient supply';
      case SubstrateType.lavaRockSubstrate:
        return 'Porous volcanic rock, good for bacteria';
      case SubstrateType.peat:
        return 'Lowers pH and releases tannins';
      case SubstrateType.clay:
        return 'Nutrient-rich base layer for plants';
      case SubstrateType.rootTabs:
        return 'Fertilizer tablets placed in substrate';
      case SubstrateType.other:
        return 'Other substrate type';
    }
  }

  /// Whether this substrate is nutrient-rich for plants
  bool get isNutrientRich {
    switch (this) {
      case SubstrateType.aquaSoil:
      case SubstrateType.fluorite:
      case SubstrateType.ecoComplete:
      case SubstrateType.stratum:
      case SubstrateType.controsoil:
      case SubstrateType.amazonia:
      case SubstrateType.powerSand:
      case SubstrateType.peat:
      case SubstrateType.clay:
      case SubstrateType.rootTabs:
        return true;
      default:
        return false;
    }
  }

  /// Whether this substrate affects water chemistry (pH/hardness)
  bool get affectsWaterChemistry {
    switch (this) {
      case SubstrateType.aquaSoil:
      case SubstrateType.crushedCoral:
      case SubstrateType.stratum:
      case SubstrateType.controsoil:
      case SubstrateType.amazonia:
      case SubstrateType.peat:
        return true;
      default:
        return false;
    }
  }

  /// Whether this substrate is typically used as a base/bottom layer
  bool get isBaseLayer {
    switch (this) {
      case SubstrateType.powerSand:
      case SubstrateType.peat:
      case SubstrateType.clay:
      case SubstrateType.lavaRockSubstrate:
        return true;
      default:
        return false;
    }
  }

  /// Whether this substrate is inert (doesn't affect water parameters)
  bool get isInert {
    switch (this) {
      case SubstrateType.gravel:
      case SubstrateType.sand:
        return true;
      default:
        return false;
    }
  }

  /// Grain size category
  String get grainSize {
    switch (this) {
      case SubstrateType.sand:
        return 'Fine';
      case SubstrateType.aquaSoil:
      case SubstrateType.stratum:
      case SubstrateType.controsoil:
      case SubstrateType.amazonia:
        return 'Small';
      case SubstrateType.gravel:
      case SubstrateType.fluorite:
      case SubstrateType.ecoComplete:
        return 'Medium';
      case SubstrateType.crushedCoral:
      case SubstrateType.lavaRockSubstrate:
        return 'Coarse';
      default:
        return 'Varies';
    }
  }
}

/// Substrate layer entity - represents a layer of substrate in the aquarium
@freezed
abstract class SubstrateLayerEntity with _$SubstrateLayerEntity {
  const SubstrateLayerEntity._();

  const factory SubstrateLayerEntity({
    /// Unique identifier (null for new layers)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Layer name/label
    required String name,

    /// Type of substrate
    required SubstrateType substrateType,

    /// Brand name (e.g., ADA, Fluval, Seachem)
    String? brand,

    /// Depth of this layer in cm
    double? depthCm,

    /// Layer order (0 = bottom, higher = top)
    @Default(0) int layerOrder,

    /// Volume in liters
    double? volumeLiters,

    /// Weight in kg
    double? weightKg,

    /// Color of the substrate
    String? color,

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
  }) = _SubstrateLayerEntity;

  factory SubstrateLayerEntity.fromJson(Map<String, dynamic> json) =>
      _$SubstrateLayerEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Display string for depth
  String? get depthDisplay {
    if (depthCm == null) return null;
    return '${depthCm!.toStringAsFixed(1)} cm';
  }

  /// Display string for volume
  String? get volumeDisplay {
    if (volumeLiters == null) return null;
    return '${volumeLiters!.toStringAsFixed(1)} L';
  }

  /// Display string for weight
  String? get weightDisplay {
    if (weightKg == null) return null;
    return '${weightKg!.toStringAsFixed(1)} kg';
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

  /// Full name with substrate type
  String get fullName => '$name (${substrateType.displayName})';

  /// Layer position display (e.g., "Layer 1 (Bottom)")
  String get layerPositionDisplay {
    if (layerOrder == 0) return 'Bottom Layer';
    return 'Layer ${layerOrder + 1}';
  }

  /// Whether this layer is nutrient-rich
  bool get isNutrientRich => substrateType.isNutrientRich;

  /// Whether this layer affects water chemistry
  bool get affectsWaterChemistry => substrateType.affectsWaterChemistry;

  /// Whether this layer is inert
  bool get isInert => substrateType.isInert;

  /// Water chemistry warning message
  String? get waterChemistryWarning {
    if (!affectsWaterChemistry) return null;
    switch (substrateType) {
      case SubstrateType.aquaSoil:
      case SubstrateType.stratum:
      case SubstrateType.controsoil:
      case SubstrateType.amazonia:
        return 'May lower pH and release ammonia initially';
      case SubstrateType.crushedCoral:
        return 'Raises pH and hardness';
      case SubstrateType.peat:
        return 'Lowers pH and releases tannins';
      default:
        return null;
    }
  }

  /// Substrate info summary
  String get infoSummary {
    final parts = <String>[];
    if (depthDisplay != null) parts.add(depthDisplay!);
    if (brand != null) parts.add(brand!);
    if (color != null) parts.add(color!);
    return parts.isEmpty ? substrateType.displayName : parts.join(' • ');
  }
}
