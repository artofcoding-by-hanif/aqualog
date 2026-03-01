import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

// Re-export database types for convenience
export 'app_database.dart';
export 'tables/tables.dart';

/// Provider for the main application database
/// This is a singleton that persists for the lifetime of the app
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();

  // Close the database when the provider is disposed
  ref.onDispose(() {
    database.close();
  });

  return database;
});

// ============================================================
// Tank Providers
// ============================================================

/// Provider to watch all tanks
final allTanksProvider = StreamProvider<List<Tank>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchAllTanks();
});

/// Provider to watch the active tank
final activeTankProvider = StreamProvider<Tank?>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchActiveTank();
});

/// Provider family to get a tank by ID
final tankByIdProvider = FutureProvider.family<Tank?, int>((ref, tankId) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getTankById(tankId);
});

// ============================================================
// Water Parameters Providers
// ============================================================

/// Provider family to watch water parameters for a specific tank
final waterParametersForTankProvider =
    StreamProvider.family<List<WaterParameter>, int>((ref, tankId) {
      final db = ref.watch(appDatabaseProvider);
      return db.watchWaterParametersForTank(tankId);
    });

/// Provider family to get the latest water parameters for a tank
final latestWaterParametersProvider =
    FutureProvider.family<WaterParameter?, int>((ref, tankId) {
      final db = ref.watch(appDatabaseProvider);
      return db.getLatestWaterParameters(tankId);
    });

/// Provider to watch water parameters for the active tank
final activeTankWaterParametersProvider = StreamProvider<List<WaterParameter>>((
  ref,
) {
  final db = ref.watch(appDatabaseProvider);
  final activeTankAsync = ref.watch(activeTankProvider);

  return activeTankAsync.when(
    data: (tank) {
      if (tank != null) {
        return db.watchWaterParametersForTank(tank.id);
      }
      return Stream.value([]);
    },
    loading: () => Stream.value([]),
    error: (error, stack) => Stream.value([]),
  );
});
