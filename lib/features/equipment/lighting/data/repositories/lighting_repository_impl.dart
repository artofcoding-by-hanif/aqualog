import '../../../../../core/database/app_database.dart';
import '../../domain/entities/lighting.dart';
import '../../domain/repositories/lighting_repository.dart';
import '../models/lighting_model.dart';

/// Lighting repository implementation using Drift database
class LightingRepositoryImpl implements LightingRepository {
  final AppDatabase _db;

  LightingRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<LightingEntity>> getLightingsForTank(int tankId) async {
    final lightings = await _db.getLightingsForTank(tankId);
    return lightings.map((l) => l.toEntity()).toList();
  }

  @override
  Future<LightingEntity?> getLightingById(int id) async {
    final lighting = await _db.getLightingById(id);
    return lighting?.toEntity();
  }

  @override
  Future<int> addLighting(LightingEntity lighting) async {
    return await _db.insertLighting(lighting.toCompanion());
  }

  @override
  Future<void> updateLighting(LightingEntity lighting) async {
    await _db.updateLighting(lighting.toDriftLighting());
  }

  @override
  Future<void> deleteLighting(int id) async {
    await _db.deleteLighting(id);
  }

  @override
  Future<void> deleteLightingsForTank(int tankId) async {
    await _db.deleteLightingsForTank(tankId);
  }

  @override
  Stream<List<LightingEntity>> watchLightingsForTank(int tankId) {
    return _db.watchLightingsForTank(tankId).map(
      (lightings) => lightings.map((l) => l.toEntity()).toList(),
    );
  }
}

