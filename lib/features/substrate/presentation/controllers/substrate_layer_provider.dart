import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/substrate_layer_repository_impl.dart';
import '../../domain/entities/substrate_layer.dart';
import '../../domain/repositories/substrate_layer_repository.dart';

part 'substrate_layer_provider.g.dart';

/// Provider for SubstrateLayerRepository
@Riverpod(keepAlive: true)
SubstrateLayerRepository substrateLayerRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SubstrateLayerRepositoryImpl(database: db);
}

/// Provider to watch all substrate layers for a tank
@Riverpod(keepAlive: true)
Stream<List<SubstrateLayerEntity>> substrateLayersForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(substrateLayerRepositoryProvider);
  return repo.watchSubstrateLayersForTank(tankId);
}

/// Provider to get a substrate layer by ID
@Riverpod(keepAlive: true)
Future<SubstrateLayerEntity?> substrateLayerById(Ref ref, int id) async {
  final repo = ref.watch(substrateLayerRepositoryProvider);
  return repo.getSubstrateLayerById(id);
}

/// Notifier for substrate layer operations
@Riverpod(keepAlive: true)
class SubstrateLayerNotifier extends _$SubstrateLayerNotifier {
  @override
  void build() {
    // No state to initialize
  }

  SubstrateLayerRepository get _repo => ref.read(substrateLayerRepositoryProvider);

  /// Add a new substrate layer
  Future<int> addLayer(SubstrateLayerEntity layer) async {
    return await _repo.addSubstrateLayer(layer);
  }

  /// Update an existing substrate layer
  Future<void> updateLayer(SubstrateLayerEntity layer) async {
    await _repo.updateSubstrateLayer(layer);
  }

  /// Delete a substrate layer
  Future<void> deleteLayer(int id) async {
    await _repo.deleteSubstrateLayer(id);
  }

  /// Reorder substrate layers for a tank
  Future<void> reorderLayers(int tankId, List<int> layerIds) async {
    await _repo.reorderSubstrateLayers(tankId, layerIds);
  }
}

