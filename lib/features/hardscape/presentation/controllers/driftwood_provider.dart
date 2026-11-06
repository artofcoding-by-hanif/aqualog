import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/driftwood_repository_impl.dart';
import '../../domain/entities/driftwood.dart';
import '../../domain/repositories/driftwood_repository.dart';

part 'driftwood_provider.g.dart';

/// Provider for DriftwoodRepository
@Riverpod(keepAlive: true)
DriftwoodRepository driftwoodRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftwoodRepositoryImpl(database: db);
}

/// Provider to watch all driftwoods for a tank
@Riverpod(keepAlive: true)
Stream<List<DriftwoodEntity>> driftwoodsForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(driftwoodRepositoryProvider);
  return repo.watchDriftwoodsForTank(tankId);
}

/// Provider to get a driftwood by ID
@Riverpod(keepAlive: true)
Future<DriftwoodEntity?> driftwoodById(Ref ref, int id) async {
  final repo = ref.watch(driftwoodRepositoryProvider);
  return repo.getDriftwoodById(id);
}

/// Notifier for managing driftwood operations for a specific tank
@Riverpod(keepAlive: true)
class DriftwoodNotifier extends _$DriftwoodNotifier {
  @override
  Future<List<DriftwoodEntity>> build(int tankId) async {
    final repo = ref.watch(driftwoodRepositoryProvider);
    return repo.getDriftwoodsForTank(tankId);
  }

  DriftwoodRepository get _repo => ref.read(driftwoodRepositoryProvider);

  /// Add a new driftwood
  Future<int> addDriftwood(DriftwoodEntity driftwood) async {
    final id = await _repo.addDriftwood(driftwood);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing driftwood
  Future<void> updateDriftwood(DriftwoodEntity driftwood) async {
    await _repo.updateDriftwood(driftwood);
    ref.invalidateSelf();
  }

  /// Delete a driftwood
  Future<void> deleteDriftwood(int id) async {
    await _repo.deleteDriftwood(id);
    ref.invalidateSelf();
  }

  /// Update driftwood quantity
  Future<void> updateQuantity(
    DriftwoodEntity driftwood,
    int newQuantity,
  ) async {
    final updated = driftwood.copyWith(quantity: newQuantity);
    await _repo.updateDriftwood(updated);
    ref.invalidateSelf();
  }

  /// Mark driftwood as cured
  Future<void> markAsCured(DriftwoodEntity driftwood) async {
    final updated = driftwood.copyWith(isCured: true);
    await _repo.updateDriftwood(updated);
    ref.invalidateSelf();
  }

  /// Toggle tannin release status
  Future<void> toggleTanninRelease(DriftwoodEntity driftwood) async {
    final updated = driftwood.copyWith(
      isReleasingTannins: !driftwood.isReleasingTannins,
    );
    await _repo.updateDriftwood(updated);
    ref.invalidateSelf();
  }

  /// Start curing process
  Future<void> startCuring(DriftwoodEntity driftwood) async {
    final updated = driftwood.copyWith(
      isCured: false,
      curingStartDate: DateTime.now(),
    );
    await _repo.updateDriftwood(updated);
    ref.invalidateSelf();
  }
}
