import 'package:freezed_annotation/freezed_annotation.dart';

part 'water_parameter_log.freezed.dart';

/// Status of a parameter reading relative to ideal range
enum ParameterStatus {
  optimal,
  warning,
  danger,
  unknown;

  /// Display name for the status
  String get displayName {
    switch (this) {
      case ParameterStatus.optimal:
        return 'Optimal';
      case ParameterStatus.warning:
        return 'Warning';
      case ParameterStatus.danger:
        return 'Danger';
      case ParameterStatus.unknown:
        return 'Unknown';
    }
  }

  /// Icon for the status
  String get icon {
    switch (this) {
      case ParameterStatus.optimal:
        return '✅';
      case ParameterStatus.warning:
        return '⚠️';
      case ParameterStatus.danger:
        return '🚨';
      case ParameterStatus.unknown:
        return '❓';
    }
  }
}

/// Water parameter log entity using Freezed pattern
/// Stores a complete water test reading with all parameters
@freezed
abstract class WaterParameterLogEntity with _$WaterParameterLogEntity {
  const WaterParameterLogEntity._();

  const factory WaterParameterLogEntity({
    /// Unique identifier (null for new logs)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// When the measurement was taken
    required DateTime measuredAt,

    // ============================================================
    // Core Parameters (most commonly tested)
    // ============================================================

    /// Temperature in Celsius
    double? temperatureCelsius,

    /// pH level (0-14)
    double? ph,

    /// Ammonia in ppm (NH3/NH4+)
    double? ammoniaPpm,

    /// Nitrite in ppm (NO2)
    double? nitritePpm,

    /// Nitrate in ppm (NO3)
    double? nitratePpm,

    // ============================================================
    // Hardness Parameters
    // ============================================================

    /// General Hardness (GH) in dGH
    double? ghDgh,

    /// Carbonate Hardness (KH) in dKH
    double? khDkh,

    // ============================================================
    // Additional Freshwater Parameters
    // ============================================================

    /// Phosphate in ppm (PO4)
    double? phosphatePpm,

    /// Dissolved oxygen in mg/L
    double? oxygenMgL,

    /// Carbon dioxide in mg/L
    double? co2MgL,

    /// TDS (Total Dissolved Solids) in ppm
    double? tdsPpm,

    /// Chlorine in ppm
    double? chlorinePpm,

    /// Iron in ppm (for planted tanks)
    double? ironPpm,

    /// Copper in ppm
    double? copperPpm,

    // ============================================================
    // Saltwater/Reef Parameters
    // ============================================================

    /// Salinity in ppt (for saltwater)
    double? salinityPpt,

    /// Calcium in ppm (for reef tanks)
    double? calciumPpm,

    /// Magnesium in ppm (for reef tanks)
    double? magnesiumPpm,

    /// Alkalinity in dKH (for reef tanks)
    double? alkalinityDkh,

    // ============================================================
    // Metadata
    // ============================================================

    /// Notes for this reading
    String? notes,

    /// Created timestamp
    DateTime? createdAt,
  }) = _WaterParameterLogEntity;

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Whether any core parameters are recorded
  bool get hasCoreParameters =>
      temperatureCelsius != null ||
      ph != null ||
      ammoniaPpm != null ||
      nitritePpm != null ||
      nitratePpm != null;

  /// Whether any hardness parameters are recorded
  bool get hasHardnessParameters => ghDgh != null || khDkh != null;

  /// Whether any saltwater parameters are recorded
  bool get hasSaltwaterParameters =>
      salinityPpt != null ||
      calciumPpm != null ||
      magnesiumPpm != null ||
      alkalinityDkh != null;

  /// Count of parameters recorded in this log
  int get parameterCount {
    int count = 0;
    if (temperatureCelsius != null) count++;
    if (ph != null) count++;
    if (ammoniaPpm != null) count++;
    if (nitritePpm != null) count++;
    if (nitratePpm != null) count++;
    if (ghDgh != null) count++;
    if (khDkh != null) count++;
    if (phosphatePpm != null) count++;
    if (oxygenMgL != null) count++;
    if (co2MgL != null) count++;
    if (tdsPpm != null) count++;
    if (chlorinePpm != null) count++;
    if (ironPpm != null) count++;
    if (copperPpm != null) count++;
    if (salinityPpt != null) count++;
    if (calciumPpm != null) count++;
    if (magnesiumPpm != null) count++;
    if (alkalinityDkh != null) count++;
    return count;
  }

  /// Days since this measurement was taken
  int get daysSinceMeasured {
    return DateTime.now().difference(measuredAt).inDays;
  }

  /// Human-readable time ago display
  String get timeAgoDisplay {
    final days = daysSinceMeasured;
    if (days == 0) return 'Today';
    if (days == 1) return 'Yesterday';
    if (days < 7) return '$days days ago';
    if (days < 30) {
      return '${days ~/ 7} week${days ~/ 7 == 1 ? '' : 's'} ago';
    }
    if (days < 365) {
      return '${days ~/ 30} month${days ~/ 30 == 1 ? '' : 's'} ago';
    }
    return '${days ~/ 365} year${days ~/ 365 == 1 ? '' : 's'} ago';
  }

  /// Temperature in Fahrenheit (converted from Celsius)
  double? get temperatureFahrenheit =>
      temperatureCelsius != null ? (temperatureCelsius! * 9 / 5) + 32 : null;

  /// Formatted temperature display (Celsius)
  String? get temperatureDisplay => temperatureCelsius != null
      ? '${temperatureCelsius!.toStringAsFixed(1)}°C'
      : null;

  /// Formatted pH display
  String? get phDisplay => ph?.toStringAsFixed(1);

  /// Formatted ammonia display
  String? get ammoniaDisplay =>
      ammoniaPpm != null ? '${ammoniaPpm!.toStringAsFixed(2)} ppm' : null;

  /// Formatted nitrite display
  String? get nitriteDisplay =>
      nitritePpm != null ? '${nitritePpm!.toStringAsFixed(2)} ppm' : null;

  /// Formatted nitrate display
  String? get nitrateDisplay =>
      nitratePpm != null ? '${nitratePpm!.toStringAsFixed(1)} ppm' : null;

  /// Formatted GH display
  String? get ghDisplay =>
      ghDgh != null ? '${ghDgh!.toStringAsFixed(1)} dGH' : null;

  /// Formatted KH display
  String? get khDisplay =>
      khDkh != null ? '${khDkh!.toStringAsFixed(1)} dKH' : null;

  /// Summary of key parameters for display
  String get parameterSummary {
    final parts = <String>[];
    if (ph != null) parts.add('pH: ${phDisplay!}');
    if (ammoniaPpm != null) parts.add('NH3: ${ammoniaDisplay!}');
    if (nitritePpm != null) parts.add('NO2: ${nitriteDisplay!}');
    if (nitratePpm != null) parts.add('NO3: ${nitrateDisplay!}');
    if (parts.isEmpty && temperatureCelsius != null) {
      parts.add('Temp: ${temperatureDisplay!}');
    }
    return parts.isEmpty ? 'No parameters' : parts.join(' • ');
  }

  /// Info summary for list display
  String get infoSummary {
    return '$parameterCount parameter${parameterCount == 1 ? '' : 's'} • $timeAgoDisplay';
  }

  // ============================================================
  // Parameter Status Helpers (for freshwater tropical)
  // ============================================================

  /// Get ammonia status (0 is ideal, any amount is concerning)
  ParameterStatus get ammoniaStatus {
    if (ammoniaPpm == null) return ParameterStatus.unknown;
    if (ammoniaPpm! <= 0.0) return ParameterStatus.optimal;
    if (ammoniaPpm! <= 0.25) return ParameterStatus.warning;
    return ParameterStatus.danger;
  }

  /// Get nitrite status (0 is ideal, any amount is concerning)
  ParameterStatus get nitriteStatus {
    if (nitritePpm == null) return ParameterStatus.unknown;
    if (nitritePpm! <= 0.0) return ParameterStatus.optimal;
    if (nitritePpm! <= 0.25) return ParameterStatus.warning;
    return ParameterStatus.danger;
  }

  /// Get nitrate status (under 40 ppm is generally acceptable)
  ParameterStatus get nitrateStatus {
    if (nitratePpm == null) return ParameterStatus.unknown;
    if (nitratePpm! <= 20) return ParameterStatus.optimal;
    if (nitratePpm! <= 40) return ParameterStatus.warning;
    return ParameterStatus.danger;
  }

  /// Get pH status (6.5-7.5 is ideal for most freshwater)
  ParameterStatus get phStatus {
    if (ph == null) return ParameterStatus.unknown;
    if (ph! >= 6.5 && ph! <= 7.5) return ParameterStatus.optimal;
    if (ph! >= 6.0 && ph! <= 8.0) return ParameterStatus.warning;
    return ParameterStatus.danger;
  }

  /// Overall status based on critical parameters
  ParameterStatus get overallStatus {
    final statuses = [ammoniaStatus, nitriteStatus, nitrateStatus, phStatus];
    if (statuses.contains(ParameterStatus.danger)) {
      return ParameterStatus.danger;
    }
    if (statuses.contains(ParameterStatus.warning)) {
      return ParameterStatus.warning;
    }
    if (statuses.every((s) => s == ParameterStatus.unknown)) {
      return ParameterStatus.unknown;
    }
    return ParameterStatus.optimal;
  }
}
