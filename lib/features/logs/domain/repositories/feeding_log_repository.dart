import '../entities/feeding_log.dart';

/// Feeding log repository interface
abstract class FeedingLogRepository {
  /// Get all feeding logs for a tank
  Future<List<FeedingLogEntity>> getLogsForTank(int tankId);

  /// Get a feeding log by ID
  Future<FeedingLogEntity?> getLogById(int id);

  /// Get the latest feeding log for a tank
  Future<FeedingLogEntity?> getLatestLog(int tankId);

  /// Get today's feeding logs for a tank
  Future<List<FeedingLogEntity>> getTodaysLogs(int tankId);

  /// Add a new feeding log
  Future<int> addLog(FeedingLogEntity log);

  /// Update an existing feeding log
  Future<void> updateLog(FeedingLogEntity log);

  /// Delete a feeding log
  Future<void> deleteLog(int id);

  /// Delete all feeding logs for a tank
  Future<void> deleteLogsForTank(int tankId);

  /// Watch all feeding logs for a tank (reactive stream)
  Stream<List<FeedingLogEntity>> watchLogsForTank(int tankId);
}
