import '../../../../core/database/app_database.dart';
import '../../domain/entities/driftwood.dart';
import '../../domain/repositories/driftwood_repository.dart';
import '../models/driftwood_model.dart';

/// Driftwood repository implementation using Drift database
class DriftwoodRepositoryImpl implements DriftwoodRepository {
  final AppDatabase _db;

  DriftwoodRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<DriftwoodEntity>> getDriftwoodsForTank(int tankId) async {
    final driftwoods = await _db.getDriftwoodsForTank(tankId);
    return driftwoods.map((d) => d.toEntity()).toList();
  }

  @override
  Future<DriftwoodEntity?> getDriftwoodById(int id) async {
    final driftwood = await _db.getDriftwoodById(id);
    return driftwood?.toEntity();
  }

  @override
  Future<int> addDriftwood(DriftwoodEntity driftwood) async {
    return await _db.insertDriftwood(driftwood.toCompanion());
  }

  @override
  Future<void> updateDriftwood(DriftwoodEntity driftwood) async {
    await _db.updateDriftwood(driftwood.toDriftDriftwood());
  }

  @override
  Future<void> deleteDriftwood(int id) async {
    await _db.deleteDriftwood(id);
  }

  @override
  Future<void> deleteDriftwoodsForTank(int tankId) async {
    await _db.deleteDriftwoodsForTank(tankId);
  }

  @override
  Stream<List<DriftwoodEntity>> watchDriftwoodsForTank(int tankId) {
    return _db.watchDriftwoodsForTank(tankId).map(
      (driftwoods) => driftwoods.map((d) => d.toEntity()).toList(),
    );
  }
}

