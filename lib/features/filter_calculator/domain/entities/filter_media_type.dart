/// Media category
enum MediaCategory {
  mechanical('Mechanical'),
  biological('Biological'),
  chemical('Chemical'),
  mechanicalBiological('Mechanical+Biological');

  final String displayName;
  const MediaCategory(this.displayName);

  static MediaCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'mechanical':
        return MediaCategory.mechanical;
      case 'biological':
        return MediaCategory.biological;
      case 'chemical':
        return MediaCategory.chemical;
      case 'mechanical+biological':
        return MediaCategory.mechanicalBiological;
      default:
        return MediaCategory.biological;
    }
  }
}

/// Filter media type data model
class FilterMediaType {
  final String name;
  final MediaCategory category;
  final String primaryFunction;
  final String particleSizeMicrons;
  final String biologicalEfficiency;
  final String chemicalAction;
  final String flowResistance;
  final int lifespanMonths;
  final String replaceOrRinse;
  final List<String> suitableFilterTypes;
  final List<String> suitableTankTypes;
  final String bioloadSupport;
  final String pros;
  final String cons;
  final String notes;

  const FilterMediaType({
    required this.name,
    required this.category,
    required this.primaryFunction,
    required this.particleSizeMicrons,
    required this.biologicalEfficiency,
    required this.chemicalAction,
    required this.flowResistance,
    required this.lifespanMonths,
    required this.replaceOrRinse,
    required this.suitableFilterTypes,
    required this.suitableTankTypes,
    required this.bioloadSupport,
    required this.pros,
    required this.cons,
    required this.notes,
  });

  /// Check if this media is suitable for a given filter type
  bool isSuitableForFilter(String filterType) {
    if (suitableFilterTypes.contains('All')) return true;
    return suitableFilterTypes.any(
      (type) => filterType.toLowerCase().contains(type.toLowerCase()),
    );
  }

  /// Check if this media is suitable for a given tank type
  bool isSuitableForTank(String tankType) {
    if (suitableTankTypes.contains('All')) return true;
    return suitableTankTypes.any(
      (type) => tankType.toLowerCase().contains(type.toLowerCase()),
    );
  }
}

