import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/glass_calculation_repository_impl.dart';
import '../../domain/entities/glass_calculation.dart';
import '../../domain/repositories/glass_calculation_repository.dart';

part 'glass_calculation_provider.g.dart';

/// Provider for GlassCalculationRepository
@Riverpod(keepAlive: true)
GlassCalculationRepository glassCalculationRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return GlassCalculationRepositoryImpl(database: db);
}

/// Provider to watch all saved calculations
@Riverpod(keepAlive: true)
Stream<List<GlassCalculationEntity>> glassCalculationsStream(Ref ref) {
  final repo = ref.watch(glassCalculationRepositoryProvider);
  return repo.watchAllCalculations();
}

/// Provider to get a calculation by ID
@riverpod
Future<GlassCalculationEntity?> glassCalculationById(Ref ref, int id) async {
  final repo = ref.watch(glassCalculationRepositoryProvider);
  return repo.getCalculationById(id);
}
