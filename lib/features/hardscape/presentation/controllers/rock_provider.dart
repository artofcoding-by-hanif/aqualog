import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/rock_repository_impl.dart';
import '../../domain/entities/rock.dart';
import '../../domain/repositories/rock_repository.dart';

part 'rock_provider.g.dart';

/// Provider for RockRepository
@Riverpod(keepAlive: true)
RockRepository rockRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return RockRepositoryImpl(database: db);
}

/// Provider to watch all rocks for a tank
@Riverpod(keepAlive: true)
Stream<List<RockEntity>> rocksForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(rockRepositoryProvider);
  return repo.watchRocksForTank(tankId);
}

/// Provider to get a rock by ID
@Riverpod(keepAlive: true)
Future<RockEntity?> rockById(Ref ref, int id) async {
  final repo = ref.watch(rockRepositoryProvider);
  return repo.getRockById(id);
}

/// Notifier for managing rock operations for a specific tank
@Riverpod(keepAlive: true)
class RockNotifier extends _$RockNotifier {
  @override
  Future<List<RockEntity>> build(int tankId) async {
    final repo = ref.watch(rockRepositoryProvider);
    return repo.getRocksForTank(tankId);
  }

  RockRepository get _repo => ref.read(rockRepositoryProvider);

  /// Add a new rock
  Future<int> addRock(RockEntity rock) async {
    final id = await _repo.addRock(rock);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing rock
  Future<void> updateRock(RockEntity rock) async {
    await _repo.updateRock(rock);
    ref.invalidateSelf();
  }

  /// Delete a rock
  Future<void> deleteRock(int id) async {
    await _repo.deleteRock(id);
    ref.invalidateSelf();
  }

  /// Update rock quantity
  Future<void> updateQuantity(RockEntity rock, int newQuantity) async {
    final updated = rock.copyWith(quantity: newQuantity);
    await _repo.updateRock(updated);
    ref.invalidateSelf();
  }
}

