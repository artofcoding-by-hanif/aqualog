/// Water parameter entity

class WaterParameter {
  final String id;
  final String tankId;
  final String type; // pH, ammonia, nitrite, etc.
  final double value;
  final String unit;
  final DateTime measuredAt;
  final String? notes;

  const WaterParameter({
    required this.id,
    required this.tankId,
    required this.type,
    required this.value,
    required this.unit,
    required this.measuredAt,
    this.notes,
  });

  WaterParameter copyWith({
    String? id,
    String? tankId,
    String? type,
    double? value,
    String? unit,
    DateTime? measuredAt,
    String? notes,
  }) {
    return WaterParameter(
      id: id ?? this.id,
      tankId: tankId ?? this.tankId,
      type: type ?? this.type,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      measuredAt: measuredAt ?? this.measuredAt,
      notes: notes ?? this.notes,
    );
  }
}

/// Ideal parameter range

class ParameterRange {
  final String type;
  final double minValue;
  final double maxValue;
  final String unit;

  const ParameterRange({
    required this.type,
    required this.minValue,
    required this.maxValue,
    required this.unit,
  });

  bool isInRange(double value) {
    return value >= minValue && value <= maxValue;
  }
}

