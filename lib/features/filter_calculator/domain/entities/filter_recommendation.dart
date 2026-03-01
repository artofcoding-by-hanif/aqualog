import 'filter_type.dart';
import 'filter_data.dart';

/// A filter recommendation with calculated values
class FilterRecommendation {
  final FilterType filterType;
  final int recommendedFlowLph;
  final double estimatedPowerW;
  final bool isIdealMatch;

  const FilterRecommendation({
    required this.filterType,
    required this.recommendedFlowLph,
    required this.estimatedPowerW,
    required this.isIdealMatch,
  });
}

/// Filter calculator service
class FilterCalculator {
  /// Calculate recommended flow rate based on tank size and bioload
  static int calculateRecommendedFlow({
    required double tankLiters,
    required BioloadLevel bioload,
  }) {
    // Base multiplier varies by bioload
    int multiplier;
    switch (bioload) {
      case BioloadLevel.low:
        multiplier = 3;
        break;
      case BioloadLevel.lowMedium:
        multiplier = 4;
        break;
      case BioloadLevel.medium:
        multiplier = 5;
        break;
      case BioloadLevel.mediumHigh:
        multiplier = 6;
        break;
      case BioloadLevel.high:
        multiplier = 8;
        break;
    }
    return (tankLiters * multiplier).round();
  }

  /// Get suitable filter recommendations for a tank
  static List<FilterRecommendation> getRecommendations({
    required double tankLiters,
    required BioloadLevel bioload,
  }) {
    final recommendedFlow = calculateRecommendedFlow(
      tankLiters: tankLiters,
      bioload: bioload,
    );

    final recommendations = <FilterRecommendation>[];

    for (final filter in FilterData.allFilters) {
      // Check if filter is suitable for tank size
      if (!filter.isSuitableForTankSize(tankLiters)) continue;

      // Check if filter can provide required flow
      final canProvide = filter.canProvideFlow(recommendedFlow);
      
      // Calculate if this is an ideal match (bioload matches)
      final isIdealMatch = _isBioloadCompatible(filter.bioloadLevel, bioload);

      // Estimate power for the recommended flow
      final estimatedPower = filter.estimatePowerForFlow(recommendedFlow);

      recommendations.add(FilterRecommendation(
        filterType: filter,
        recommendedFlowLph: recommendedFlow,
        estimatedPowerW: estimatedPower,
        isIdealMatch: canProvide && isIdealMatch,
      ));
    }

    // Sort by ideal match first, then by name
    recommendations.sort((a, b) {
      if (a.isIdealMatch && !b.isIdealMatch) return -1;
      if (!a.isIdealMatch && b.isIdealMatch) return 1;
      return a.filterType.name.compareTo(b.filterType.name);
    });

    return recommendations;
  }

  /// Check if filter bioload level is compatible with required bioload
  static bool _isBioloadCompatible(
    BioloadLevel filterLevel,
    BioloadLevel requiredLevel,
  ) {
    final filterIndex = BioloadLevel.values.indexOf(filterLevel);
    final requiredIndex = BioloadLevel.values.indexOf(requiredLevel);
    // Filter should handle same or higher bioload
    return filterIndex >= requiredIndex;
  }
}

