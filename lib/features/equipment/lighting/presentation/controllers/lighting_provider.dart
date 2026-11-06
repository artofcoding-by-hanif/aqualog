import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/database/database_provider.dart';
import '../../data/repositories/lighting_repository_impl.dart';
import '../../domain/entities/lighting.dart';
import '../../domain/repositories/lighting_repository.dart';

part 'lighting_provider.g.dart';

/// Provider for LightingRepository
@Riverpod(keepAlive: true)
LightingRepository lightingRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return LightingRepositoryImpl(database: db);
}

/// Provider to watch all lightings for a tank
@Riverpod(keepAlive: true)
Stream<List<LightingEntity>> lightingsForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(lightingRepositoryProvider);
  return repo.watchLightingsForTank(tankId);
}

/// Provider to get a lighting by ID
@Riverpod(keepAlive: true)
Future<LightingEntity?> lightingById(Ref ref, int id) async {
  final repo = ref.watch(lightingRepositoryProvider);
  return repo.getLightingById(id);
}

/// Notifier for managing lighting operations for a specific tank
@Riverpod(keepAlive: true)
class LightingNotifier extends _$LightingNotifier {
  @override
  Future<List<LightingEntity>> build(int tankId) async {
    final repo = ref.watch(lightingRepositoryProvider);
    return repo.getLightingsForTank(tankId);
  }

  LightingRepository get _repo => ref.read(lightingRepositoryProvider);

  /// Add a new lighting
  Future<int> addLighting(LightingEntity lighting) async {
    final id = await _repo.addLighting(lighting);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing lighting
  Future<void> updateLighting(LightingEntity lighting) async {
    await _repo.updateLighting(lighting);
    ref.invalidateSelf();
  }

  /// Delete a lighting
  Future<void> deleteLighting(int id) async {
    await _repo.deleteLighting(id);
    ref.invalidateSelf();
  }

  /// Record bulb/LED replacement
  Future<void> recordReplacement(LightingEntity lighting) async {
    final now = DateTime.now();
    final updated = lighting.copyWith(lastReplacedAt: now);
    await _repo.updateLighting(updated);
    ref.invalidateSelf();
  }
}
