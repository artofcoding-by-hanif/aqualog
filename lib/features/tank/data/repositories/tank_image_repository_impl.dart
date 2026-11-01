import '../../../../core/database/app_database.dart';
import '../../domain/entities/tank_image.dart';
import '../../domain/repositories/tank_image_repository.dart';
import '../models/tank_image_model.dart';

/// Implementation of TankImageRepository using Drift database
class TankImageRepositoryImpl implements TankImageRepository {
  final AppDatabase _database;

  TankImageRepositoryImpl(this._database);

  @override
  Future<List<TankImageEntity>> getImagesForTank(int tankId) async {
    final images = await _database.getImagesForTank(tankId);
    return images.map((i) => i.toEntity()).toList();
  }

  @override
  Stream<List<TankImageEntity>> watchImagesForTank(int tankId) {
    return _database
        .watchImagesForTank(tankId)
        .map((images) => images.map((i) => i.toEntity()).toList());
  }

  @override
  Future<TankImageEntity?> getImageById(int id) async {
    final image = await _database.getTankImageById(id);
    return image?.toEntity();
  }

  @override
  Future<TankImageEntity?> getCoverImage(int tankId) async {
    final image = await _database.getCoverImageForTank(tankId);
    return image?.toEntity();
  }

  @override
  Future<int> addImage(TankImageEntity image) async {
    return await _database.insertTankImage(image.toCompanion());
  }

  @override
  Future<void> updateImage(TankImageEntity image) async {
    await _database.updateTankImage(image.toDriftTankImage());
  }

  @override
  Future<void> deleteImage(int id) async {
    await _database.deleteTankImage(id);
  }

  @override
  Future<void> deleteImagesForTank(int tankId) async {
    await _database.deleteImagesForTank(tankId);
  }

  @override
  Future<void> setCoverImage(int tankId, int imageId) async {
    await _database.setCoverImage(tankId, imageId);
  }

  @override
  Future<int> getImageCount(int tankId) async {
    return await _database.getImageCountForTank(tankId);
  }
}
