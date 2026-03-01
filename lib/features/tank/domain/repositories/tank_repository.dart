import '../entities/tank.dart';

/// Tank repository interface
abstract class TankRepository {
  Future<List<TankEntity>> getTanks();
  Future<TankEntity?> getTankById(int id);
  Future<int> addTank(TankEntity tank);
  Future<void> updateTank(TankEntity tank);
  Future<void> deleteTank(int id);
  Future<void> setActiveTank(int id);
  Stream<List<TankEntity>> watchTanks();
  Stream<TankEntity?> watchActiveTank();
}
