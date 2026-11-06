import '../../../../core/database/app_database.dart';
import '../../domain/entities/water_parameter_log.dart';
import '../../domain/repositories/water_parameter_log_repository.dart';
import '../models/water_parameter_log_model.dart';

/// Water parameter log repository implementation using Drift database
class WaterParameterLogRepositoryImpl implements WaterParameterLogRepository {
  final AppDatabase _db;

  WaterParameterLogRepositoryImpl({required AppDatabase database})
    : _db = database;

  @override
  Future<List<WaterParameterLogEntity>> getLogsForTank(int tankId) async {
    final logs = await _db.getWaterParametersForTank(tankId);
    return logs.map((l) => l.toEntity()).toList();
  }

  @override
  Future<WaterParameterLogEntity?> getLogById(int id) async {
    final log = await _db.getWaterParameterById(id);
    return log?.toEntity();
  }

  @override
  Future<WaterParameterLogEntity?> getLatestLog(int tankId) async {
    final log = await _db.getLatestWaterParameters(tankId);
    return log?.toEntity();
  }

  @override
  Future<int> addLog(WaterParameterLogEntity log) async {
    return await _db.insertWaterParameters(log.toCompanion());
  }

  @override
  Future<void> updateLog(WaterParameterLogEntity log) async {
    await _db.updateWaterParameters(log.toDriftWaterParameter());
  }

  @override
  Future<void> deleteLog(int id) async {
    await _db.deleteWaterParameters(id);
  }

  @override
  Future<void> deleteLogsForTank(int tankId) async {
    await _db.deleteWaterParametersForTank(tankId);
  }

  @override
  Stream<List<WaterParameterLogEntity>> watchLogsForTank(int tankId) {
    return _db
        .watchWaterParametersForTank(tankId)
        .map((logs) => logs.map((l) => l.toEntity()).toList());
  }
}
