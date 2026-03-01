import '../entities/water_parameter_log.dart';

/// Water parameter log repository interface
abstract class WaterParameterLogRepository {
  /// Get all water parameter logs for a tank
  Future<List<WaterParameterLogEntity>> getLogsForTank(int tankId);

  /// Get a water parameter log by ID
  Future<WaterParameterLogEntity?> getLogById(int id);

  /// Get the latest water parameter log for a tank
  Future<WaterParameterLogEntity?> getLatestLog(int tankId);

  /// Add a new water parameter log
  Future<int> addLog(WaterParameterLogEntity log);

  /// Update an existing water parameter log
  Future<void> updateLog(WaterParameterLogEntity log);

  /// Delete a water parameter log
  Future<void> deleteLog(int id);

  /// Delete all water parameter logs for a tank
  Future<void> deleteLogsForTank(int tankId);

  /// Watch all water parameter logs for a tank (reactive stream)
  Stream<List<WaterParameterLogEntity>> watchLogsForTank(int tankId);
}

