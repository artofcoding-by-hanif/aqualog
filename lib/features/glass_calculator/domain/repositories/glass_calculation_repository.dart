import '../entities/glass_calculation.dart';

/// Glass calculation repository interface
abstract class GlassCalculationRepository {
  /// Get all saved calculations
  Future<List<GlassCalculationEntity>> getAllCalculations();

  /// Get a calculation by ID
  Future<GlassCalculationEntity?> getCalculationById(int id);

  /// Save a new calculation
  Future<int> saveCalculation(GlassCalculationEntity calculation);

  /// Update an existing calculation
  Future<void> updateCalculation(GlassCalculationEntity calculation);

  /// Delete a calculation
  Future<void> deleteCalculation(int id);

  /// Watch all calculations (reactive stream)
  Stream<List<GlassCalculationEntity>> watchAllCalculations();
}
