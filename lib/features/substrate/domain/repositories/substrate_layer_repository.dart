import '../entities/substrate_layer.dart';

/// Substrate layer repository interface
abstract class SubstrateLayerRepository {
  /// Get all substrate layers for a tank (ordered by layer order)
  Future<List<SubstrateLayerEntity>> getSubstrateLayersForTank(int tankId);

  /// Get a substrate layer by ID
  Future<SubstrateLayerEntity?> getSubstrateLayerById(int id);

  /// Add a new substrate layer
  Future<int> addSubstrateLayer(SubstrateLayerEntity layer);

  /// Update an existing substrate layer
  Future<void> updateSubstrateLayer(SubstrateLayerEntity layer);

  /// Delete a substrate layer
  Future<void> deleteSubstrateLayer(int id);

  /// Delete all substrate layers for a tank
  Future<void> deleteSubstrateLayersForTank(int tankId);

  /// Watch all substrate layers for a tank (reactive stream)
  Stream<List<SubstrateLayerEntity>> watchSubstrateLayersForTank(int tankId);

  /// Reorder substrate layers for a tank
  /// [layerIds] is an ordered list of layer IDs (index 0 = bottom layer)
  Future<void> reorderSubstrateLayers(int tankId, List<int> layerIds);
}

