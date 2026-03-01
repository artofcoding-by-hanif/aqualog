import '../entities/lighting.dart';

/// Lighting repository interface
abstract class LightingRepository {
  /// Get all lightings for a tank
  Future<List<LightingEntity>> getLightingsForTank(int tankId);

  /// Get a lighting by ID
  Future<LightingEntity?> getLightingById(int id);

  /// Add a new lighting
  Future<int> addLighting(LightingEntity lighting);

  /// Update an existing lighting
  Future<void> updateLighting(LightingEntity lighting);

  /// Delete a lighting
  Future<void> deleteLighting(int id);

  /// Delete all lightings for a tank
  Future<void> deleteLightingsForTank(int tankId);

  /// Watch all lightings for a tank (reactive stream)
  Stream<List<LightingEntity>> watchLightingsForTank(int tankId);
}

