import '../../../../core/database/app_database.dart';
import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';
import '../models/plant_model.dart';

/// Plant repository implementation using Drift database
class PlantRepositoryImpl implements PlantRepository {
  final AppDatabase _db;

  PlantRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<PlantEntity>> getPlantsForTank(int tankId) async {
    final plantList = await _db.getPlantsForTank(tankId);
    return plantList.map((p) => p.toEntity()).toList();
  }

  @override
  Future<PlantEntity?> getPlantById(int id) async {
    final plant = await _db.getPlantById(id);
    return plant?.toEntity();
  }

  @override
  Future<int> addPlant(PlantEntity plant) async {
    return await _db.insertPlant(plant.toCompanion());
  }

  @override
  Future<void> updatePlant(PlantEntity plant) async {
    await _db.updatePlant(plant.toDriftPlant());
  }

  @override
  Future<void> deletePlant(int id) async {
    await _db.deletePlant(id);
  }

  @override
  Future<void> deletePlantsForTank(int tankId) async {
    await _db.deletePlantsForTank(tankId);
  }

  @override
  Stream<List<PlantEntity>> watchPlantsForTank(int tankId) {
    return _db.watchPlantsForTank(tankId).map(
      (plantList) => plantList.map((p) => p.toEntity()).toList(),
    );
  }

  @override
  Future<int> getActivePlantCount(int tankId) async {
    return await _db.getActivePlantCount(tankId);
  }
}

