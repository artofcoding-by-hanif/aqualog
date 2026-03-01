import 'package:freezed_annotation/freezed_annotation.dart';

part 'lighting.freezed.dart';
part 'lighting.g.dart';

/// Lighting types for aquarium lighting
enum LightingType {
  @JsonValue('led')
  led,
  @JsonValue('fluorescent')
  fluorescent,
  @JsonValue('t5')
  t5,
  @JsonValue('t8')
  t8,
  @JsonValue('metal_halide')
  metalHalide,
  @JsonValue('incandescent')
  incandescent,
  @JsonValue('compact_fluorescent')
  compactFluorescent,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case LightingType.led:
        return 'LED';
      case LightingType.fluorescent:
        return 'Fluorescent';
      case LightingType.t5:
        return 'T5';
      case LightingType.t8:
        return 'T8';
      case LightingType.metalHalide:
        return 'Metal Halide';
      case LightingType.incandescent:
        return 'Incandescent';
      case LightingType.compactFluorescent:
        return 'Compact Fluorescent (CFL)';
      case LightingType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case LightingType.led:
        return '💡';
      case LightingType.fluorescent:
        return '🔦';
      case LightingType.t5:
        return '📏';
      case LightingType.t8:
        return '📐';
      case LightingType.metalHalide:
        return '☀️';
      case LightingType.incandescent:
        return '🔆';
      case LightingType.compactFluorescent:
        return '💫';
      case LightingType.other:
        return '⚙️';
    }
  }

  /// Short description of the lighting type
  String get description {
    switch (this) {
      case LightingType.led:
        return 'Energy efficient, long lasting, customizable spectrum';
      case LightingType.fluorescent:
        return 'Standard tube lighting, good coverage';
      case LightingType.t5:
        return 'High output fluorescent, great for plants';
      case LightingType.t8:
        return 'Standard fluorescent tube';
      case LightingType.metalHalide:
        return 'High intensity, deep penetration';
      case LightingType.incandescent:
        return 'Traditional bulb, high heat output';
      case LightingType.compactFluorescent:
        return 'Compact, moderate output';
      case LightingType.other:
        return 'Other lighting type';
    }
  }
}

/// Light spectrum category
enum LightSpectrum {
  @JsonValue('daylight')
  daylight,
  @JsonValue('warm_white')
  warmWhite,
  @JsonValue('cool_white')
  coolWhite,
  @JsonValue('full_spectrum')
  fullSpectrum,
  @JsonValue('plant_growth')
  plantGrowth,
  @JsonValue('actinic_blue')
  actinicBlue,
  @JsonValue('rgb')
  rgb,
  @JsonValue('custom')
  custom;

  String get displayName {
    switch (this) {
      case LightSpectrum.daylight:
        return 'Daylight (5000-6500K)';
      case LightSpectrum.warmWhite:
        return 'Warm White (2700-3000K)';
      case LightSpectrum.coolWhite:
        return 'Cool White (4000-4500K)';
      case LightSpectrum.fullSpectrum:
        return 'Full Spectrum';
      case LightSpectrum.plantGrowth:
        return 'Plant Growth';
      case LightSpectrum.actinicBlue:
        return 'Actinic Blue';
      case LightSpectrum.rgb:
        return 'RGB';
      case LightSpectrum.custom:
        return 'Custom';
    }
  }
}

/// Lighting entity - represents an aquarium light fixture
@freezed
abstract class LightingEntity with _$LightingEntity {
  const LightingEntity._();

  const factory LightingEntity({
    /// Unique identifier (null for new lights)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Light name/label
    required String name,

    /// Lighting type
    required LightingType lightingType,

    /// Brand name
    String? brand,

    /// Model number/name
    String? model,

    /// Power consumption in watts
    double? wattage,

    /// Color temperature in Kelvin
    int? kelvinRating,

    /// Light spectrum category
    LightSpectrum? spectrum,

    /// PAR (Photosynthetically Active Radiation) value at substrate
    int? parValue,

    /// Lumens output
    int? lumens,

    /// Whether the light is dimmable
    @Default(false) bool isDimmable,

    /// Whether the light has timer functionality
    @Default(false) bool hasTimer,

    /// Whether the light has color control (RGB)
    @Default(false) bool hasColorControl,

    /// Light on time (HH:mm format, e.g., "08:00")
    String? onTime,

    /// Light off time (HH:mm format, e.g., "20:00")
    String? offTime,

    /// Current intensity percentage (0-100)
    @Default(100) int intensityPercent,

    /// Last bulb/LED replacement date
    DateTime? lastReplacedAt,

    /// Recommended replacement interval in days (for bulbs)
    @Default(365) int replacementIntervalDays,

    /// Notes/additional info
    String? notes,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _LightingEntity;

  factory LightingEntity.fromJson(Map<String, dynamic> json) =>
      _$LightingEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Days since last replacement
  int? get daysSinceReplaced {
    if (lastReplacedAt == null) return null;
    return DateTime.now().difference(lastReplacedAt!).inDays;
  }

  /// Whether replacement is due based on interval
  bool get isReplacementDue {
    final days = daysSinceReplaced;
    if (days == null) return false; // No replacement date set
    return days >= replacementIntervalDays;
  }

  /// Days until next replacement is due
  int? get daysUntilReplacementDue {
    final days = daysSinceReplaced;
    if (days == null) return null;
    final remaining = replacementIntervalDays - days;
    return remaining > 0 ? remaining : 0;
  }

  /// Photoperiod duration in hours
  double? get photoperiodHours {
    if (onTime == null || offTime == null) return null;
    try {
      final onParts = onTime!.split(':');
      final offParts = offTime!.split(':');
      final onMinutes = int.parse(onParts[0]) * 60 + int.parse(onParts[1]);
      final offMinutes = int.parse(offParts[0]) * 60 + int.parse(offParts[1]);

      int durationMinutes;
      if (offMinutes >= onMinutes) {
        durationMinutes = offMinutes - onMinutes;
      } else {
        // Light spans midnight
        durationMinutes = (24 * 60 - onMinutes) + offMinutes;
      }
      return durationMinutes / 60.0;
    } catch (_) {
      return null;
    }
  }

  /// Display string for photoperiod
  String? get photoperiodDisplay {
    if (onTime == null || offTime == null) return null;
    final hours = photoperiodHours;
    if (hours == null) return '$onTime - $offTime';
    return '$onTime - $offTime (${hours.toStringAsFixed(1)}h)';
  }

  /// Display string for wattage
  String? get wattageDisplay {
    if (wattage == null) return null;
    return '${wattage!.toStringAsFixed(0)}W';
  }

  /// Display string for color temperature
  String? get kelvinDisplay {
    if (kelvinRating == null) return null;
    return '${kelvinRating}K';
  }

  /// Display string for PAR value
  String? get parDisplay {
    if (parValue == null) return null;
    return '$parValue PAR';
  }

  /// Full display name including brand/model
  String get fullName {
    final parts = <String>[];
    if (brand != null && brand!.isNotEmpty) parts.add(brand!);
    if (model != null && model!.isNotEmpty) parts.add(model!);
    if (parts.isEmpty) return name;
    return '${parts.join(' ')} - $name';
  }

  /// Light features summary
  String get featuresDisplay {
    final features = <String>[];
    if (isDimmable) features.add('Dimmable');
    if (hasTimer) features.add('Timer');
    if (hasColorControl) features.add('RGB');
    if (features.isEmpty) return 'Basic';
    return features.join(', ');
  }

  /// Maintenance status summary
  String get maintenanceStatus {
    if (isReplacementDue) {
      return 'Replacement due';
    }
    final daysLeft = daysUntilReplacementDue;
    if (daysLeft != null && daysLeft <= 30) {
      return 'Replacement due in $daysLeft days';
    }
    return 'Up to date';
  }

  /// Whether this light is suitable for planted tanks (based on PAR)
  bool get isSuitableForPlants {
    if (parValue == null) return false;
    return parValue! >= 50; // Generally 50+ PAR is good for plants
  }

  /// Light intensity category based on PAR
  String get intensityCategory {
    if (parValue == null) return 'Unknown';
    if (parValue! < 30) return 'Low';
    if (parValue! < 50) return 'Low-Medium';
    if (parValue! < 100) return 'Medium';
    if (parValue! < 150) return 'Medium-High';
    return 'High';
  }
}
