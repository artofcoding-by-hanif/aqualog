// Application enums
//
// Note: TankType is defined in lib/features/tank/domain/entities/tank.dart
// Note: TankShape is defined in lib/core/utils/volume_calculator.dart

/// Types of water parameters that can be measured
enum WaterParameterType {
  ph,
  ammonia,
  nitrite,
  nitrate,
  temperature,
  gh,
  kh,
  phosphate,
  co2,
}

enum ReminderFrequency { daily, weekly, biweekly, monthly, custom }

enum LogEntryType {
  waterChange,
  feeding,
  maintenance,
  observation,
  treatment,
  other,
}
