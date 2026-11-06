import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/database/database_provider.dart';
import '../../data/repositories/invertebrate_repository_impl.dart';
import '../../domain/entities/invertebrate.dart';
import '../../domain/repositories/invertebrate_repository.dart';

part 'invertebrate_provider.g.dart';

/// Provider for InvertebrateRepository
@Riverpod(keepAlive: true)
InvertebrateRepository invertebrateRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return InvertebrateRepositoryImpl(database: db);
}

/// Provider to watch all invertebrates for a tank
@Riverpod(keepAlive: true)
Stream<List<InvertebrateEntity>> invertebratesForTankStream(
  Ref ref,
  int tankId,
) {
  final repo = ref.watch(invertebrateRepositoryProvider);
  return repo.watchInvertebratesForTank(tankId);
}

/// Provider to get an invertebrate by ID
@Riverpod(keepAlive: true)
Future<InvertebrateEntity?> invertebrateById(Ref ref, int id) async {
  final repo = ref.watch(invertebrateRepositoryProvider);
  return repo.getInvertebrateById(id);
}

/// Provider to get alive invertebrate count for a tank
@Riverpod(keepAlive: true)
Future<int> aliveInvertebrateCount(Ref ref, int tankId) async {
  final repo = ref.watch(invertebrateRepositoryProvider);
  return repo.getAliveInvertebrateCount(tankId);
}

/// Notifier for managing invertebrate operations for a specific tank
@Riverpod(keepAlive: true)
class InvertebrateNotifier extends _$InvertebrateNotifier {
  @override
  Future<List<InvertebrateEntity>> build(int tankId) async {
    final repo = ref.watch(invertebrateRepositoryProvider);
    return repo.getInvertebratesForTank(tankId);
  }

  InvertebrateRepository get _repo => ref.read(invertebrateRepositoryProvider);

  /// Add a new invertebrate
  Future<int> addInvertebrate(InvertebrateEntity invertebrate) async {
    final id = await _repo.addInvertebrate(invertebrate);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing invertebrate
  Future<void> updateInvertebrate(InvertebrateEntity invertebrate) async {
    await _repo.updateInvertebrate(invertebrate);
    ref.invalidateSelf();
  }

  /// Delete an invertebrate
  Future<void> deleteInvertebrate(int id) async {
    await _repo.deleteInvertebrate(id);
    ref.invalidateSelf();
  }

  /// Record death of an invertebrate
  Future<void> recordDeath(
    InvertebrateEntity invertebrate, {
    int? quantity,
  }) async {
    final now = DateTime.now();
    if (quantity != null && quantity < invertebrate.quantity) {
      // Partial death - reduce quantity
      final updated = invertebrate.copyWith(
        quantity: invertebrate.quantity - quantity,
      );
      await _repo.updateInvertebrate(updated);
    } else {
      // Full death - mark all as deceased
      final updated = invertebrate.copyWith(dateDeceased: now);
      await _repo.updateInvertebrate(updated);
    }
    ref.invalidateSelf();
  }

  /// Update invertebrate quantity
  Future<void> updateQuantity(
    InvertebrateEntity invertebrate,
    int newQuantity,
  ) async {
    final updated = invertebrate.copyWith(quantity: newQuantity);
    await _repo.updateInvertebrate(updated);
    ref.invalidateSelf();
  }

  /// End quarantine for an invertebrate
  Future<void> endQuarantine(InvertebrateEntity invertebrate) async {
    final updated = invertebrate.copyWith(
      isQuarantined: false,
      quarantineEndDate: DateTime.now(),
    );
    await _repo.updateInvertebrate(updated);
    ref.invalidateSelf();
  }

  /// Start quarantine for an invertebrate
  Future<void> startQuarantine(
    InvertebrateEntity invertebrate,
    DateTime endDate,
  ) async {
    final updated = invertebrate.copyWith(
      isQuarantined: true,
      quarantineEndDate: endDate,
    );
    await _repo.updateInvertebrate(updated);
    ref.invalidateSelf();
  }

  /// Toggle breeding colony status
  Future<void> toggleBreedingColony(InvertebrateEntity invertebrate) async {
    final updated = invertebrate.copyWith(
      isBreedingColony: !invertebrate.isBreedingColony,
    );
    await _repo.updateInvertebrate(updated);
    ref.invalidateSelf();
  }
}
