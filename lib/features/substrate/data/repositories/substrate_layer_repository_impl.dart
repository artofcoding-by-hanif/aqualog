import '../../../../core/database/app_database.dart';
import '../../domain/entities/substrate_layer.dart';
import '../../domain/repositories/substrate_layer_repository.dart';
import '../models/substrate_layer_model.dart';

/// Substrate layer repository implementation using Drift database
class SubstrateLayerRepositoryImpl implements SubstrateLayerRepository {
  final AppDatabase _db;

  SubstrateLayerRepositoryImpl({required AppDatabase database})
    : _db = database;

  @override
  Future<List<SubstrateLayerEntity>> getSubstrateLayersForTank(
    int tankId,
  ) async {
    final layers = await _db.getSubstrateLayersForTank(tankId);
    return layers.map((l) => l.toEntity()).toList();
  }

  @override
  Future<SubstrateLayerEntity?> getSubstrateLayerById(int id) async {
    final layer = await _db.getSubstrateLayerById(id);
    return layer?.toEntity();
  }

  @override
  Future<int> addSubstrateLayer(SubstrateLayerEntity layer) async {
    return await _db.insertSubstrateLayer(layer.toCompanion());
  }

  @override
  Future<void> updateSubstrateLayer(SubstrateLayerEntity layer) async {
    await _db.updateSubstrateLayer(layer.toDriftSubstrateLayer());
  }

  @override
  Future<void> deleteSubstrateLayer(int id) async {
    await _db.deleteSubstrateLayer(id);
  }

  @override
  Future<void> deleteSubstrateLayersForTank(int tankId) async {
    await _db.deleteSubstrateLayersForTank(tankId);
  }

  @override
  Stream<List<SubstrateLayerEntity>> watchSubstrateLayersForTank(int tankId) {
    return _db
        .watchSubstrateLayersForTank(tankId)
        .map((layers) => layers.map((l) => l.toEntity()).toList());
  }

  @override
  Future<void> reorderSubstrateLayers(int tankId, List<int> layerIds) async {
    await _db.reorderSubstrateLayers(tankId, layerIds);
  }
}
