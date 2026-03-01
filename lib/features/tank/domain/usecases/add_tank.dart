import '../entities/tank.dart';
import '../repositories/tank_repository.dart';

/// Add tank use case
class AddTank {
  final TankRepository repository;

  AddTank(this.repository);

  Future<int> call(TankEntity tank) async {
    return await repository.addTank(tank);
  }
}
