import '../../../../core/database/app_database.dart';
import '../../domain/entities/glass_calculation.dart';
import '../../domain/repositories/glass_calculation_repository.dart';
import '../models/glass_calculation_model.dart';

/// Glass calculation repository implementation using Drift database
class GlassCalculationRepositoryImpl implements GlassCalculationRepository {
  final AppDatabase _db;

  GlassCalculationRepositoryImpl({required AppDatabase database})
    : _db = database;

  @override
  Future<List<GlassCalculationEntity>> getAllCalculations() async {
    final calculations = await _db.getAllGlassCalculations();
    return calculations.map((c) => c.toEntity()).toList();
  }

  @override
  Future<GlassCalculationEntity?> getCalculationById(int id) async {
    final calculation = await _db.getGlassCalculationById(id);
    return calculation?.toEntity();
  }

  @override
  Future<int> saveCalculation(GlassCalculationEntity calculation) async {
    return await _db.insertGlassCalculation(calculation.toCompanion());
  }

  @override
  Future<void> updateCalculation(GlassCalculationEntity calculation) async {
    await _db.updateGlassCalculation(calculation.toDriftGlassCalculation());
  }

  @override
  Future<void> deleteCalculation(int id) async {
    await _db.deleteGlassCalculation(id);
  }

  @override
  Stream<List<GlassCalculationEntity>> watchAllCalculations() {
    return _db.watchAllGlassCalculations().map(
      (calculations) => calculations.map((c) => c.toEntity()).toList(),
    );
  }
}
