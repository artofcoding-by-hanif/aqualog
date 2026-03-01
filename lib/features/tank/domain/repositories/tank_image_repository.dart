import '../entities/tank_image.dart';

/// Repository interface for tank images
abstract class TankImageRepository {
  /// Get all images for a tank
  Future<List<TankImageEntity>> getImagesForTank(int tankId);

  /// Watch all images for a tank
  Stream<List<TankImageEntity>> watchImagesForTank(int tankId);

  /// Get a single image by ID
  Future<TankImageEntity?> getImageById(int id);

  /// Get the cover image for a tank
  Future<TankImageEntity?> getCoverImage(int tankId);

  /// Add a new image
  Future<int> addImage(TankImageEntity image);

  /// Update an image
  Future<void> updateImage(TankImageEntity image);

  /// Delete an image
  Future<void> deleteImage(int id);

  /// Delete all images for a tank
  Future<void> deleteImagesForTank(int tankId);

  /// Set an image as the cover image
  Future<void> setCoverImage(int tankId, int imageId);

  /// Get image count for a tank
  Future<int> getImageCount(int tankId);
}

