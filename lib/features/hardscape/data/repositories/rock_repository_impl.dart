import '../../../../core/database/app_database.dart';
import '../../domain/entities/rock.dart';
import '../../domain/repositories/rock_repository.dart';
import '../models/rock_model.dart';

/// Rock repository implementation using Drift database
class RockRepositoryImpl implements RockRepository {
  final AppDatabase _db;

  RockRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<RockEntity>> getRocksForTank(int tankId) async {
    final rocks = await _db.getRocksForTank(tankId);
    return rocks.map((r) => r.toEntity()).toList();
  }

  @override
  Future<RockEntity?> getRockById(int id) async {
    final rock = await _db.getRockById(id);
    return rock?.toEntity();
  }

  @override
  Future<int> addRock(RockEntity rock) async {
    return await _db.insertRock(rock.toCompanion());
  }

  @override
  Future<void> updateRock(RockEntity rock) async {
    await _db.updateRock(rock.toDriftRock());
  }

  @override
  Future<void> deleteRock(int id) async {
    await _db.deleteRock(id);
  }

  @override
  Future<void> deleteRocksForTank(int tankId) async {
    await _db.deleteRocksForTank(tankId);
  }

  @override
  Stream<List<RockEntity>> watchRocksForTank(int tankId) {
    return _db
        .watchRocksForTank(tankId)
        .map((rocks) => rocks.map((r) => r.toEntity()).toList());
  }
}
