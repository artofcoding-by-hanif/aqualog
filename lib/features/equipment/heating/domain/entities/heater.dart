/// Heater entity

class Heater {
  final String id;
  final String tankId;
  final String name;
  final String? brand;
  final String? model;
  final double? wattage;
  final double targetTemperature;
  final String temperatureUnit; // celsius, fahrenheit
  final bool hasThermometer;
  final DateTime createdAt;

  const Heater({
    required this.id,
    required this.tankId,
    required this.name,
    this.brand,
    this.model,
    this.wattage,
    required this.targetTemperature,
    this.temperatureUnit = 'celsius',
    this.hasThermometer = false,
    required this.createdAt,
  });

  Heater copyWith({
    String? id,
    String? tankId,
    String? name,
    String? brand,
    String? model,
    double? wattage,
    double? targetTemperature,
    String? temperatureUnit,
    bool? hasThermometer,
    DateTime? createdAt,
  }) {
    return Heater(
      id: id ?? this.id,
      tankId: tankId ?? this.tankId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      wattage: wattage ?? this.wattage,
      targetTemperature: targetTemperature ?? this.targetTemperature,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      hasThermometer: hasThermometer ?? this.hasThermometer,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

