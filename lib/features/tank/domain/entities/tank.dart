import 'package:freezed_annotation/freezed_annotation.dart';

part 'tank.freezed.dart';
part 'tank.g.dart';

/// Tank/Aquarium types
enum TankType {
  @JsonValue('freshwater')
  freshwater,
  @JsonValue('saltwater')
  saltwater,
  @JsonValue('brackish')
  brackish,
  @JsonValue('planted')
  planted,
  @JsonValue('reef')
  reef,
  @JsonValue('shrimp')
  shrimp,
  @JsonValue('pond')
  pond;

  String get displayName {
    switch (this) {
      case TankType.freshwater:
        return 'Freshwater';
      case TankType.saltwater:
        return 'Saltwater';
      case TankType.brackish:
        return 'Brackish';
      case TankType.planted:
        return 'Planted';
      case TankType.reef:
        return 'Reef';
      case TankType.shrimp:
        return 'Shrimp';
      case TankType.pond:
        return 'Pond';
    }
  }

  String get icon {
    switch (this) {
      case TankType.freshwater:
        return '🐟';
      case TankType.saltwater:
        return '🐠';
      case TankType.brackish:
        return '🦐';
      case TankType.planted:
        return '🌿';
      case TankType.reef:
        return '🪸';
      case TankType.shrimp:
        return '🦐';
      case TankType.pond:
        return '🏞️';
    }
  }
}

/// Tank entity - represents an aquarium/fish tank
@freezed
abstract class TankEntity with _$TankEntity {
  const TankEntity._();

  const factory TankEntity({
    /// Unique identifier (null for new tanks)
    int? id,

    /// Tank name (e.g., "Living Room Tank")
    required String name,

    /// Tank type
    required TankType tankType,

    /// Volume in liters (base unit)
    required double volumeLiters,

    /// Length in cm
    double? lengthCm,

    /// Width in cm
    double? widthCm,

    /// Height in cm
    double? heightCm,

    /// Description/notes
    String? description,

    /// Photo path (local storage)
    String? photoPath,

    /// Setup/start date
    DateTime? setupDate,

    /// Whether this is the currently selected/active tank
    @Default(false) bool isActive,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _TankEntity;

  factory TankEntity.fromJson(Map<String, dynamic> json) =>
      _$TankEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Volume in gallons (US)
  double get volumeGallons => volumeLiters * 0.264172;

  /// Volume in gallons (UK/Imperial)
  double get volumeGallonsUK => volumeLiters * 0.219969;

  /// Whether dimensions are available
  bool get hasDimensions =>
      lengthCm != null && widthCm != null && heightCm != null;

  /// Calculate volume from dimensions (in liters)
  double? get calculatedVolume {
    if (!hasDimensions) return null;
    // Volume = L x W x H / 1000 (cm³ to liters)
    return (lengthCm! * widthCm! * heightCm!) / 1000;
  }

  /// Length in inches
  double? get lengthInches => lengthCm != null ? lengthCm! / 2.54 : null;

  /// Width in inches
  double? get widthInches => widthCm != null ? widthCm! / 2.54 : null;

  /// Height in inches
  double? get heightInches => heightCm != null ? heightCm! / 2.54 : null;

  /// Days since setup
  int? get daysSinceSetup {
    if (setupDate == null) return null;
    return DateTime.now().difference(setupDate!).inDays;
  }

  /// Whether this is a new tank (less than 60 days old)
  bool get isNewTank {
    final days = daysSinceSetup;
    return days != null && days < 60;
  }

  /// Whether the nitrogen cycle is likely complete (30+ days)
  bool get isCycled {
    final days = daysSinceSetup;
    return days != null && days >= 30;
  }

  /// Display string for volume
  String volumeDisplay({bool useGallons = false}) {
    if (useGallons) {
      return '${volumeGallons.toStringAsFixed(1)} gal';
    }
    return '${volumeLiters.toStringAsFixed(1)} L';
  }

  /// Display string for dimensions
  String? get dimensionsDisplay {
    if (!hasDimensions) return null;
    return '${lengthCm!.toStringAsFixed(0)} × ${widthCm!.toStringAsFixed(0)} × ${heightCm!.toStringAsFixed(0)} cm';
  }

  /// Display string for dimensions in inches
  String? get dimensionsDisplayInches {
    if (!hasDimensions) return null;
    return '${lengthInches!.toStringAsFixed(1)} × ${widthInches!.toStringAsFixed(1)} × ${heightInches!.toStringAsFixed(1)} in';
  }
}
