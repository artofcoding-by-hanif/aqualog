import 'package:freezed_annotation/freezed_annotation.dart';

part 'photoperiod.freezed.dart';
part 'photoperiod.g.dart';

/// Days of the week for scheduling
enum DayOfWeek {
  @JsonValue('monday')
  monday,
  @JsonValue('tuesday')
  tuesday,
  @JsonValue('wednesday')
  wednesday,
  @JsonValue('thursday')
  thursday,
  @JsonValue('friday')
  friday,
  @JsonValue('saturday')
  saturday,
  @JsonValue('sunday')
  sunday;

  String get displayName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Monday';
      case DayOfWeek.tuesday:
        return 'Tuesday';
      case DayOfWeek.wednesday:
        return 'Wednesday';
      case DayOfWeek.thursday:
        return 'Thursday';
      case DayOfWeek.friday:
        return 'Friday';
      case DayOfWeek.saturday:
        return 'Saturday';
      case DayOfWeek.sunday:
        return 'Sunday';
    }
  }

  String get shortName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Mon';
      case DayOfWeek.tuesday:
        return 'Tue';
      case DayOfWeek.wednesday:
        return 'Wed';
      case DayOfWeek.thursday:
        return 'Thu';
      case DayOfWeek.friday:
        return 'Fri';
      case DayOfWeek.saturday:
        return 'Sat';
      case DayOfWeek.sunday:
        return 'Sun';
    }
  }

  /// Convert from DateTime.weekday (1=Monday, 7=Sunday)
  static DayOfWeek fromDateTime(DateTime date) {
    return DayOfWeek.values[date.weekday - 1];
  }
}

/// A single time segment in a photoperiod schedule
@freezed
abstract class PhotoperiodSegment with _$PhotoperiodSegment {
  const PhotoperiodSegment._();

  const factory PhotoperiodSegment({
    /// Start time in HH:mm format (e.g., "08:00")
    required String startTime,

    /// End time in HH:mm format (e.g., "20:00")
    required String endTime,

    /// Intensity percentage (0-100)
    @Default(100) int intensity,

    /// Optional color temperature for this segment (Kelvin)
    int? colorTemperature,

    /// Optional RGB values for color control (hex format, e.g., "#FF5500")
    String? colorHex,

    /// Whether to ramp/fade to this intensity (vs instant switch)
    @Default(false) bool rampEnabled,

    /// Ramp duration in minutes (if rampEnabled)
    @Default(30) int rampDurationMinutes,
  }) = _PhotoperiodSegment;

  factory PhotoperiodSegment.fromJson(Map<String, dynamic> json) =>
      _$PhotoperiodSegmentFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Parse start time to minutes since midnight
  int? get startMinutes {
    try {
      final parts = startTime.split(':');
      return int.parse(parts[0]) * 60 + int.parse(parts[1]);
    } catch (_) {
      return null;
    }
  }

  /// Parse end time to minutes since midnight
  int? get endMinutes {
    try {
      final parts = endTime.split(':');
      return int.parse(parts[0]) * 60 + int.parse(parts[1]);
    } catch (_) {
      return null;
    }
  }

  /// Duration in minutes
  int? get durationMinutes {
    final start = startMinutes;
    final end = endMinutes;
    if (start == null || end == null) return null;
    if (end >= start) {
      return end - start;
    } else {
      // Spans midnight
      return (24 * 60 - start) + end;
    }
  }

  /// Duration in hours
  double? get durationHours {
    final mins = durationMinutes;
    return mins != null ? mins / 60.0 : null;
  }

  /// Display string for duration
  String? get durationDisplay {
    final hours = durationHours;
    if (hours == null) return null;
    return '${hours.toStringAsFixed(1)}h';
  }

  /// Check if a given time (minutes since midnight) falls within this segment
  bool containsTime(int minutesSinceMidnight) {
    final start = startMinutes;
    final end = endMinutes;
    if (start == null || end == null) return false;

    if (end >= start) {
      return minutesSinceMidnight >= start && minutesSinceMidnight < end;
    } else {
      // Spans midnight
      return minutesSinceMidnight >= start || minutesSinceMidnight < end;
    }
  }

  /// Whether this segment is valid
  bool get isValid {
    return startMinutes != null &&
        endMinutes != null &&
        intensity >= 0 &&
        intensity <= 100;
  }
}

/// Photoperiod entity - represents a lighting schedule for a tank
@freezed
abstract class PhotoperiodEntity with _$PhotoperiodEntity {
  const PhotoperiodEntity._();

  const factory PhotoperiodEntity({
    /// Unique identifier (null for new photoperiods)
    int? id,

    /// Foreign key to lighting fixture
    required int lightingId,

    /// Schedule name (e.g., "Summer Schedule", "Plant Growth")
    required String name,

    /// Whether this schedule is currently active
    @Default(true) bool isEnabled,

    /// Light segments in the schedule
    @Default([]) List<PhotoperiodSegment> segments,

    /// Days of the week this schedule applies to
    @Default([]) List<DayOfWeek> activeDays,

    /// Notes/additional info
    String? notes,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _PhotoperiodEntity;

  factory PhotoperiodEntity.fromJson(Map<String, dynamic> json) =>
      _$PhotoperiodEntityFromJson(json);

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Total light hours across all segments
  double get totalLightHours {
    double total = 0;
    for (final segment in segments) {
      final hours = segment.durationHours;
      if (hours != null) {
        total += hours;
      }
    }
    return total;
  }

  /// Get segments sorted by start time
  List<PhotoperiodSegment> get sortedSegments {
    final sorted = List<PhotoperiodSegment>.from(segments);
    sorted.sort((a, b) {
      final aStart = a.startMinutes ?? 0;
      final bStart = b.startMinutes ?? 0;
      return aStart.compareTo(bStart);
    });
    return sorted;
  }

  /// Check if any segments overlap
  bool get hasOverlappingSegments {
    if (segments.length < 2) return false;
    final sorted = sortedSegments;
    for (int i = 0; i < sorted.length - 1; i++) {
      final current = sorted[i];
      final next = sorted[i + 1];
      final currentEnd = current.endMinutes ?? 0;
      final nextStart = next.startMinutes ?? 0;
      // Handle midnight-spanning segments
      if (currentEnd > nextStart && current.startMinutes! < currentEnd) {
        return true;
      }
    }
    return false;
  }

  /// Whether this schedule is valid
  bool get isValidSchedule {
    if (segments.isEmpty) return false;
    if (!segments.every((s) => s.isValid)) return false;
    if (hasOverlappingSegments) return false;
    return true;
  }

  /// Get the current active segment based on current time
  PhotoperiodSegment? getCurrentSegment(DateTime now) {
    final minutesSinceMidnight = now.hour * 60 + now.minute;
    for (final segment in segments) {
      if (segment.containsTime(minutesSinceMidnight)) {
        return segment;
      }
    }
    return null;
  }

  /// Get the intensity at a specific time
  int getIntensityAt(DateTime time) {
    final segment = getCurrentSegment(time);
    return segment?.intensity ?? 0;
  }

  /// Check if light should be on at a specific time
  bool isLightOnAt(DateTime time) {
    if (!isEnabled) return false;
    final dayOfWeek = DayOfWeek.fromDateTime(time);
    if (activeDays.isNotEmpty && !activeDays.contains(dayOfWeek)) {
      return false;
    }
    return getCurrentSegment(time) != null;
  }

  /// Display string for active days
  String get activeDaysDisplay {
    if (activeDays.isEmpty || activeDays.length == 7) {
      return 'Every day';
    }
    if (activeDays.length == 5 &&
        activeDays.contains(DayOfWeek.monday) &&
        activeDays.contains(DayOfWeek.tuesday) &&
        activeDays.contains(DayOfWeek.wednesday) &&
        activeDays.contains(DayOfWeek.thursday) &&
        activeDays.contains(DayOfWeek.friday)) {
      return 'Weekdays';
    }
    if (activeDays.length == 2 &&
        activeDays.contains(DayOfWeek.saturday) &&
        activeDays.contains(DayOfWeek.sunday)) {
      return 'Weekends';
    }
    return activeDays.map((d) => d.shortName).join(', ');
  }

  /// Display string for total light hours
  String get totalLightHoursDisplay {
    return '${totalLightHours.toStringAsFixed(1)}h';
  }

  /// Get first on time across all segments
  String? get firstOnTime {
    if (segments.isEmpty) return null;
    return sortedSegments.first.startTime;
  }

  /// Get last off time across all segments
  String? get lastOffTime {
    if (segments.isEmpty) return null;
    return sortedSegments.last.endTime;
  }

  /// Simple schedule display (first on - last off)
  String? get scheduleDisplay {
    final on = firstOnTime;
    final off = lastOffTime;
    if (on == null || off == null) return null;
    return '$on - $off';
  }
}
