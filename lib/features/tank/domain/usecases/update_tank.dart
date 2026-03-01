import '../entities/tank.dart';
import '../repositories/tank_repository.dart';

/// Update tank use case
class UpdateTank {
  final TankRepository repository;

  UpdateTank(this.repository);

  Future<void> call(TankEntity tank) async {
    await repository.updateTank(tank);
  }
}
