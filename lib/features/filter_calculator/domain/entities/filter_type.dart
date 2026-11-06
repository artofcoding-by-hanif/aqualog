/// Bioload level for fish/tank
enum BioloadLevel {
  low('Low'),
  lowMedium('Low-Medium'),
  medium('Medium'),
  mediumHigh('Medium-High'),
  high('High');

  final String displayName;
  const BioloadLevel(this.displayName);

  static BioloadLevel fromString(String value) {
    switch (value.toLowerCase()) {
      case 'low':
        return BioloadLevel.low;
      case 'low-medium':
        return BioloadLevel.lowMedium;
      case 'medium':
        return BioloadLevel.medium;
      case 'medium-high':
        return BioloadLevel.mediumHigh;
      case 'high':
        return BioloadLevel.high;
      default:
        return BioloadLevel.medium;
    }
  }
}

/// Filter type data model
class FilterType {
  final String name;
  final String installation;
  final int flowMinLph;
  final int flowMaxLph;
  final int powerMinW;
  final int powerMaxW;
  final int tankSizeMinL;
  final int tankSizeMaxL;
  final int flowMultiplierRecommended;
  final String fishSuitability;
  final BioloadLevel bioloadLevel;
  final String noiseLevel;
  final String maintenanceFrequency;
  final String pros;
  final String cons;
  final String notes;

  const FilterType({
    required this.name,
    required this.installation,
    required this.flowMinLph,
    required this.flowMaxLph,
    required this.powerMinW,
    required this.powerMaxW,
    required this.tankSizeMinL,
    required this.tankSizeMaxL,
    required this.flowMultiplierRecommended,
    required this.fishSuitability,
    required this.bioloadLevel,
    required this.noiseLevel,
    required this.maintenanceFrequency,
    required this.pros,
    required this.cons,
    required this.notes,
  });

  /// Check if this filter is suitable for a given tank size
  bool isSuitableForTankSize(double tankLiters) {
    return tankLiters >= tankSizeMinL && tankLiters <= tankSizeMaxL;
  }

  /// Calculate recommended flow rate for a tank
  int calculateRecommendedFlow(double tankLiters) {
    return (tankLiters * flowMultiplierRecommended).round();
  }

  /// Check if this filter can provide the required flow
  bool canProvideFlow(int requiredFlowLph) {
    return requiredFlowLph >= flowMinLph && requiredFlowLph <= flowMaxLph;
  }

  /// Estimate power consumption for a given flow rate
  double estimatePowerForFlow(int flowLph) {
    if (flowLph <= flowMinLph) return powerMinW.toDouble();
    if (flowLph >= flowMaxLph) return powerMaxW.toDouble();

    final flowRange = flowMaxLph - flowMinLph;
    final powerRange = powerMaxW - powerMinW;
    final flowRatio = (flowLph - flowMinLph) / flowRange;
    return powerMinW + (powerRange * flowRatio);
  }
}
