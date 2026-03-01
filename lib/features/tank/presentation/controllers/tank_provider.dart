import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/tank_repository_impl.dart';
import '../../domain/entities/tank.dart';
import '../../domain/repositories/tank_repository.dart';

part 'tank_provider.g.dart';

/// Provider for TankRepository
@Riverpod(keepAlive: true)
TankRepository tankRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return TankRepositoryImpl(database: db);
}

/// Provider to watch all tanks as TankEntity
@Riverpod(keepAlive: true)
Stream<List<TankEntity>> tanksStream(Ref ref) {
  final repo = ref.watch(tankRepositoryProvider);
  return repo.watchTanks();
}

/// Provider to watch the active tank as TankEntity
@Riverpod(keepAlive: true)
Stream<TankEntity?> activeTankStream(Ref ref) {
  final repo = ref.watch(tankRepositoryProvider);
  return repo.watchActiveTank();
}

/// Provider to get a tank by ID
@riverpod
Future<TankEntity?> tankById(Ref ref, int id) async {
  final repo = ref.watch(tankRepositoryProvider);
  return repo.getTankById(id);
}

/// Notifier for managing tank operations
@Riverpod(keepAlive: true)
class TankNotifier extends _$TankNotifier {
  @override
  Future<List<TankEntity>> build() async {
    final repo = ref.watch(tankRepositoryProvider);
    return repo.getTanks();
  }

  TankRepository get _repo => ref.read(tankRepositoryProvider);

  /// Add a new tank
  Future<int> addTank(TankEntity tank) async {
    final id = await _repo.addTank(tank);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing tank
  Future<void> updateTank(TankEntity tank) async {
    await _repo.updateTank(tank);
    ref.invalidateSelf();
  }

  /// Delete a tank
  Future<void> deleteTank(int id) async {
    await _repo.deleteTank(id);
    ref.invalidateSelf();
  }

  /// Set a tank as active
  Future<void> setActiveTank(int id) async {
    await _repo.setActiveTank(id);
    ref.invalidateSelf();
    // Also invalidate the active tank provider
    ref.invalidate(activeTankStreamProvider);
  }

  /// Refresh the tank list
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
