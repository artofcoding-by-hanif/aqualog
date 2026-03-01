import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/tank_image_repository_impl.dart';
import '../../domain/entities/tank_image.dart';
import '../../domain/repositories/tank_image_repository.dart';

part 'tank_image_provider.g.dart';

/// Provider for TankImageRepository
@Riverpod(keepAlive: true)
TankImageRepository tankImageRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return TankImageRepositoryImpl(db);
}

/// Provider to watch all images for a tank
@Riverpod(keepAlive: true)
Stream<List<TankImageEntity>> tankImagesStream(Ref ref, int tankId) {
  final repo = ref.watch(tankImageRepositoryProvider);
  return repo.watchImagesForTank(tankId);
}

/// Provider to get the cover image for a tank
@riverpod
Future<TankImageEntity?> tankCoverImage(Ref ref, int tankId) async {
  final repo = ref.watch(tankImageRepositoryProvider);
  return repo.getCoverImage(tankId);
}

/// Provider to get image count for a tank
@riverpod
Future<int> tankImageCount(Ref ref, int tankId) async {
  final repo = ref.watch(tankImageRepositoryProvider);
  return repo.getImageCount(tankId);
}

/// Notifier for managing tank image operations
@riverpod
class TankImageNotifier extends _$TankImageNotifier {
  @override
  Future<List<TankImageEntity>> build(int tankId) async {
    final repo = ref.watch(tankImageRepositoryProvider);
    return repo.getImagesForTank(tankId);
  }

  TankImageRepository get _repo => ref.read(tankImageRepositoryProvider);

  /// Pick image from camera or gallery and save it
  Future<TankImageEntity?> pickAndSaveImage({
    required ImageSource source,
    String? caption,
  }) async {
    // Cache the repository reference before any async operations
    final repo = _repo;
    final currentTankId = tankId;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (pickedFile == null) {
      return null;
    }

    // Save to app documents directory
    final appDir = await getApplicationDocumentsDirectory();
    final tankImagesDir = Directory(
      '${appDir.path}/tank_images/$currentTankId',
    );
    if (!await tankImagesDir.exists()) {
      await tankImagesDir.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedPath = '${tankImagesDir.path}/$fileName';

    // Copy the picked file to app storage
    final File pickedFileObject = File(pickedFile.path);
    await pickedFileObject.copy(savedPath);

    // Create entity and save to database
    final entity = TankImageEntity(
      tankId: currentTankId,
      imagePath: savedPath,
      caption: caption,
      takenAt: DateTime.now(),
    );

    final id = await repo.addImage(entity);

    // Only invalidate if still mounted
    if (ref.mounted) {
      ref.invalidateSelf();
      ref.invalidate(tankImagesStreamProvider(currentTankId));
      ref.invalidate(tankImageCountProvider(currentTankId));
    }

    return entity.copyWith(id: id);
  }

  /// Add an image from an existing file path
  Future<int> addImage(TankImageEntity image) async {
    final repo = _repo;
    final currentTankId = tankId;

    final id = await repo.addImage(image);

    if (ref.mounted) {
      ref.invalidateSelf();
      ref.invalidate(tankImagesStreamProvider(currentTankId));
      ref.invalidate(tankImageCountProvider(currentTankId));
    }
    return id;
  }

  /// Update an image's caption
  Future<void> updateCaption(int imageId, String? caption) async {
    final repo = _repo;

    final image = await repo.getImageById(imageId);
    if (image != null) {
      await repo.updateImage(image.copyWith(caption: caption));
      if (ref.mounted) {
        ref.invalidateSelf();
      }
    }
  }

  /// Delete an image and its file
  Future<void> deleteImage(int imageId) async {
    final repo = _repo;
    final currentTankId = tankId;

    final image = await repo.getImageById(imageId);
    if (image != null) {
      // Delete the file
      final file = File(image.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      // Delete from database
      await repo.deleteImage(imageId);

      if (ref.mounted) {
        ref.invalidateSelf();
        ref.invalidate(tankImagesStreamProvider(currentTankId));
        ref.invalidate(tankImageCountProvider(currentTankId));
      }
    }
  }

  /// Set an image as the cover image
  Future<void> setCoverImage(int imageId) async {
    final repo = _repo;
    final currentTankId = tankId;

    await repo.setCoverImage(currentTankId, imageId);

    if (ref.mounted) {
      ref.invalidateSelf();
      ref.invalidate(tankImagesStreamProvider(currentTankId));
      ref.invalidate(tankCoverImageProvider(currentTankId));
    }
  }
}
