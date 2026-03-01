import 'package:freezed_annotation/freezed_annotation.dart';

part 'glass_calculation.freezed.dart';

/// Glass calculation entity for tank glass dimensions
@freezed
abstract class GlassCalculationEntity with _$GlassCalculationEntity {
  const GlassCalculationEntity._();

  const factory GlassCalculationEntity({
    /// Unique identifier (null for new calculations)
    int? id,

    /// Name/label for this calculation
    required String name,

    /// Tank length in mm
    required double lengthMm,

    /// Tank width in mm
    required double widthMm,

    /// Tank height in mm
    required double heightMm,

    /// Glass thickness in mm
    required double glassThicknessMm,

    /// Glue/silicone thickness in mm (default 1mm)
    @Default(1.0) double glueThicknessMm,

    /// Calculated volume in liters
    required double volumeLiters,

    /// Bottom glass length in mm
    required double bottomLengthMm,

    /// Bottom glass width in mm
    required double bottomWidthMm,

    /// Front/back glass length in mm
    required double frontBackLengthMm,

    /// Front/back glass height in mm
    required double frontBackHeightMm,

    /// Side glass width in mm
    required double sideWidthMm,

    /// Side glass height in mm
    required double sideHeightMm,

    /// Total glass area in square meters
    required double totalGlassAreaSqM,

    /// Estimated glass weight in kg
    required double estimatedWeightKg,

    /// Notes
    String? notes,

    /// Created timestamp
    DateTime? createdAt,
  }) = _GlassCalculationEntity;

  /// Calculate glass dimensions from tank dimensions
  /// Uses the "bottom inside" method where bottom glass sits inside the walls
  static GlassCalculationEntity calculate({
    required String name,
    required double lengthMm,
    required double widthMm,
    required double heightMm,
    required double glassThicknessMm,
    double glueThicknessMm = 1.0,
    String? notes,
  }) {
    // Bottom glass: sits inside the walls
    // Length = tank length - 2 * glass thickness - 2 * glue thickness
    // Width = tank width - 2 * glass thickness - 2 * glue thickness
    final bottomLength =
        lengthMm - (2 * glassThicknessMm) - (2 * glueThicknessMm);
    final bottomWidth =
        widthMm - (2 * glassThicknessMm) - (2 * glueThicknessMm);

    // Front and back glass: full length, full height
    final frontBackLength = lengthMm;
    final frontBackHeight = heightMm;

    // Side glass: width minus 2 glass thickness (sits between front/back), full height
    final sideWidth = widthMm - (2 * glassThicknessMm) - (2 * glueThicknessMm);
    final sideHeight = heightMm;

    // Calculate internal volume in liters
    // Internal dimensions
    final internalLength = lengthMm - (2 * glassThicknessMm);
    final internalWidth = widthMm - (2 * glassThicknessMm);
    final internalHeight = heightMm - glassThicknessMm; // bottom glass
    final volumeLiters =
        (internalLength * internalWidth * internalHeight) / 1000000;

    // Calculate total glass area in square meters
    final bottomArea = bottomLength * bottomWidth;
    final frontBackArea = frontBackLength * frontBackHeight * 2; // 2 panels
    final sideArea = sideWidth * sideHeight * 2; // 2 panels
    final totalAreaMm2 = bottomArea + frontBackArea + sideArea;
    final totalAreaSqM = totalAreaMm2 / 1000000;

    // Estimate weight (glass density ~2.5 kg/dm³ = 2500 kg/m³)
    // Volume of glass = area * thickness
    final glassVolumeMm3 = totalAreaMm2 * glassThicknessMm;
    final glassVolumeM3 = glassVolumeMm3 / 1000000000;
    final estimatedWeightKg = glassVolumeM3 * 2500;

    return GlassCalculationEntity(
      name: name,
      lengthMm: lengthMm,
      widthMm: widthMm,
      heightMm: heightMm,
      glassThicknessMm: glassThicknessMm,
      glueThicknessMm: glueThicknessMm,
      volumeLiters: volumeLiters,
      bottomLengthMm: bottomLength,
      bottomWidthMm: bottomWidth,
      frontBackLengthMm: frontBackLength,
      frontBackHeightMm: frontBackHeight,
      sideWidthMm: sideWidth,
      sideHeightMm: sideHeight,
      totalGlassAreaSqM: totalAreaSqM,
      estimatedWeightKg: estimatedWeightKg,
      notes: notes,
    );
  }

  /// Suggest glass thickness based on tank height (in mm)
  /// Based on common aquarium building guidelines
  static double suggestGlassThickness(double heightMm) {
    if (heightMm <= 300) return 5.0;
    if (heightMm <= 400) return 6.0;
    if (heightMm <= 500) return 8.0;
    if (heightMm <= 600) return 10.0;
    if (heightMm <= 800) return 12.0;
    if (heightMm <= 1000) return 15.0;
    return 19.0;
  }
}
