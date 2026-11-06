import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../../../core/settings/settings_provider.dart';
import '../../../logs/presentation/controllers/maintenance_log_provider.dart';
import '../../../logs/data/models/maintenance_log_model.dart';
import '../../../tank/presentation/controllers/tank_image_provider.dart';
import '../../../tank/presentation/controllers/tank_provider.dart';
import '../../domain/milestones.dart';

/// Milestones the user already shared or dismissed (stored on device)
class SeenMilestones extends AsyncNotifier<Set<String>> {
  static const _key = 'seen_milestones';

  @override
  Future<Set<String>> build() async {
    final storage = ref.read(localStorageProvider);
    await storage.initialize();
    return (storage.getStringList(_key) ?? const []).toSet();
  }

  Future<void> markSeen(Milestone milestone) async {
    final next = {...?state.value, milestone.key};
    state = AsyncData(next);
    final storage = ref.read(localStorageProvider);
    await storage.initialize();
    await storage.setStringList(_key, next.toList());
  }
}

final seenMilestonesProvider =
    AsyncNotifierProvider<SeenMilestones, Set<String>>(SeenMilestones.new);

/// The milestone to celebrate on the dashboard, if any
final nextMilestoneProvider = FutureProvider<Milestone?>((ref) async {
  final tanks = await ref.watch(tanksStreamProvider.future);
  final seen = await ref.watch(seenMilestonesProvider.future);
  // Re-check whenever new logs are added
  ref.watch(recentMaintenanceLogsStreamProvider);
  final db = ref.watch(appDatabaseProvider);

  final all = <Milestone>[];
  for (final tank in tanks) {
    final id = tank.id;
    if (id == null) continue;
    final logs = await db.getMaintenanceLogsForTank(id);
    final tests = await db.getWaterParametersForTank(id);
    final cover = await ref.read(tankCoverImageProvider(id).future);
    all.addAll(
      milestonesForTank(
        tankId: id,
        tankName: tank.name,
        daysRunning: tank.daysSinceSetup,
        waterChanges: logs
            .map((l) => l.toEntity())
            .where((l) => l.isWaterChange)
            .length,
        waterTests: tests.length,
        coverPath: cover?.imagePath,
      ),
    );
  }
  return nextMilestone(all, seen);
});
