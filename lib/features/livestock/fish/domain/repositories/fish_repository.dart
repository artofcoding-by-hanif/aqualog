import '../entities/fish.dart';

/// Fish repository interface
abstract class FishRepository {
  /// Get all fish for a tank
  Future<List<FishEntity>> getFishForTank(int tankId);

  /// Get a fish by ID
  Future<FishEntity?> getFishById(int id);

  /// Add a new fish
  Future<int> addFish(FishEntity fish);

  /// Update an existing fish
  Future<void> updateFish(FishEntity fish);

  /// Delete a fish
  Future<void> deleteFish(int id);

  /// Delete all fish for a tank
  Future<void> deleteFishForTank(int tankId);

  /// Watch all fish for a tank (reactive stream)
  Stream<List<FishEntity>> watchFishForTank(int tankId);

  /// Get count of alive fish for a tank
  Future<int> getAliveFishCount(int tankId);
}

