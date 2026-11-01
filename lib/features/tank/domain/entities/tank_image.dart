import 'package:freezed_annotation/freezed_annotation.dart';

part 'tank_image.freezed.dart';
part 'tank_image.g.dart';

/// Tank image entity - represents a photo in the tank gallery
@freezed
abstract class TankImageEntity with _$TankImageEntity {
  const TankImageEntity._();

  const factory TankImageEntity({
    /// Unique identifier (null for new images)
    int? id,

    /// Foreign key to tank
    required int tankId,

    /// Image file path (local storage)
    required String imagePath,

    /// Optional caption/description
    String? caption,

    /// Whether this is the cover/primary image for the tank
    @Default(false) bool isCover,

    /// Date the photo was taken (if available)
    DateTime? takenAt,

    /// Created timestamp
    DateTime? createdAt,
  }) = _TankImageEntity;

  factory TankImageEntity.fromJson(Map<String, dynamic> json) =>
      _$TankImageEntityFromJson(json);
}
