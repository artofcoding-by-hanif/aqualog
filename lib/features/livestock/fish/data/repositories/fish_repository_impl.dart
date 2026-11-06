import '../../../../../core/database/app_database.dart';
import '../../domain/entities/fish.dart';
import '../../domain/repositories/fish_repository.dart';
import '../models/fish_model.dart';

/// Fish repository implementation using Drift database
class FishRepositoryImpl implements FishRepository {
  final AppDatabase _db;

  FishRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<FishEntity>> getFishForTank(int tankId) async {
    final fishList = await _db.getFishForTank(tankId);
    return fishList.map((f) => f.toEntity()).toList();
  }

  @override
  Future<FishEntity?> getFishById(int id) async {
    final fish = await _db.getFishById(id);
    return fish?.toEntity();
  }

  @override
  Future<int> addFish(FishEntity fish) async {
    return await _db.insertFish(fish.toCompanion());
  }

  @override
  Future<void> updateFish(FishEntity fish) async {
    await _db.updateFish(fish.toDriftFish());
  }

  @override
  Future<void> deleteFish(int id) async {
    await _db.deleteFish(id);
  }

  @override
  Future<void> deleteFishForTank(int tankId) async {
    await _db.deleteFishForTank(tankId);
  }

  @override
  Stream<List<FishEntity>> watchFishForTank(int tankId) {
    return _db
        .watchFishForTank(tankId)
        .map((fishList) => fishList.map((f) => f.toEntity()).toList());
  }

  @override
  Future<int> getAliveFishCount(int tankId) async {
    return await _db.getAliveFishCount(tankId);
  }
}
