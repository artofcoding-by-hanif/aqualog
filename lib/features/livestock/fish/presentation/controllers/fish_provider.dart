import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/database/database_provider.dart';
import '../../data/repositories/fish_repository_impl.dart';
import '../../domain/entities/fish.dart';
import '../../domain/repositories/fish_repository.dart';

part 'fish_provider.g.dart';

/// Provider for FishRepository
@Riverpod(keepAlive: true)
FishRepository fishRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return FishRepositoryImpl(database: db);
}

/// Provider to watch all fish for a tank
@Riverpod(keepAlive: true)
Stream<List<FishEntity>> fishForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(fishRepositoryProvider);
  return repo.watchFishForTank(tankId);
}

/// Provider to get a fish by ID
@Riverpod(keepAlive: true)
Future<FishEntity?> fishById(Ref ref, int id) async {
  final repo = ref.watch(fishRepositoryProvider);
  return repo.getFishById(id);
}

/// Provider to get alive fish count for a tank
@Riverpod(keepAlive: true)
Future<int> aliveFishCount(Ref ref, int tankId) async {
  final repo = ref.watch(fishRepositoryProvider);
  return repo.getAliveFishCount(tankId);
}

/// Notifier for managing fish operations for a specific tank
@Riverpod(keepAlive: true)
class FishNotifier extends _$FishNotifier {
  @override
  Future<List<FishEntity>> build(int tankId) async {
    final repo = ref.watch(fishRepositoryProvider);
    return repo.getFishForTank(tankId);
  }

  FishRepository get _repo => ref.read(fishRepositoryProvider);

  /// Add a new fish
  Future<int> addFish(FishEntity fish) async {
    final id = await _repo.addFish(fish);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing fish
  Future<void> updateFish(FishEntity fish) async {
    await _repo.updateFish(fish);
    ref.invalidateSelf();
  }

  /// Delete a fish
  Future<void> deleteFish(int id) async {
    await _repo.deleteFish(id);
    ref.invalidateSelf();
  }

  /// Record death of a fish
  Future<void> recordDeath(FishEntity fish, {int? quantity}) async {
    final now = DateTime.now();
    if (quantity != null && quantity < fish.quantity) {
      // Partial death - reduce quantity and optionally create deceased record
      final updated = fish.copyWith(quantity: fish.quantity - quantity);
      await _repo.updateFish(updated);
    } else {
      // Full death - mark all as deceased
      final updated = fish.copyWith(dateDeceased: now);
      await _repo.updateFish(updated);
    }
    ref.invalidateSelf();
  }

  /// Update fish quantity
  Future<void> updateQuantity(FishEntity fish, int newQuantity) async {
    final updated = fish.copyWith(quantity: newQuantity);
    await _repo.updateFish(updated);
    ref.invalidateSelf();
  }

  /// End quarantine for a fish
  Future<void> endQuarantine(FishEntity fish) async {
    final updated = fish.copyWith(
      isQuarantined: false,
      quarantineEndDate: DateTime.now(),
    );
    await _repo.updateFish(updated);
    ref.invalidateSelf();
  }

  /// Start quarantine for a fish
  Future<void> startQuarantine(FishEntity fish, DateTime endDate) async {
    final updated = fish.copyWith(
      isQuarantined: true,
      quarantineEndDate: endDate,
    );
    await _repo.updateFish(updated);
    ref.invalidateSelf();
  }
}
