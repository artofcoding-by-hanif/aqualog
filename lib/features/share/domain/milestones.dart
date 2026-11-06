/// Moments of pride worth sharing, detected from a tank's history
enum MilestoneType { daysRunning, waterChanges, waterTests }

class Milestone {
  const Milestone({
    required this.tankId,
    required this.tankName,
    required this.type,
    required this.threshold,
    this.coverPath,
  });

  final int tankId;
  final String tankName;
  final MilestoneType type;
  final int threshold;
  final String? coverPath;

  /// Stable id, used to remember which milestones were already shown
  String get key => '$tankId:${type.name}:$threshold';

  String get emoji => switch (type) {
    MilestoneType.daysRunning => '🎉',
    MilestoneType.waterChanges => '💧',
    MilestoneType.waterTests => '🧪',
  };

  /// Big number on the card, e.g. "100", "1"
  String get value => switch (type) {
    MilestoneType.daysRunning when threshold >= 365 => '${threshold ~/ 365}',
    _ => '$threshold',
  };

  /// Unit under the number, e.g. "days running", "year running"
  String get unit => switch (type) {
    MilestoneType.daysRunning when threshold >= 730 => 'years running',
    MilestoneType.daysRunning when threshold >= 365 => 'year running',
    MilestoneType.daysRunning when threshold == 30 => 'days · fully cycled',
    MilestoneType.daysRunning => 'days running',
    MilestoneType.waterChanges => 'water changes logged',
    MilestoneType.waterTests => 'water tests logged',
  };

  /// One-line headline, e.g. "Betta tank is 100 days old!"
  String get headline => switch (type) {
    MilestoneType.daysRunning when threshold == 30 =>
      '$tankName is fully cycled!',
    MilestoneType.daysRunning when threshold >= 365 =>
      '$tankName turned $value ${threshold >= 730 ? 'years' : 'year'} old!',
    MilestoneType.daysRunning => '$tankName is $threshold days old!',
    MilestoneType.waterChanges => '$threshold water changes for $tankName!',
    MilestoneType.waterTests => '$threshold water tests for $tankName!',
  };

  /// Higher ranks are shown first
  int get rank => switch (type) {
    MilestoneType.daysRunning => 3000 + threshold,
    MilestoneType.waterChanges => 2000 + threshold,
    MilestoneType.waterTests => 1000 + threshold,
  };
}

class MilestoneThresholds {
  MilestoneThresholds._();

  static const days = [30, 100, 180, 365, 730, 1095];
  static const waterChanges = [10, 25, 50, 100, 200];
  static const waterTests = [10, 25, 50, 100];
}

/// Highest reached milestone of each type for one tank.
///
/// Only the highest per type is returned, so a long-running tank shows
/// "1 year" rather than every smaller milestone it passed long ago.
List<Milestone> milestonesForTank({
  required int tankId,
  required String tankName,
  required int? daysRunning,
  required int waterChanges,
  required int waterTests,
  String? coverPath,
}) {
  int? highest(List<int> thresholds, int? value) {
    if (value == null) return null;
    final reached = thresholds.where((t) => value >= t);
    return reached.isEmpty ? null : reached.last;
  }

  Milestone? make(MilestoneType type, int? threshold) => threshold == null
      ? null
      : Milestone(
          tankId: tankId,
          tankName: tankName,
          type: type,
          threshold: threshold,
          coverPath: coverPath,
        );

  return [
    ?make(
      MilestoneType.daysRunning,
      highest(MilestoneThresholds.days, daysRunning),
    ),
    ?make(
      MilestoneType.waterChanges,
      highest(MilestoneThresholds.waterChanges, waterChanges),
    ),
    ?make(
      MilestoneType.waterTests,
      highest(MilestoneThresholds.waterTests, waterTests),
    ),
  ];
}

/// The milestone to celebrate next: highest-ranked one not yet [seen]
Milestone? nextMilestone(Iterable<Milestone> all, Set<String> seen) {
  final fresh = all.where((m) => !seen.contains(m.key)).toList()
    ..sort((a, b) => b.rank.compareTo(a.rank));
  return fresh.firstOrNull;
}
