import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart' hide MaintenanceType;
import '../../data/models/maintenance_log_model.dart';
import '../../data/repositories/maintenance_log_repository_impl.dart';
import '../../domain/entities/maintenance_log.dart';
import '../../domain/repositories/maintenance_log_repository.dart';

part 'maintenance_log_provider.g.dart';

/// Provider for MaintenanceLogRepository
@Riverpod(keepAlive: true)
MaintenanceLogRepository maintenanceLogRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return MaintenanceLogRepositoryImpl(database: db);
}

/// Provider to watch all maintenance logs for a tank
@Riverpod(keepAlive: true)
Stream<List<MaintenanceLogEntity>> maintenanceLogsForTankStream(
  Ref ref,
  int tankId,
) {
  final repo = ref.watch(maintenanceLogRepositoryProvider);
  return repo.watchLogsForTank(tankId);
}

/// Provider to get a maintenance log by ID
@Riverpod(keepAlive: true)
Future<MaintenanceLogEntity?> maintenanceLogById(Ref ref, int id) async {
  final repo = ref.watch(maintenanceLogRepositoryProvider);
  return repo.getLogById(id);
}

/// Provider to get the latest maintenance log for a tank
@Riverpod(keepAlive: true)
Future<MaintenanceLogEntity?> latestMaintenanceLog(Ref ref, int tankId) async {
  final repo = ref.watch(maintenanceLogRepositoryProvider);
  return repo.getLatestLog(tankId);
}

/// Provider to get the latest water change for a tank
@Riverpod(keepAlive: true)
Future<MaintenanceLogEntity?> latestWaterChange(Ref ref, int tankId) async {
  final repo = ref.watch(maintenanceLogRepositoryProvider);
  return repo.getLatestLogByType(tankId, MaintenanceType.waterChange);
}

/// Notifier for managing maintenance log operations for a specific tank
@Riverpod(keepAlive: true)
class MaintenanceLogNotifier extends _$MaintenanceLogNotifier {
  @override
  Future<List<MaintenanceLogEntity>> build(int tankId) async {
    final repo = ref.watch(maintenanceLogRepositoryProvider);
    return repo.getLogsForTank(tankId);
  }

  MaintenanceLogRepository get _repo =>
      ref.read(maintenanceLogRepositoryProvider);

  /// Add a new maintenance log
  Future<int> addLog(MaintenanceLogEntity log) async {
    final id = await _repo.addLog(log);
    ref.invalidateSelf();
    // Also invalidate the latest log providers
    ref.invalidate(latestMaintenanceLogProvider(log.tankId));
    if (log.maintenanceType == MaintenanceType.waterChange) {
      ref.invalidate(latestWaterChangeProvider(log.tankId));
    }
    return id;
  }

  /// Update an existing maintenance log
  Future<void> updateLog(MaintenanceLogEntity log) async {
    await _repo.updateLog(log);
    ref.invalidateSelf();
    ref.invalidate(latestMaintenanceLogProvider(log.tankId));
    if (log.maintenanceType == MaintenanceType.waterChange) {
      ref.invalidate(latestWaterChangeProvider(log.tankId));
    }
  }

  /// Delete a maintenance log
  Future<void> deleteLog(int id, int tankId) async {
    await _repo.deleteLog(id);
    ref.invalidateSelf();
    ref.invalidate(latestMaintenanceLogProvider(tankId));
    ref.invalidate(latestWaterChangeProvider(tankId));
  }
}

/// Provider to watch recent maintenance logs across all tanks (for dashboard)
@Riverpod(keepAlive: true)
Stream<List<MaintenanceLogEntity>> recentMaintenanceLogsStream(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .watchRecentMaintenanceLogs(limit: 10)
      .map((logs) => logs.map((log) => log.toEntity()).toList());
}
