import '../entities/driftwood.dart';

/// Driftwood repository interface
abstract class DriftwoodRepository {
  /// Get all driftwoods for a tank
  Future<List<DriftwoodEntity>> getDriftwoodsForTank(int tankId);

  /// Get a driftwood by ID
  Future<DriftwoodEntity?> getDriftwoodById(int id);

  /// Add a new driftwood
  Future<int> addDriftwood(DriftwoodEntity driftwood);

  /// Update an existing driftwood
  Future<void> updateDriftwood(DriftwoodEntity driftwood);

  /// Delete a driftwood
  Future<void> deleteDriftwood(int id);

  /// Delete all driftwoods for a tank
  Future<void> deleteDriftwoodsForTank(int tankId);

  /// Watch all driftwoods for a tank (reactive stream)
  Stream<List<DriftwoodEntity>> watchDriftwoodsForTank(int tankId);
}
