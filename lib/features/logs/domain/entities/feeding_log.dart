import 'package:freezed_annotation/freezed_annotation.dart';

part 'feeding_log.freezed.dart';

/// Types of fish food
enum FoodType {
  flakes,
  pellets,
  granules,
  frozen,
  freezeDried,
  live,
  gel,
  vegetables,
  algaeWafer,
  sinkingPellets,
  other;

  /// Display name for the food type
  String get displayName {
    switch (this) {
      case FoodType.flakes:
        return 'Flakes';
      case FoodType.pellets:
        return 'Pellets';
      case FoodType.granules:
        return 'Granules';
      case FoodType.frozen:
        return 'Frozen';
      case FoodType.freezeDried:
        return 'Freeze-Dried';
      case FoodType.live:
        return 'Live Food';
      case FoodType.gel:
        return 'Gel Food';
      case FoodType.vegetables:
        return 'Vegetables';
      case FoodType.algaeWafer:
        return 'Algae Wafer';
      case FoodType.sinkingPellets:
        return 'Sinking Pellets';
      case FoodType.other:
        return 'Other';
    }
  }

  /// Icon for the food type
  String get icon {
    switch (this) {
      case FoodType.flakes:
        return '🥣';
      case FoodType.pellets:
        return '⚫';
      case FoodType.granules:
        return '🔘';
      case FoodType.frozen:
        return '🧊';
      case FoodType.freezeDried:
        return '🦐';
      case FoodType.live:
        return '🪱';
      case FoodType.gel:
        return '🟢';
      case FoodType.vegetables:
        return '🥬';
      case FoodType.algaeWafer:
        return '🟤';
      case FoodType.sinkingPellets:
        return '⬇️';
      case FoodType.other:
        return '🍽️';
    }
  }
}

/// Fish response to feeding
enum FeedingResponse {
  ateEagerly,
  ateNormally,
  ateSome,
  picky,
  ignored,
  unknown;

  /// Display name for the response
  String get displayName {
    switch (this) {
      case FeedingResponse.ateEagerly:
        return 'Ate Eagerly';
      case FeedingResponse.ateNormally:
        return 'Ate Normally';
      case FeedingResponse.ateSome:
        return 'Ate Some';
      case FeedingResponse.picky:
        return 'Picky';
      case FeedingResponse.ignored:
        return 'Ignored';
      case FeedingResponse.unknown:
        return 'Unknown';
    }
  }

  /// Icon for the response
  String get icon {
    switch (this) {
      case FeedingResponse.ateEagerly:
        return '😋';
      case FeedingResponse.ateNormally:
        return '😊';
      case FeedingResponse.ateSome:
        return '😐';
      case FeedingResponse.picky:
        return '🤨';
      case FeedingResponse.ignored:
        return '😴';
      case FeedingResponse.unknown:
        return '❓';
    }
  }
}

/// Feeding log entity using Freezed pattern
@freezed
abstract class FeedingLogEntity with _$FeedingLogEntity {
  const FeedingLogEntity._();

  const factory FeedingLogEntity({
    /// Unique identifier (null for new logs)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Type of food given
    required FoodType foodType,

    /// Food brand/name (optional)
    String? foodName,

    /// Amount description (e.g., "pinch", "2 pellets", "1 cube")
    String? amount,

    /// Fish response to the feeding
    @Default(FeedingResponse.unknown) FeedingResponse response,

    /// When the feeding occurred
    required DateTime fedAt,

    /// Additional notes
    String? notes,

    /// Created timestamp
    DateTime? createdAt,
  }) = _FeedingLogEntity;

  // ============================================================
  // Computed Properties
  // ============================================================

  /// Display title for the feeding
  String get displayTitle {
    if (foodName != null && foodName!.isNotEmpty) {
      return '$foodName (${foodType.displayName})';
    }
    return foodType.displayName;
  }

  /// Short summary of the feeding
  String get feedingSummary {
    final parts = <String>[];
    parts.add(foodType.displayName);
    if (amount != null && amount!.isNotEmpty) {
      parts.add('• $amount');
    }
    return parts.join(' ');
  }

  /// Days since this feeding
  int get daysSinceFed {
    return DateTime.now().difference(fedAt).inDays;
  }

  /// Human-readable time ago display
  String get timeAgoDisplay {
    final now = DateTime.now();
    final diff = now.difference(fedAt);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    }
    final days = daysSinceFed;
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
    if (response != FeedingResponse.unknown) {
      parts.add(response.displayName);
    }
    return parts.join(' • ');
  }

  /// Whether the fish had a positive response
  bool get hadPositiveResponse =>
      response == FeedingResponse.ateEagerly ||
      response == FeedingResponse.ateNormally;

  /// Whether the fish had a negative response
  bool get hadNegativeResponse =>
      response == FeedingResponse.picky || response == FeedingResponse.ignored;
}
