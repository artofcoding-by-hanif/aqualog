import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart' hide FoodType, FeedingResponse;
import '../../data/models/feeding_log_model.dart';
import '../../data/repositories/feeding_log_repository_impl.dart';
import '../../domain/entities/feeding_log.dart';
import '../../domain/repositories/feeding_log_repository.dart';

part 'feeding_log_provider.g.dart';

/// Provider for FeedingLogRepository
@Riverpod(keepAlive: true)
FeedingLogRepository feedingLogRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return FeedingLogRepositoryImpl(database: db);
}

/// Provider to watch all feeding logs for a tank
@Riverpod(keepAlive: true)
Stream<List<FeedingLogEntity>> feedingLogsForTankStream(
  Ref ref,
  int tankId,
) {
  final repo = ref.watch(feedingLogRepositoryProvider);
  return repo.watchLogsForTank(tankId);
}

/// Provider to get a feeding log by ID
@Riverpod(keepAlive: true)
Future<FeedingLogEntity?> feedingLogById(Ref ref, int id) async {
  final repo = ref.watch(feedingLogRepositoryProvider);
  return repo.getLogById(id);
}

/// Provider to get the latest feeding log for a tank
@Riverpod(keepAlive: true)
Future<FeedingLogEntity?> latestFeedingLog(Ref ref, int tankId) async {
  final repo = ref.watch(feedingLogRepositoryProvider);
  return repo.getLatestLog(tankId);
}

/// Provider to get today's feeding logs for a tank
@Riverpod(keepAlive: true)
Future<List<FeedingLogEntity>> todaysFeedingLogs(Ref ref, int tankId) async {
  final repo = ref.watch(feedingLogRepositoryProvider);
  return repo.getTodaysLogs(tankId);
}

/// Notifier for managing feeding log operations for a specific tank
@Riverpod(keepAlive: true)
class FeedingLogNotifier extends _$FeedingLogNotifier {
  @override
  Future<List<FeedingLogEntity>> build(int tankId) async {
    final repo = ref.watch(feedingLogRepositoryProvider);
    return repo.getLogsForTank(tankId);
  }

  FeedingLogRepository get _repo => ref.read(feedingLogRepositoryProvider);

  /// Add a new feeding log
  Future<int> addLog(FeedingLogEntity log) async {
    final id = await _repo.addLog(log);
    ref.invalidateSelf();
    // Also invalidate related providers
    ref.invalidate(latestFeedingLogProvider(log.tankId));
    ref.invalidate(todaysFeedingLogsProvider(log.tankId));
    ref.invalidate(recentFeedingLogsStreamProvider);
    return id;
  }

  /// Update an existing feeding log
  Future<void> updateLog(FeedingLogEntity log) async {
    await _repo.updateLog(log);
    ref.invalidateSelf();
    ref.invalidate(latestFeedingLogProvider(log.tankId));
    ref.invalidate(todaysFeedingLogsProvider(log.tankId));
    ref.invalidate(recentFeedingLogsStreamProvider);
  }

  /// Delete a feeding log
  Future<void> deleteLog(int id, int tankId) async {
    await _repo.deleteLog(id);
    ref.invalidateSelf();
    ref.invalidate(latestFeedingLogProvider(tankId));
    ref.invalidate(todaysFeedingLogsProvider(tankId));
    ref.invalidate(recentFeedingLogsStreamProvider);
  }
}

/// Provider to watch recent feeding logs across all tanks (for dashboard)
@Riverpod(keepAlive: true)
Stream<List<FeedingLogEntity>> recentFeedingLogsStream(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .watchRecentFeedingLogs(limit: 10)
      .map((logs) => logs.map((log) => log.toEntity()).toList());
}

