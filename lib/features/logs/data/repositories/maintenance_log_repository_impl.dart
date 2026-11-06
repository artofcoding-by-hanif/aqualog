import '../../../../core/database/app_database.dart';
import '../../domain/entities/maintenance_log.dart';
import '../../domain/repositories/maintenance_log_repository.dart';
import '../models/maintenance_log_model.dart';

/// Maintenance log repository implementation using Drift database
class MaintenanceLogRepositoryImpl implements MaintenanceLogRepository {
  final AppDatabase _db;

  MaintenanceLogRepositoryImpl({required AppDatabase database})
    : _db = database;

  @override
  Future<List<MaintenanceLogEntity>> getLogsForTank(int tankId) async {
    final logs = await _db.getMaintenanceLogsForTank(tankId);
    return logs.map((l) => l.toEntity()).toList();
  }

  @override
  Future<MaintenanceLogEntity?> getLogById(int id) async {
    final log = await _db.getMaintenanceLogById(id);
    return log?.toEntity();
  }

  @override
  Future<MaintenanceLogEntity?> getLatestLog(int tankId) async {
    final log = await _db.getLatestMaintenanceLog(tankId);
    return log?.toEntity();
  }

  @override
  Future<MaintenanceLogEntity?> getLatestLogByType(
    int tankId,
    MaintenanceType type,
  ) async {
    final log = await _db.getLatestMaintenanceLogByType(tankId, type.index);
    return log?.toEntity();
  }

  @override
  Future<int> addLog(MaintenanceLogEntity log) async {
    return await _db.insertMaintenanceLog(log.toCompanion());
  }

  @override
  Future<void> updateLog(MaintenanceLogEntity log) async {
    await _db.updateMaintenanceLog(log.toDriftMaintenanceLog());
  }

  @override
  Future<void> deleteLog(int id) async {
    await _db.deleteMaintenanceLog(id);
  }

  @override
  Future<void> deleteLogsForTank(int tankId) async {
    await _db.deleteMaintenanceLogsForTank(tankId);
  }

  @override
  Stream<List<MaintenanceLogEntity>> watchLogsForTank(int tankId) {
    return _db
        .watchMaintenanceLogsForTank(tankId)
        .map((logs) => logs.map((l) => l.toEntity()).toList());
  }
}
