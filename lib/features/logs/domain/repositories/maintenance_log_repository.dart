import '../entities/maintenance_log.dart';

/// Maintenance log repository interface
abstract class MaintenanceLogRepository {
  /// Get all maintenance logs for a tank
  Future<List<MaintenanceLogEntity>> getLogsForTank(int tankId);

  /// Get a maintenance log by ID
  Future<MaintenanceLogEntity?> getLogById(int id);

  /// Get the latest maintenance log for a tank
  Future<MaintenanceLogEntity?> getLatestLog(int tankId);

  /// Get the latest maintenance log of a specific type for a tank
  Future<MaintenanceLogEntity?> getLatestLogByType(
    int tankId,
    MaintenanceType type,
  );

  /// Add a new maintenance log
  Future<int> addLog(MaintenanceLogEntity log);

  /// Update an existing maintenance log
  Future<void> updateLog(MaintenanceLogEntity log);

  /// Delete a maintenance log
  Future<void> deleteLog(int id);

  /// Delete all maintenance logs for a tank
  Future<void> deleteLogsForTank(int tankId);

  /// Watch all maintenance logs for a tank (reactive stream)
  Stream<List<MaintenanceLogEntity>> watchLogsForTank(int tankId);
}
