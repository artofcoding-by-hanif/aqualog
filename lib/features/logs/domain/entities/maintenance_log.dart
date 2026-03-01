import 'package:freezed_annotation/freezed_annotation.dart';

part 'maintenance_log.freezed.dart';

/// Types of maintenance activities
enum MaintenanceType {
  waterChange,
  filterCleaning,
  glassCleaning,
  substrateCleaning,
  trimming,
  equipmentMaintenance,
  medicationDose,
  other;

  /// Display name for the maintenance type
  String get displayName {
    switch (this) {
      case MaintenanceType.waterChange:
        return 'Water Change';
      case MaintenanceType.filterCleaning:
        return 'Filter Cleaning';
      case MaintenanceType.glassCleaning:
        return 'Glass Cleaning';
      case MaintenanceType.substrateCleaning:
        return 'Substrate Cleaning';
      case MaintenanceType.trimming:
        return 'Plant Trimming';
      case MaintenanceType.equipmentMaintenance:
        return 'Equipment Maintenance';
      case MaintenanceType.medicationDose:
        return 'Medication Dose';
      case MaintenanceType.other:
        return 'Other';
    }
  }

  /// Icon for the maintenance type
  String get icon {
    switch (this) {
      case MaintenanceType.waterChange:
        return '💧';
      case MaintenanceType.filterCleaning:
        return '🔄';
      case MaintenanceType.glassCleaning:
        return '✨';
      case MaintenanceType.substrateCleaning:
        return '🪨';
      case MaintenanceType.trimming:
        return '✂️';
      case MaintenanceType.equipmentMaintenance:
        return '🔧';
      case MaintenanceType.medicationDose:
        return '💊';
      case MaintenanceType.other:
        return '📝';
    }
  }
}

/// Maintenance log entity using Freezed pattern
@freezed
abstract class MaintenanceLogEntity with _$MaintenanceLogEntity {
  const MaintenanceLogEntity._();

  const factory MaintenanceLogEntity({
    /// Unique identifier (null for new logs)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Type of maintenance performed
    required MaintenanceType maintenanceType,

    /// Title/summary of the maintenance
    required String title,

    /// Detailed notes
    String? notes,

    /// For water changes: percentage of water changed
    double? waterChangePercent,

    /// For water changes: liters of water changed
    double? waterChangeLiters,

    /// When the maintenance was performed
    required DateTime performedAt,

    /// Duration of the maintenance in minutes
    int? durationMinutes,

    /// Created timestamp
    DateTime? createdAt,
  }) = _MaintenanceLogEntity;

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Whether this is a water change log
  bool get isWaterChange => maintenanceType == MaintenanceType.waterChange;

  /// Whether this log has water change details
  bool get hasWaterChangeDetails =>
      isWaterChange &&
      (waterChangePercent != null || waterChangeLiters != null);

  /// Formatted water change percentage
  String? get waterChangePercentDisplay => waterChangePercent != null
      ? '${waterChangePercent!.toStringAsFixed(0)}%'
      : null;

  /// Formatted water change liters
  String? get waterChangeLitersDisplay => waterChangeLiters != null
      ? '${waterChangeLiters!.toStringAsFixed(1)}L'
      : null;

  /// Water change summary (e.g., "25% (50L)")
  String? get waterChangeSummary {
    if (!hasWaterChangeDetails) return null;
    final parts = <String>[];
    if (waterChangePercent != null) {
      parts.add(waterChangePercentDisplay!);
    }
    if (waterChangeLiters != null) {
      parts.add('(${waterChangeLitersDisplay!})');
    }
    return parts.join(' ');
  }

  /// Formatted duration (e.g., "30 min", "1h 15min")
  String? get durationDisplay {
    if (durationMinutes == null) return null;
    if (durationMinutes! < 60) {
      return '$durationMinutes min';
    }
    final hours = durationMinutes! ~/ 60;
    final mins = durationMinutes! % 60;
    if (mins == 0) {
      return '${hours}h';
    }
    return '${hours}h ${mins}min';
  }

  /// Days since this maintenance was performed
  int get daysSincePerformed {
    return DateTime.now().difference(performedAt).inDays;
  }

  /// Human-readable time ago display
  String get timeAgoDisplay {
    final days = daysSincePerformed;
    if (days == 0) return 'Today';
    if (days == 1) return 'Yesterday';
    if (days < 7) return '$days days ago';
    if (days < 30) return '${days ~/ 7} week${days ~/ 7 == 1 ? '' : 's'} ago';
    if (days < 365) {
      return '${days ~/ 30} month${days ~/ 30 == 1 ? '' : 's'} ago';
    }
    return '${days ~/ 365} year${days ~/ 365 == 1 ? '' : 's'} ago';
  }

  /// Summary info for display
  String get infoSummary {
    final parts = <String>[];
    parts.add(timeAgoDisplay);
    if (durationDisplay != null) {
      parts.add(durationDisplay!);
    }
    if (waterChangeSummary != null) {
      parts.add(waterChangeSummary!);
    }
    return parts.join(' • ');
  }

  /// Calculate liters from percentage given tank volume
  static double? calculateLiters(double? percent, double tankVolumeLiters) {
    if (percent == null) return null;
    return (percent / 100) * tankVolumeLiters;
  }

  /// Calculate percentage from liters given tank volume
  static double? calculatePercent(double? liters, double tankVolumeLiters) {
    if (liters == null || tankVolumeLiters == 0) return null;
    return (liters / tankVolumeLiters) * 100;
  }
}
