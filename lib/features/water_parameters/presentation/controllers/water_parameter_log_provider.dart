import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/models/water_parameter_log_model.dart';
import '../../data/repositories/water_parameter_log_repository_impl.dart';
import '../../domain/entities/water_parameter_log.dart';
import '../../domain/repositories/water_parameter_log_repository.dart';

part 'water_parameter_log_provider.g.dart';

/// Provider for WaterParameterLogRepository
@Riverpod(keepAlive: true)
WaterParameterLogRepository waterParameterLogRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return WaterParameterLogRepositoryImpl(database: db);
}

/// Provider to watch all water parameter logs for a tank
@Riverpod(keepAlive: true)
Stream<List<WaterParameterLogEntity>> waterParameterLogsForTankStream(
  Ref ref,
  int tankId,
) {
  final repo = ref.watch(waterParameterLogRepositoryProvider);
  return repo.watchLogsForTank(tankId);
}

/// Provider to get a water parameter log by ID
@Riverpod(keepAlive: true)
Future<WaterParameterLogEntity?> waterParameterLogById(Ref ref, int id) async {
  final repo = ref.watch(waterParameterLogRepositoryProvider);
  return repo.getLogById(id);
}

/// Provider to get the latest water parameter log for a tank
@Riverpod(keepAlive: true)
Future<WaterParameterLogEntity?> latestWaterParameterLog(
  Ref ref,
  int tankId,
) async {
  final repo = ref.watch(waterParameterLogRepositoryProvider);
  return repo.getLatestLog(tankId);
}

/// Notifier for managing water parameter log operations for a specific tank
@Riverpod(keepAlive: true)
class WaterParameterLogNotifier extends _$WaterParameterLogNotifier {
  @override
  Future<List<WaterParameterLogEntity>> build(int tankId) async {
    final repo = ref.watch(waterParameterLogRepositoryProvider);
    return repo.getLogsForTank(tankId);
  }

  WaterParameterLogRepository get _repo =>
      ref.read(waterParameterLogRepositoryProvider);

  /// Add a new water parameter log
  Future<int> addLog(WaterParameterLogEntity log) async {
    final id = await _repo.addLog(log);
    ref.invalidateSelf();
    // Also invalidate the latest log provider
    ref.invalidate(latestWaterParameterLogProvider(log.tankId));
    return id;
  }

  /// Update an existing water parameter log
  Future<void> updateLog(WaterParameterLogEntity log) async {
    await _repo.updateLog(log);
    ref.invalidateSelf();
    ref.invalidate(latestWaterParameterLogProvider(log.tankId));
  }

  /// Delete a water parameter log
  Future<void> deleteLog(int id, int tankId) async {
    await _repo.deleteLog(id);
    ref.invalidateSelf();
    ref.invalidate(latestWaterParameterLogProvider(tankId));
  }
}

/// Provider to watch recent water parameter logs across all tanks (for dashboard)
@Riverpod(keepAlive: true)
Stream<List<WaterParameterLogEntity>> recentWaterParameterLogsStream(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .watchRecentWaterParameters(limit: 10)
      .map((logs) => logs.map((log) => log.toEntity()).toList());
}
