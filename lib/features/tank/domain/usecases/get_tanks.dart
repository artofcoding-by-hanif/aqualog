import '../entities/tank.dart';
import '../repositories/tank_repository.dart';

/// Get tanks use case
class GetTanks {
  final TankRepository repository;

  GetTanks(this.repository);

  Future<List<TankEntity>> call() async {
    return await repository.getTanks();
  }
}
