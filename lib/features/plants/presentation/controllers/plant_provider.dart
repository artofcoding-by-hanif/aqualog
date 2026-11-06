import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/plant_repository_impl.dart';
import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';

part 'plant_provider.g.dart';

/// Provider for PlantRepository
@Riverpod(keepAlive: true)
PlantRepository plantRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PlantRepositoryImpl(database: db);
}

/// Provider to watch all plants for a tank
@Riverpod(keepAlive: true)
Stream<List<PlantEntity>> plantsForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.watchPlantsForTank(tankId);
}

/// Provider to get a plant by ID
@Riverpod(keepAlive: true)
Future<PlantEntity?> plantById(Ref ref, int id) async {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.getPlantById(id);
}

/// Provider to get active plant count for a tank
@Riverpod(keepAlive: true)
Future<int> activePlantCount(Ref ref, int tankId) async {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.getActivePlantCount(tankId);
}

/// Notifier for managing plant operations for a specific tank
@Riverpod(keepAlive: true)
class PlantNotifier extends _$PlantNotifier {
  @override
  Future<List<PlantEntity>> build(int tankId) async {
    final repo = ref.watch(plantRepositoryProvider);
    return repo.getPlantsForTank(tankId);
  }

  PlantRepository get _repo => ref.read(plantRepositoryProvider);

  /// Add a new plant
  Future<int> addPlant(PlantEntity plant) async {
    final id = await _repo.addPlant(plant);
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing plant
  Future<void> updatePlant(PlantEntity plant) async {
    await _repo.updatePlant(plant);
    ref.invalidateSelf();
  }

  /// Delete a plant
  Future<void> deletePlant(int id) async {
    await _repo.deletePlant(id);
    ref.invalidateSelf();
  }

  /// Record removal of a plant (mark as removed, don't delete)
  Future<void> recordRemoval(PlantEntity plant) async {
    final updated = plant.copyWith(dateRemoved: DateTime.now());
    await _repo.updatePlant(updated);
    ref.invalidateSelf();
  }

  /// Update plant quantity
  Future<void> updateQuantity(PlantEntity plant, int newQuantity) async {
    final updated = plant.copyWith(quantity: newQuantity);
    await _repo.updatePlant(updated);
    ref.invalidateSelf();
  }

  /// Record propagation - create a new plant from parent
  Future<int> propagatePlant(PlantEntity parent, {int quantity = 1}) async {
    final propagated = PlantEntity(
      tankId: parent.tankId,
      species: parent.species,
      commonName: parent.commonName,
      plantType: parent.plantType,
      quantity: quantity,
      placementZone: parent.placementZone,
      lightingRequirement: parent.lightingRequirement,
      co2Requirement: parent.co2Requirement,
      growthRate: parent.growthRate,
      difficultyLevel: parent.difficultyLevel,
      maxHeightCm: parent.maxHeightCm,
      minTempCelsius: parent.minTempCelsius,
      maxTempCelsius: parent.maxTempCelsius,
      minPh: parent.minPh,
      maxPh: parent.maxPh,
      dateAdded: DateTime.now(),
      isPropagated: true,
      parentPlantId: parent.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final id = await _repo.addPlant(propagated);
    ref.invalidateSelf();
    return id;
  }

  /// Update current height
  Future<void> updateHeight(PlantEntity plant, double newHeight) async {
    final updated = plant.copyWith(
      currentHeightCm: newHeight,
      updatedAt: DateTime.now(),
    );
    await _repo.updatePlant(updated);
    ref.invalidateSelf();
  }
}
