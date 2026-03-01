import 'dart:math' as math;

/// Tank shape types for volume calculation
enum TankShape {
  rectangular,
  cube,
  cylinder,
  bowFront,
  cornerBowFront,
  hexagonal,
  pentagon,
  lShaped,
  custom;

  String get displayName {
    switch (this) {
      case TankShape.rectangular:
        return 'Rectangular';
      case TankShape.cube:
        return 'Cube';
      case TankShape.cylinder:
        return 'Cylinder';
      case TankShape.bowFront:
        return 'Bow Front';
      case TankShape.cornerBowFront:
        return 'Corner Bow Front';
      case TankShape.hexagonal:
        return 'Hexagonal';
      case TankShape.pentagon:
        return 'Pentagon';
      case TankShape.lShaped:
        return 'L-Shaped';
      case TankShape.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case TankShape.rectangular:
        return '▭';
      case TankShape.cube:
        return '▢';
      case TankShape.cylinder:
        return '◯';
      case TankShape.bowFront:
        return '◠';
      case TankShape.cornerBowFront:
        return '◝';
      case TankShape.hexagonal:
        return '⬡';
      case TankShape.pentagon:
        return '⬠';
      case TankShape.lShaped:
        return '⌐';
      case TankShape.custom:
        return '?';
    }
  }

  /// Whether this shape requires width dimension
  bool get requiresWidth {
    switch (this) {
      case TankShape.cube:
      case TankShape.cylinder:
      case TankShape.hexagonal:
      case TankShape.pentagon:
        return false;
      default:
        return true;
    }
  }

  /// Whether this shape uses diameter instead of length
  bool get usesDiameter {
    switch (this) {
      case TankShape.cylinder:
      case TankShape.hexagonal:
      case TankShape.pentagon:
        return true;
      default:
        return false;
    }
  }

  /// Dimension labels for this shape
  List<String> get dimensionLabels {
    switch (this) {
      case TankShape.rectangular:
        return ['Length (cm)', 'Width (cm)', 'Height (cm)'];
      case TankShape.cube:
        return ['Side (cm)', '', 'Height (cm)'];
      case TankShape.cylinder:
        return ['Diameter (cm)', '', 'Height (cm)'];
      case TankShape.bowFront:
        return ['Length (cm)', 'Width (cm)', 'Height (cm)'];
      case TankShape.cornerBowFront:
        return ['Length (cm)', 'Width (cm)', 'Height (cm)'];
      case TankShape.hexagonal:
        return ['Side (cm)', '', 'Height (cm)'];
      case TankShape.pentagon:
        return ['Side (cm)', '', 'Height (cm)'];
      case TankShape.lShaped:
        return ['Length (cm)', 'Width (cm)', 'Height (cm)'];
      case TankShape.custom:
        return ['Length (cm)', 'Width (cm)', 'Height (cm)'];
    }
  }
}

/// Volume calculator for aquarium tanks
class VolumeCalculator {
  VolumeCalculator._();

  static const double _pi = math.pi;

  /// Calculate volume based on shape and dimensions
  /// Returns volume in liters
  static double? calculate({
    required TankShape shape,
    required double? lengthCm,
    double? widthCm,
    required double? heightCm,
    double? bowDepthCm, // For bow front tanks
  }) {
    if (lengthCm == null || heightCm == null) return null;
    if (lengthCm <= 0 || heightCm <= 0) return null;

    switch (shape) {
      case TankShape.rectangular:
        if (widthCm == null || widthCm <= 0) return null;
        return rectangular(
          lengthCm: lengthCm,
          widthCm: widthCm,
          heightCm: heightCm,
        );
      case TankShape.cube:
        return cube(sideCm: lengthCm, heightCm: heightCm);
      case TankShape.cylinder:
        return cylinder(diameterCm: lengthCm, heightCm: heightCm);
      case TankShape.bowFront:
        if (widthCm == null || widthCm <= 0) return null;
        return bowFront(
          lengthCm: lengthCm,
          widthCm: widthCm,
          heightCm: heightCm,
          bowDepthCm: bowDepthCm ?? (widthCm * 0.15), // Default 15% of width
        );
      case TankShape.cornerBowFront:
        if (widthCm == null || widthCm <= 0) return null;
        return cornerBowFront(
          lengthCm: lengthCm,
          widthCm: widthCm,
          heightCm: heightCm,
        );
      case TankShape.hexagonal:
        return hexagonal(sideCm: lengthCm, heightCm: heightCm);
      case TankShape.pentagon:
        return pentagon(sideCm: lengthCm, heightCm: heightCm);
      case TankShape.lShaped:
        if (widthCm == null || widthCm <= 0) return null;
        // L-shaped uses rectangular approximation (user enters actual volume)
        return rectangular(
          lengthCm: lengthCm,
          widthCm: widthCm,
          heightCm: heightCm,
        );
      case TankShape.custom:
        return null; // User enters volume manually
    }
  }

  /// Calculate rectangular tank volume in liters
  static double rectangular({
    required double lengthCm,
    required double widthCm,
    required double heightCm,
  }) {
    return (lengthCm * widthCm * heightCm) / 1000;
  }

  /// Calculate cube tank volume in liters
  /// Note: A "cube" tank may not have equal height, so we take side and height
  static double cube({required double sideCm, double? heightCm}) {
    final h = heightCm ?? sideCm;
    return (sideCm * sideCm * h) / 1000;
  }

  /// Calculate cylinder tank volume in liters
  static double cylinder({
    required double diameterCm,
    required double heightCm,
  }) {
    final radius = diameterCm / 2;
    return (_pi * radius * radius * heightCm) / 1000;
  }

  /// Calculate bow front tank volume in liters
  /// Bow front = rectangular base + curved front section
  static double bowFront({
    required double lengthCm,
    required double widthCm,
    required double heightCm,
    double? bowDepthCm,
  }) {
    final bowDepth = bowDepthCm ?? (widthCm * 0.15);

    // Base rectangular volume
    final baseVolume = lengthCm * widthCm * heightCm;

    // Additional bow volume (approximated as half ellipse)
    // Area of half ellipse = (π * a * b) / 2
    // where a = length/2, b = bowDepth
    final bowVolume = (_pi * (lengthCm / 2) * bowDepth * heightCm) / 2;

    return (baseVolume + bowVolume) / 1000;
  }

  /// Calculate corner bow front (quarter cylinder) tank volume
  static double cornerBowFront({
    required double lengthCm,
    required double widthCm,
    required double heightCm,
  }) {
    // Corner bow front is roughly a quarter cylinder
    final radius = math.min(lengthCm, widthCm);
    final quarterCylinderVolume = (_pi * radius * radius * heightCm) / 4;
    return quarterCylinderVolume / 1000;
  }

  /// Calculate regular hexagonal tank volume in liters
  static double hexagonal({required double sideCm, required double heightCm}) {
    // Area of regular hexagon = (3 * √3 / 2) * s²
    final hexArea = (3 * math.sqrt(3) / 2) * sideCm * sideCm;
    return (hexArea * heightCm) / 1000;
  }

  /// Calculate regular pentagon tank volume in liters
  static double pentagon({required double sideCm, required double heightCm}) {
    // Area of regular pentagon = (1/4) * √(5(5 + 2√5)) * s²
    final pentArea =
        (1 / 4) * math.sqrt(5 * (5 + 2 * math.sqrt(5))) * sideCm * sideCm;
    return (pentArea * heightCm) / 1000;
  }

  // ============================================================
  // Unit Conversions
  // ============================================================

  /// Convert liters to US gallons
  static double litersToGallons(double liters) {
    return liters * 0.264172;
  }

  /// Convert US gallons to liters
  static double gallonsToLiters(double gallons) {
    return gallons * 3.78541;
  }

  /// Convert liters to UK gallons
  static double litersToGallonsUK(double liters) {
    return liters * 0.219969;
  }

  /// Convert UK gallons to liters
  static double gallonsUKToLiters(double gallons) {
    return gallons * 4.54609;
  }

  /// Convert cm to inches
  static double cmToInches(double cm) {
    return cm / 2.54;
  }

  /// Convert inches to cm
  static double inchesToCm(double inches) {
    return inches * 2.54;
  }
}
