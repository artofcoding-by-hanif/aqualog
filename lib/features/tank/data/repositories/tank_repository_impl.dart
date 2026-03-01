import '../../../../core/database/app_database.dart';
import '../../domain/entities/tank.dart';
import '../../domain/repositories/tank_repository.dart';
import '../models/tank_model.dart';

/// Tank repository implementation using Drift database
class TankRepositoryImpl implements TankRepository {
  final AppDatabase _db;

  TankRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<TankEntity>> getTanks() async {
    final tanks = await _db.getAllTanks();
    return tanks.map((t) => t.toEntity()).toList();
  }

  @override
  Future<TankEntity?> getTankById(int id) async {
    final tank = await _db.getTankById(id);
    return tank?.toEntity();
  }

  @override
  Future<int> addTank(TankEntity tank) async {
    return await _db.insertTank(tank.toCompanion());
  }

  @override
  Future<void> updateTank(TankEntity tank) async {
    await _db.updateTank(tank.toDriftTank());
  }

  @override
  Future<void> deleteTank(int id) async {
    await _db.deleteTank(id);
  }

  @override
  Future<void> setActiveTank(int id) async {
    await _db.setActiveTank(id);
  }

  @override
  Stream<List<TankEntity>> watchTanks() {
    return _db.watchAllTanks().map(
      (tanks) => tanks.map((t) => t.toEntity()).toList(),
    );
  }

  @override
  Stream<TankEntity?> watchActiveTank() {
    return _db.watchActiveTank().map((tank) => tank?.toEntity());
  }
}
