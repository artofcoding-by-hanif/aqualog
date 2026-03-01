import '../../../../core/database/app_database.dart';
import '../../domain/entities/feeding_log.dart';
import '../../domain/repositories/feeding_log_repository.dart';
import '../models/feeding_log_model.dart';

/// Feeding log repository implementation using Drift database
class FeedingLogRepositoryImpl implements FeedingLogRepository {
  final AppDatabase _db;

  FeedingLogRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<FeedingLogEntity>> getLogsForTank(int tankId) async {
    final logs = await _db.getFeedingLogsForTank(tankId);
    return logs.map((l) => l.toEntity()).toList();
  }

  @override
  Future<FeedingLogEntity?> getLogById(int id) async {
    final log = await _db.getFeedingLogById(id);
    return log?.toEntity();
  }

  @override
  Future<FeedingLogEntity?> getLatestLog(int tankId) async {
    final log = await _db.getLatestFeedingLog(tankId);
    return log?.toEntity();
  }

  @override
  Future<List<FeedingLogEntity>> getTodaysLogs(int tankId) async {
    final logs = await _db.getTodaysFeedingLogs(tankId);
    return logs.map((l) => l.toEntity()).toList();
  }

  @override
  Future<int> addLog(FeedingLogEntity log) async {
    return await _db.insertFeedingLog(log.toCompanion());
  }

  @override
  Future<void> updateLog(FeedingLogEntity log) async {
    await _db.updateFeedingLog(log.toDriftFeedingLog());
  }

  @override
  Future<void> deleteLog(int id) async {
    await _db.deleteFeedingLog(id);
  }

  @override
  Future<void> deleteLogsForTank(int tankId) async {
    await _db.deleteFeedingLogsForTank(tankId);
  }

  @override
  Stream<List<FeedingLogEntity>> watchLogsForTank(int tankId) {
    return _db.watchFeedingLogsForTank(tankId).map(
          (logs) => logs.map((l) => l.toEntity()).toList(),
        );
  }
}

