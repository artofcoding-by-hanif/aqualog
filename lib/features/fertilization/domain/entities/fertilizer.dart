/// Fertilizer entity

class Fertilizer {
  final String id;
  final String tankId;
  final String name;
  final String? brand;
  final String type; // Macro, Micro, All-in-one, etc.
  final double doseMl;
  final String frequency; // daily, weekly, etc.
  final String? notes;
  final DateTime createdAt;

  const Fertilizer({
    required this.id,
    required this.tankId,
    required this.name,
    this.brand,
    required this.type,
    required this.doseMl,
    required this.frequency,
    this.notes,
    required this.createdAt,
  });

  Fertilizer copyWith({
    String? id,
    String? tankId,
    String? name,
    String? brand,
    String? type,
    double? doseMl,
    String? frequency,
    String? notes,
    DateTime? createdAt,
  }) {
    return Fertilizer(
      id: id ?? this.id,
      tankId: tankId ?? this.tankId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      type: type ?? this.type,
      doseMl: doseMl ?? this.doseMl,
      frequency: frequency ?? this.frequency,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

