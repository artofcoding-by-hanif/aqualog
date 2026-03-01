import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';
part 'filter.g.dart';

/// Filter types for aquarium filtration
enum FilterType {
  @JsonValue('hob')
  hob,
  @JsonValue('canister')
  canister,
  @JsonValue('sponge')
  sponge,
  @JsonValue('internal')
  internal,
  @JsonValue('sump')
  sump,
  @JsonValue('undergravel')
  undergravel,
  @JsonValue('fluidized_bed')
  fluidizedBed,
  @JsonValue('wet_dry')
  wetDry,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case FilterType.hob:
        return 'Hang-on-Back (HOB)';
      case FilterType.canister:
        return 'Canister';
      case FilterType.sponge:
        return 'Sponge';
      case FilterType.internal:
        return 'Internal';
      case FilterType.sump:
        return 'Sump';
      case FilterType.undergravel:
        return 'Undergravel';
      case FilterType.fluidizedBed:
        return 'Fluidized Bed';
      case FilterType.wetDry:
        return 'Wet/Dry';
      case FilterType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case FilterType.hob:
        return '🔄';
      case FilterType.canister:
        return '🛢️';
      case FilterType.sponge:
        return '🧽';
      case FilterType.internal:
        return '📦';
      case FilterType.sump:
        return '🗃️';
      case FilterType.undergravel:
        return '⬇️';
      case FilterType.fluidizedBed:
        return '💨';
      case FilterType.wetDry:
        return '💧';
      case FilterType.other:
        return '⚙️';
    }
  }

  /// Short description of the filter type
  String get description {
    switch (this) {
      case FilterType.hob:
        return 'Hangs on tank rim, easy maintenance';
      case FilterType.canister:
        return 'External, high capacity';
      case FilterType.sponge:
        return 'Air-driven, gentle flow';
      case FilterType.internal:
        return 'Submersible, compact';
      case FilterType.sump:
        return 'Separate tank, large volume';
      case FilterType.undergravel:
        return 'Under substrate, uses gravel';
      case FilterType.fluidizedBed:
        return 'Sand-based biological';
      case FilterType.wetDry:
        return 'Trickle filter, high oxygen';
      case FilterType.other:
        return 'Other filter type';
    }
  }
}

/// Filter entity - represents an aquarium filter
@freezed
abstract class FilterEntity with _$FilterEntity {
  const FilterEntity._();

  const factory FilterEntity({
    /// Unique identifier (null for new filters)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Filter name/label
    required String name,

    /// Filter type
    required FilterType filterType,

    /// Brand name
    String? brand,

    /// Model number/name
    String? model,

    /// Flow rate in liters per hour
    double? flowRateLph,

    /// Media volume capacity in liters
    double? mediaVolumeLiters,

    /// Last cleaned date
    DateTime? lastCleanedAt,

    /// Last media replacement date
    DateTime? mediaReplacedAt,

    /// Recommended cleaning interval in days
    @Default(14) int cleaningIntervalDays,

    /// Recommended media replacement interval in days
    @Default(90) int mediaReplacementIntervalDays,

    /// Notes/additional info
    String? notes,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _FilterEntity;

  factory FilterEntity.fromJson(Map<String, dynamic> json) =>
      _$FilterEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Flow rate in gallons per hour
  double? get flowRateGph =>
      flowRateLph != null ? flowRateLph! * 0.264172 : null;

  /// Days since last cleaning
  int? get daysSinceLastCleaned {
    if (lastCleanedAt == null) return null;
    return DateTime.now().difference(lastCleanedAt!).inDays;
  }

  /// Days since media was replaced
  int? get daysSinceMediaReplaced {
    if (mediaReplacedAt == null) return null;
    return DateTime.now().difference(mediaReplacedAt!).inDays;
  }

  /// Whether cleaning is due based on interval
  bool get isCleaningDue {
    final days = daysSinceLastCleaned;
    if (days == null) return true; // Never cleaned
    return days >= cleaningIntervalDays;
  }

  /// Whether media replacement is due based on interval
  bool get isMediaReplacementDue {
    final days = daysSinceMediaReplaced;
    if (days == null) return true; // Never replaced
    return days >= mediaReplacementIntervalDays;
  }

  /// Days until next cleaning is due
  int? get daysUntilCleaningDue {
    final days = daysSinceLastCleaned;
    if (days == null) return null;
    final remaining = cleaningIntervalDays - days;
    return remaining > 0 ? remaining : 0;
  }

  /// Days until next media replacement is due
  int? get daysUntilMediaReplacementDue {
    final days = daysSinceMediaReplaced;
    if (days == null) return null;
    final remaining = mediaReplacementIntervalDays - days;
    return remaining > 0 ? remaining : 0;
  }

  /// Display string for flow rate
  String? flowRateDisplay({bool useGallons = false}) {
    if (flowRateLph == null) return null;
    if (useGallons) {
      return '${flowRateGph!.toStringAsFixed(0)} GPH';
    }
    return '${flowRateLph!.toStringAsFixed(0)} LPH';
  }

  /// Full display name including brand/model
  String get fullName {
    final parts = <String>[];
    if (brand != null && brand!.isNotEmpty) parts.add(brand!);
    if (model != null && model!.isNotEmpty) parts.add(model!);
    if (parts.isEmpty) return name;
    return '${parts.join(' ')} - $name';
  }

  /// Maintenance status summary
  String get maintenanceStatus {
    if (isCleaningDue && isMediaReplacementDue) {
      return 'Cleaning and media replacement due';
    } else if (isCleaningDue) {
      return 'Cleaning due';
    } else if (isMediaReplacementDue) {
      return 'Media replacement due';
    }
    return 'Up to date';
  }
}
