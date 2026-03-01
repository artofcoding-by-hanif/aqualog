import 'package:freezed_annotation/freezed_annotation.dart';

part 'driftwood.freezed.dart';
part 'driftwood.g.dart';

/// Types of aquarium driftwood
enum DriftwoodType {
  @JsonValue('manzanita')
  manzanita,
  @JsonValue('spider_wood')
  spiderWood,
  @JsonValue('malaysian')
  malaysian,
  @JsonValue('mopani')
  mopani,
  @JsonValue('cholla')
  cholla,
  @JsonValue('bogwood')
  bogwood,
  @JsonValue('redmoor')
  redmoor,
  @JsonValue('sumatra')
  sumatra,
  @JsonValue('savanna')
  savanna,
  @JsonValue('bonsai')
  bonsai,
  @JsonValue('branch')
  branch,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case DriftwoodType.manzanita:
        return 'Manzanita';
      case DriftwoodType.spiderWood:
        return 'Spider Wood (Azalea)';
      case DriftwoodType.malaysian:
        return 'Malaysian Driftwood';
      case DriftwoodType.mopani:
        return 'Mopani Wood';
      case DriftwoodType.cholla:
        return 'Cholla Wood';
      case DriftwoodType.bogwood:
        return 'Bogwood';
      case DriftwoodType.redmoor:
        return 'Redmoor Root';
      case DriftwoodType.sumatra:
        return 'Sumatra Wood';
      case DriftwoodType.savanna:
        return 'Savanna Wood';
      case DriftwoodType.bonsai:
        return 'Bonsai Driftwood';
      case DriftwoodType.branch:
        return 'Branch Wood';
      case DriftwoodType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case DriftwoodType.manzanita:
        return '🌿';
      case DriftwoodType.spiderWood:
        return '🕷️';
      case DriftwoodType.malaysian:
        return '🪵';
      case DriftwoodType.mopani:
        return '🌳';
      case DriftwoodType.cholla:
        return '🌵';
      case DriftwoodType.bogwood:
        return '🪨';
      case DriftwoodType.redmoor:
        return '🔴';
      case DriftwoodType.sumatra:
        return '🏝️';
      case DriftwoodType.savanna:
        return '🦁';
      case DriftwoodType.bonsai:
        return '🌲';
      case DriftwoodType.branch:
        return '🌿';
      case DriftwoodType.other:
        return '🪵';
    }
  }

  /// Description of the driftwood type and its properties
  String get description {
    switch (this) {
      case DriftwoodType.manzanita:
        return 'Branchy, light-colored. Sinks easily, minimal tannins.';
      case DriftwoodType.spiderWood:
        return 'Twisted, gnarly branches. Light, may need soaking.';
      case DriftwoodType.malaysian:
        return 'Dense, dark wood. Heavy tannin release initially.';
      case DriftwoodType.mopani:
        return 'Two-toned, very dense. Sinks immediately, releases tannins.';
      case DriftwoodType.cholla:
        return 'Hollow cactus skeleton. Great for shrimp, sinks quickly.';
      case DriftwoodType.bogwood:
        return 'Aged peat wood. Dark, releases tannins, lowers pH.';
      case DriftwoodType.redmoor:
        return 'Twisted roots. Dramatic shapes, moderate tannins.';
      case DriftwoodType.sumatra:
        return 'Gnarled tropical wood. Unique shapes, needs curing.';
      case DriftwoodType.savanna:
        return 'African hardwood. Dense, minimal tannins.';
      case DriftwoodType.bonsai:
        return 'Shaped like bonsai tree. Decorative, may need anchoring.';
      case DriftwoodType.branch:
        return 'Natural branches. Varies by source, needs proper curing.';
      case DriftwoodType.other:
        return 'Other driftwood type.';
    }
  }

  /// Typical tannin release level (1-5, 5 being highest)
  int get tanninLevel {
    switch (this) {
      case DriftwoodType.manzanita:
        return 1;
      case DriftwoodType.spiderWood:
        return 2;
      case DriftwoodType.malaysian:
        return 4;
      case DriftwoodType.mopani:
        return 4;
      case DriftwoodType.cholla:
        return 1;
      case DriftwoodType.bogwood:
        return 5;
      case DriftwoodType.redmoor:
        return 3;
      case DriftwoodType.sumatra:
        return 3;
      case DriftwoodType.savanna:
        return 2;
      case DriftwoodType.bonsai:
        return 2;
      case DriftwoodType.branch:
        return 3;
      case DriftwoodType.other:
        return 3;
    }
  }

  /// Whether this wood typically sinks without soaking
  bool get sinksNaturally {
    switch (this) {
      case DriftwoodType.manzanita:
      case DriftwoodType.mopani:
      case DriftwoodType.cholla:
      case DriftwoodType.bogwood:
      case DriftwoodType.savanna:
        return true;
      default:
        return false;
    }
  }
}

/// Driftwood entity - represents driftwood in the aquarium hardscape
@freezed
abstract class DriftwoodEntity with _$DriftwoodEntity {
  const DriftwoodEntity._();

  const factory DriftwoodEntity({
    /// Unique identifier (null for new driftwood)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Driftwood name/label
    required String name,

    /// Type of driftwood
    required DriftwoodType driftwoodType,

    /// Whether the wood has been properly cured/waterlogged
    @Default(false) bool isCured,

    /// Whether the wood is currently releasing tannins
    @Default(true) bool isReleasingTannins,

    /// Quantity of pieces
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

    /// Date curing was started (soaking)
    DateTime? curingStartDate,

    /// Photo URL or path
    String? photoUrl,

    /// Notes/additional info
    String? notes,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _DriftwoodEntity;

  factory DriftwoodEntity.fromJson(Map<String, dynamic> json) =>
      _$DriftwoodEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

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

  /// Days since curing started
  int? get daysSinceCuringStarted {
    if (curingStartDate == null) return null;
    return DateTime.now().difference(curingStartDate!).inDays;
  }

  /// Full display name with type
  String get fullName {
    if (name.toLowerCase().contains(driftwoodType.displayName.toLowerCase())) {
      return name;
    }
    return '$name (${driftwoodType.displayName})';
  }

  /// Quantity display
  String get quantityDisplay {
    if (quantity == 1) return '1 piece';
    return '$quantity pieces';
  }

  /// Tannin level from wood type
  int get tanninLevel => driftwoodType.tanninLevel;

  /// Tannin level display
  String get tanninLevelDisplay {
    switch (tanninLevel) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Moderate';
      case 4:
        return 'High';
      case 5:
        return 'Very High';
      default:
        return 'Unknown';
    }
  }

  /// Whether this wood sinks naturally
  bool get sinksNaturally => driftwoodType.sinksNaturally;

  /// Status display
  String get statusDisplay {
    if (!isCured) return 'Curing';
    if (isReleasingTannins) return 'Releasing Tannins';
    return 'Stable';
  }

  /// Curing status with details
  String get curingStatusDisplay {
    if (isCured) return 'Fully cured';
    final days = daysSinceCuringStarted;
    if (days == null) return 'Not cured';
    return 'Curing for $days days';
  }

  /// Tannin warning message
  String? get tanninWarning {
    if (!isReleasingTannins) return null;
    if (tanninLevel >= 4) {
      return 'High tannin release expected. May significantly lower pH and tint water.';
    } else if (tanninLevel >= 3) {
      return 'Moderate tannin release. May tint water amber.';
    }
    return null;
  }
}
