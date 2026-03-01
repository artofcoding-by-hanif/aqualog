import '../entities/plant.dart';

/// Plant repository interface
abstract class PlantRepository {
  /// Get all plants for a tank
  Future<List<PlantEntity>> getPlantsForTank(int tankId);

  /// Get a plant by ID
  Future<PlantEntity?> getPlantById(int id);

  /// Add a new plant
  Future<int> addPlant(PlantEntity plant);

  /// Update an existing plant
  Future<void> updatePlant(PlantEntity plant);

  /// Delete a plant
  Future<void> deletePlant(int id);

  /// Delete all plants for a tank
  Future<void> deletePlantsForTank(int tankId);

  /// Watch all plants for a tank (reactive stream)
  Stream<List<PlantEntity>> watchPlantsForTank(int tankId);

  /// Get count of active plants for a tank
  Future<int> getActivePlantCount(int tankId);
}

