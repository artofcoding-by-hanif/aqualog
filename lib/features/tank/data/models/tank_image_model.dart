import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/tank_image.dart';

/// Extension to map between Drift TankImage and TankImageEntity
extension TankImageMapper on TankImage {
  /// Convert Drift TankImage to domain TankImageEntity
  TankImageEntity toEntity() {
    return TankImageEntity(
      id: id,
      tankId: tankId,
      imagePath: imagePath,
      caption: caption,
      isCover: isCover,
      takenAt: takenAt,
      createdAt: createdAt,
    );
  }
}

/// Extension to convert TankImageEntity to Drift companion for insert/update
extension TankImageEntityMapper on TankImageEntity {
  /// Convert domain TankImageEntity to Drift TankImagesCompanion for insert
  TankImagesCompanion toCompanion() {
    return TankImagesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      imagePath: Value(imagePath),
      caption: Value(caption),
      isCover: Value(isCover),
      takenAt: Value(takenAt),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
    );
  }

  /// Convert domain TankImageEntity to Drift TankImage for update
  TankImage toDriftTankImage() {
    return TankImage(
      id: id!,
      tankId: tankId,
      imagePath: imagePath,
      caption: caption,
      isCover: isCover,
      takenAt: takenAt,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}

