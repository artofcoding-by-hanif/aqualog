import '../entities/rock.dart';

/// Rock repository interface
abstract class RockRepository {
  /// Get all rocks for a tank
  Future<List<RockEntity>> getRocksForTank(int tankId);

  /// Get a rock by ID
  Future<RockEntity?> getRockById(int id);

  /// Add a new rock
  Future<int> addRock(RockEntity rock);

  /// Update an existing rock
  Future<void> updateRock(RockEntity rock);

  /// Delete a rock
  Future<void> deleteRock(int id);

  /// Delete all rocks for a tank
  Future<void> deleteRocksForTank(int tankId);

  /// Watch all rocks for a tank (reactive stream)
  Stream<List<RockEntity>> watchRocksForTank(int tankId);
}

