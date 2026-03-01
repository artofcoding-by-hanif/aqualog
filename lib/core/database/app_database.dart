import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'migrations.dart';
import 'tables/tables.dart';

part 'app_database.g.dart';

/// Main application database using Drift
///
/// ## Schema Version History:
/// - v1: Initial schema with all base tables
/// - v2: Added Filters table for equipment/filtration feature
/// - v3: Added filterId column to Reminders table for filter-linked reminders
/// - v4: Added Lightings table for equipment/lighting feature
/// - v5: Added Fish table for livestock/fish feature
/// - v6: Added Invertebrates table for livestock/invertebrates feature
/// - v7: Added Rocks and Driftwoods tables for hardscape feature
/// - v8: Added SubstrateLayers table for substrate feature
/// - v9: Added FeedingLogs table for feeding log feature
/// - v10: Added foodType column to Reminders table for feeding reminders
/// - v11: Added Plants table for plants feature
/// - v12: Added TankImages table for tank photo gallery
/// - v13: Added GlassCalculations table for glass calculator feature
///
/// When adding new migrations:
/// 1. Increment [schemaVersion]
/// 2. Add migration logic in [DatabaseMigrations]
/// 3. Document the change in the version history above
@DriftDatabase(
  tables: [
    Tanks,
    TankImages,
    WaterParameters,
    Livestock,
    Equipment,
    Filters,
    Lightings,
    Fish,
    Invertebrates,
    Rocks,
    Driftwoods,
    SubstrateLayers,
    Fertilizers,
    FertilizationLogs,
    Reminders,
    MaintenanceLogs,
    FeedingLogs,
    Plants,
    GlassCalculations,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Database schema version - increment when making schema changes
  ///
  /// IMPORTANT: When incrementing this:
  /// 1. Add migration in [DatabaseMigrations]
  /// 2. Update version history in class documentation
  /// 3. Test migration with existing data
  @override
  int get schemaVersion => 13;

  /// Handle database migrations
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Run migrations using our migration system
        await DatabaseMigrations.runMigrations(m, this, from, to);
      },
      beforeOpen: (details) async {
        // Enable foreign keys for referential integrity
        await customStatement('PRAGMA foreign_keys = ON');

        // Log migration info in debug mode
        if (details.wasCreated) {
          // Database was just created
        } else if (details.hadUpgrade) {
          // Database was upgraded from ${details.versionBefore} to ${details.versionNow}
        }
      },
    );
  }

  /// Open the database connection
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'aqualog_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }

  // ============================================================
  // Tank Operations
  // ============================================================

  /// Get all tanks
  Future<List<Tank>> getAllTanks() => select(tanks).get();

  /// Watch all tanks (reactive stream)
  Stream<List<Tank>> watchAllTanks() => select(tanks).watch();

  /// Get tank by ID
  Future<Tank?> getTankById(int id) =>
      (select(tanks)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Get the active tank
  Future<Tank?> getActiveTank() =>
      (select(tanks)..where((t) => t.isActive.equals(true))).getSingleOrNull();

  /// Watch the active tank
  Stream<Tank?> watchActiveTank() => (select(
    tanks,
  )..where((t) => t.isActive.equals(true))).watchSingleOrNull();

  /// Insert a new tank
  Future<int> insertTank(TanksCompanion tank) => into(tanks).insert(tank);

  /// Update a tank
  Future<bool> updateTank(Tank tank) => update(tanks).replace(tank);

  /// Delete a tank
  Future<int> deleteTank(int id) =>
      (delete(tanks)..where((t) => t.id.equals(id))).go();

  /// Set a tank as active (deactivates all others)
  Future<void> setActiveTank(int tankId) async {
    await transaction(() async {
      // Deactivate all tanks
      await (update(tanks)..where((t) => t.isActive.equals(true))).write(
        const TanksCompanion(isActive: Value(false)),
      );
      // Activate the selected tank
      await (update(tanks)..where((t) => t.id.equals(tankId))).write(
        const TanksCompanion(isActive: Value(true)),
      );
    });
  }

  // ============================================================
  // Water Parameters Operations
  // ============================================================

  /// Get water parameters for a tank
  Future<List<WaterParameter>> getWaterParametersForTank(int tankId) =>
      (select(waterParameters)
            ..where((w) => w.tankId.equals(tankId))
            ..orderBy([(w) => OrderingTerm.desc(w.measuredAt)]))
          .get();

  /// Watch water parameters for a tank
  Stream<List<WaterParameter>> watchWaterParametersForTank(int tankId) =>
      (select(waterParameters)
            ..where((w) => w.tankId.equals(tankId))
            ..orderBy([(w) => OrderingTerm.desc(w.measuredAt)]))
          .watch();

  /// Get latest water parameters for a tank
  Future<WaterParameter?> getLatestWaterParameters(int tankId) =>
      (select(waterParameters)
            ..where((w) => w.tankId.equals(tankId))
            ..orderBy([(w) => OrderingTerm.desc(w.measuredAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Get water parameter by ID
  Future<WaterParameter?> getWaterParameterById(int id) => (select(
    waterParameters,
  )..where((w) => w.id.equals(id))).getSingleOrNull();

  /// Insert water parameters
  Future<int> insertWaterParameters(WaterParametersCompanion params) =>
      into(waterParameters).insert(params);

  /// Update water parameters
  Future<bool> updateWaterParameters(WaterParameter params) =>
      update(waterParameters).replace(params);

  /// Delete water parameters
  Future<int> deleteWaterParameters(int id) =>
      (delete(waterParameters)..where((w) => w.id.equals(id))).go();

  /// Delete all water parameters for a tank
  Future<int> deleteWaterParametersForTank(int tankId) =>
      (delete(waterParameters)..where((w) => w.tankId.equals(tankId))).go();

  // ============================================================
  // Filter Operations
  // ============================================================

  /// Get all filters for a tank
  Future<List<Filter>> getFiltersForTank(int tankId) =>
      (select(filters)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.asc(f.name)]))
          .get();

  /// Watch all filters for a tank
  Stream<List<Filter>> watchFiltersForTank(int tankId) =>
      (select(filters)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.asc(f.name)]))
          .watch();

  /// Get filter by ID
  Future<Filter?> getFilterById(int id) =>
      (select(filters)..where((f) => f.id.equals(id))).getSingleOrNull();

  /// Insert a new filter
  Future<int> insertFilter(FiltersCompanion filter) =>
      into(filters).insert(filter);

  /// Update a filter
  Future<bool> updateFilter(Filter filter) => update(filters).replace(filter);

  /// Delete a filter
  Future<int> deleteFilter(int id) =>
      (delete(filters)..where((f) => f.id.equals(id))).go();

  /// Delete all filters for a tank
  Future<int> deleteFiltersForTank(int tankId) =>
      (delete(filters)..where((f) => f.tankId.equals(tankId))).go();

  // ============================================================
  // Lighting Operations
  // ============================================================

  /// Get all lightings for a tank
  Future<List<Lighting>> getLightingsForTank(int tankId) =>
      (select(lightings)
            ..where((l) => l.tankId.equals(tankId))
            ..orderBy([(l) => OrderingTerm.asc(l.name)]))
          .get();

  /// Watch all lightings for a tank
  Stream<List<Lighting>> watchLightingsForTank(int tankId) =>
      (select(lightings)
            ..where((l) => l.tankId.equals(tankId))
            ..orderBy([(l) => OrderingTerm.asc(l.name)]))
          .watch();

  /// Get lighting by ID
  Future<Lighting?> getLightingById(int id) =>
      (select(lightings)..where((l) => l.id.equals(id))).getSingleOrNull();

  /// Insert a new lighting
  Future<int> insertLighting(LightingsCompanion lighting) =>
      into(lightings).insert(lighting);

  /// Update a lighting
  Future<bool> updateLighting(Lighting lighting) =>
      update(lightings).replace(lighting);

  /// Delete a lighting
  Future<int> deleteLighting(int id) =>
      (delete(lightings)..where((l) => l.id.equals(id))).go();

  /// Delete all lightings for a tank
  Future<int> deleteLightingsForTank(int tankId) =>
      (delete(lightings)..where((l) => l.tankId.equals(tankId))).go();

  // ============================================================
  // Fish Operations
  // ============================================================

  /// Get all fish for a tank
  Future<List<FishData>> getFishForTank(int tankId) =>
      (select(fish)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.asc(f.commonName)]))
          .get();

  /// Watch all fish for a tank
  Stream<List<FishData>> watchFishForTank(int tankId) =>
      (select(fish)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.asc(f.commonName)]))
          .watch();

  /// Get fish by ID
  Future<FishData?> getFishById(int id) =>
      (select(fish)..where((f) => f.id.equals(id))).getSingleOrNull();

  /// Insert a new fish
  Future<int> insertFish(FishCompanion fishData) => into(fish).insert(fishData);

  /// Update a fish
  Future<bool> updateFish(FishData fishData) => update(fish).replace(fishData);

  /// Delete a fish
  Future<int> deleteFish(int id) =>
      (delete(fish)..where((f) => f.id.equals(id))).go();

  /// Delete all fish for a tank
  Future<int> deleteFishForTank(int tankId) =>
      (delete(fish)..where((f) => f.tankId.equals(tankId))).go();

  /// Get alive fish count for a tank
  Future<int> getAliveFishCount(int tankId) async {
    final result = await (select(
      fish,
    )..where((f) => f.tankId.equals(tankId) & f.dateDeceased.isNull())).get();
    return result.fold<int>(0, (sum, f) => sum + f.quantity);
  }

  // ============================================================
  // Invertebrate Operations
  // ============================================================

  /// Get all invertebrates for a tank
  Future<List<Invertebrate>> getInvertebratesForTank(int tankId) =>
      (select(invertebrates)
            ..where((i) => i.tankId.equals(tankId))
            ..orderBy([(i) => OrderingTerm.asc(i.commonName)]))
          .get();

  /// Watch all invertebrates for a tank
  Stream<List<Invertebrate>> watchInvertebratesForTank(int tankId) =>
      (select(invertebrates)
            ..where((i) => i.tankId.equals(tankId))
            ..orderBy([(i) => OrderingTerm.asc(i.commonName)]))
          .watch();

  /// Get invertebrate by ID
  Future<Invertebrate?> getInvertebrateById(int id) =>
      (select(invertebrates)..where((i) => i.id.equals(id))).getSingleOrNull();

  /// Insert a new invertebrate
  Future<int> insertInvertebrate(InvertebratesCompanion invertebrate) =>
      into(invertebrates).insert(invertebrate);

  /// Update an invertebrate
  Future<bool> updateInvertebrate(Invertebrate invertebrate) =>
      update(invertebrates).replace(invertebrate);

  /// Delete an invertebrate
  Future<int> deleteInvertebrate(int id) =>
      (delete(invertebrates)..where((i) => i.id.equals(id))).go();

  /// Delete all invertebrates for a tank
  Future<int> deleteInvertebratesForTank(int tankId) =>
      (delete(invertebrates)..where((i) => i.tankId.equals(tankId))).go();

  /// Get alive invertebrate count for a tank
  Future<int> getAliveInvertebrateCount(int tankId) async {
    final result = await (select(
      invertebrates,
    )..where((i) => i.tankId.equals(tankId) & i.dateDeceased.isNull())).get();
    return result.fold<int>(0, (sum, i) => sum + i.quantity);
  }

  // ============================================================
  // Reminder Operations
  // ============================================================

  /// Get all reminders (ordered by scheduled time)
  Future<List<Reminder>> getAllReminders() => (select(
    reminders,
  )..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)])).get();

  /// Watch all reminders (reactive stream)
  Stream<List<Reminder>> watchAllReminders() => (select(
    reminders,
  )..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)])).watch();

  /// Get all reminders for a tank
  Future<List<Reminder>> getRemindersForTank(int tankId) =>
      (select(reminders)
            ..where((r) => r.tankId.equals(tankId))
            ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
          .get();

  /// Watch all reminders for a tank
  Stream<List<Reminder>> watchRemindersForTank(int tankId) =>
      (select(reminders)
            ..where((r) => r.tankId.equals(tankId))
            ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
          .watch();

  /// Get all reminders for a filter
  Future<List<Reminder>> getRemindersForFilter(int filterId) =>
      (select(reminders)
            ..where((r) => r.filterId.equals(filterId))
            ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
          .get();

  /// Get reminder by ID
  Future<Reminder?> getReminderById(int id) =>
      (select(reminders)..where((r) => r.id.equals(id))).getSingleOrNull();

  /// Get enabled reminders (for scheduling)
  Future<List<Reminder>> getEnabledReminders() =>
      (select(reminders)
            ..where((r) => r.isEnabled.equals(true))
            ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
          .get();

  /// Get overdue reminders
  Future<List<Reminder>> getOverdueReminders() =>
      (select(reminders)
            ..where(
              (r) =>
                  r.isEnabled.equals(true) &
                  r.isCompleted.equals(false) &
                  r.scheduledAt.isSmallerThanValue(DateTime.now()),
            )
            ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
          .get();

  /// Get upcoming reminders (due within specified days)
  Future<List<Reminder>> getUpcomingReminders(int withinDays) {
    final now = DateTime.now();
    final endDate = now.add(Duration(days: withinDays));
    return (select(reminders)
          ..where(
            (r) =>
                r.isEnabled.equals(true) &
                r.scheduledAt.isBiggerOrEqualValue(now) &
                r.scheduledAt.isSmallerOrEqualValue(endDate),
          )
          ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
        .get();
  }

  /// Insert a new reminder
  Future<int> insertReminder(RemindersCompanion reminder) =>
      into(reminders).insert(reminder);

  /// Update a reminder
  Future<bool> updateReminder(Reminder reminder) =>
      update(reminders).replace(reminder);

  /// Delete a reminder
  Future<int> deleteReminder(int id) =>
      (delete(reminders)..where((r) => r.id.equals(id))).go();

  /// Delete all reminders for a tank
  Future<int> deleteRemindersForTank(int tankId) =>
      (delete(reminders)..where((r) => r.tankId.equals(tankId))).go();

  /// Delete all reminders for a filter
  Future<int> deleteRemindersForFilter(int filterId) =>
      (delete(reminders)..where((r) => r.filterId.equals(filterId))).go();

  /// Get reminder by filter ID and type
  Future<Reminder?> getReminderByFilterAndType(
    int filterId,
    ReminderType type,
  ) =>
      (select(reminders)..where(
            (r) =>
                r.filterId.equals(filterId) & r.reminderType.equalsValue(type),
          ))
          .getSingleOrNull();

  /// Update reminder scheduled time
  Future<void> updateReminderScheduledAt(int reminderId, DateTime scheduledAt) {
    return (update(reminders)..where((r) => r.id.equals(reminderId))).write(
      RemindersCompanion(
        scheduledAt: Value(scheduledAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Mark a reminder as completed and reschedule if recurring
  Future<void> completeReminder(int reminderId) async {
    final reminder = await getReminderById(reminderId);
    if (reminder == null) return;

    final now = DateTime.now();

    if (reminder.repeatFrequency == RepeatFrequency.none) {
      // One-time reminder: mark as completed
      await (update(reminders)..where((r) => r.id.equals(reminderId))).write(
        RemindersCompanion(
          isCompleted: const Value(true),
          lastCompletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else {
      // Recurring reminder: update lastCompletedAt and calculate next scheduledAt
      final interval = reminder.repeatFrequency == RepeatFrequency.custom
          ? reminder.customIntervalDays ?? 7
          : _getIntervalDays(reminder.repeatFrequency);

      DateTime nextScheduledAt;
      if (reminder.repeatFrequency == RepeatFrequency.monthly) {
        nextScheduledAt = DateTime(
          now.year,
          now.month + 1,
          now.day,
          reminder.scheduledAt.hour,
          reminder.scheduledAt.minute,
        );
      } else {
        nextScheduledAt = now.add(Duration(days: interval));
        // Preserve the original time
        nextScheduledAt = DateTime(
          nextScheduledAt.year,
          nextScheduledAt.month,
          nextScheduledAt.day,
          reminder.scheduledAt.hour,
          reminder.scheduledAt.minute,
        );
      }

      await (update(reminders)..where((r) => r.id.equals(reminderId))).write(
        RemindersCompanion(
          isCompleted: const Value(false),
          lastCompletedAt: Value(now),
          scheduledAt: Value(nextScheduledAt),
          updatedAt: Value(now),
        ),
      );
    }
  }

  /// Helper to get interval days for a repeat frequency
  int _getIntervalDays(RepeatFrequency frequency) {
    switch (frequency) {
      case RepeatFrequency.none:
        return 0;
      case RepeatFrequency.daily:
        return 1;
      case RepeatFrequency.weekly:
        return 7;
      case RepeatFrequency.biweekly:
        return 14;
      case RepeatFrequency.monthly:
        return 30;
      case RepeatFrequency.custom:
        return 7;
    }
  }

  /// Toggle reminder enabled status
  Future<void> toggleReminderEnabled(int reminderId, bool isEnabled) {
    return (update(reminders)..where((r) => r.id.equals(reminderId))).write(
      RemindersCompanion(
        isEnabled: Value(isEnabled),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Snooze a reminder by a specified duration
  Future<void> snoozeReminder(int reminderId, Duration duration) async {
    final reminder = await getReminderById(reminderId);
    if (reminder == null) return;

    final newScheduledAt = DateTime.now().add(duration);
    await (update(reminders)..where((r) => r.id.equals(reminderId))).write(
      RemindersCompanion(
        scheduledAt: Value(newScheduledAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // ============================================================
  // Rock Operations
  // ============================================================

  /// Get all rocks for a tank
  Future<List<Rock>> getRocksForTank(int tankId) =>
      (select(rocks)
            ..where((r) => r.tankId.equals(tankId))
            ..orderBy([(r) => OrderingTerm.asc(r.name)]))
          .get();

  /// Watch all rocks for a tank
  Stream<List<Rock>> watchRocksForTank(int tankId) =>
      (select(rocks)
            ..where((r) => r.tankId.equals(tankId))
            ..orderBy([(r) => OrderingTerm.asc(r.name)]))
          .watch();

  /// Get rock by ID
  Future<Rock?> getRockById(int id) =>
      (select(rocks)..where((r) => r.id.equals(id))).getSingleOrNull();

  /// Insert a new rock
  Future<int> insertRock(RocksCompanion rock) => into(rocks).insert(rock);

  /// Update a rock
  Future<bool> updateRock(Rock rock) => update(rocks).replace(rock);

  /// Delete a rock
  Future<int> deleteRock(int id) =>
      (delete(rocks)..where((r) => r.id.equals(id))).go();

  /// Delete all rocks for a tank
  Future<int> deleteRocksForTank(int tankId) =>
      (delete(rocks)..where((r) => r.tankId.equals(tankId))).go();

  // ============================================================
  // Driftwood Operations
  // ============================================================

  /// Get all driftwoods for a tank
  Future<List<Driftwood>> getDriftwoodsForTank(int tankId) =>
      (select(driftwoods)
            ..where((d) => d.tankId.equals(tankId))
            ..orderBy([(d) => OrderingTerm.asc(d.name)]))
          .get();

  /// Watch all driftwoods for a tank
  Stream<List<Driftwood>> watchDriftwoodsForTank(int tankId) =>
      (select(driftwoods)
            ..where((d) => d.tankId.equals(tankId))
            ..orderBy([(d) => OrderingTerm.asc(d.name)]))
          .watch();

  /// Get driftwood by ID
  Future<Driftwood?> getDriftwoodById(int id) =>
      (select(driftwoods)..where((d) => d.id.equals(id))).getSingleOrNull();

  /// Insert a new driftwood
  Future<int> insertDriftwood(DriftwoodsCompanion driftwood) =>
      into(driftwoods).insert(driftwood);

  /// Update a driftwood
  Future<bool> updateDriftwood(Driftwood driftwood) =>
      update(driftwoods).replace(driftwood);

  /// Delete a driftwood
  Future<int> deleteDriftwood(int id) =>
      (delete(driftwoods)..where((d) => d.id.equals(id))).go();

  /// Delete all driftwoods for a tank
  Future<int> deleteDriftwoodsForTank(int tankId) =>
      (delete(driftwoods)..where((d) => d.tankId.equals(tankId))).go();

  // ============================================================
  // Substrate Layer Operations
  // ============================================================

  /// Get all substrate layers for a tank (ordered by layerOrder)
  Future<List<SubstrateLayer>> getSubstrateLayersForTank(int tankId) =>
      (select(substrateLayers)
            ..where((s) => s.tankId.equals(tankId))
            ..orderBy([(s) => OrderingTerm.asc(s.layerOrder)]))
          .get();

  /// Watch all substrate layers for a tank (ordered by layerOrder)
  Stream<List<SubstrateLayer>> watchSubstrateLayersForTank(int tankId) =>
      (select(substrateLayers)
            ..where((s) => s.tankId.equals(tankId))
            ..orderBy([(s) => OrderingTerm.asc(s.layerOrder)]))
          .watch();

  /// Get substrate layer by ID
  Future<SubstrateLayer?> getSubstrateLayerById(int id) => (select(
    substrateLayers,
  )..where((s) => s.id.equals(id))).getSingleOrNull();

  /// Insert a new substrate layer
  Future<int> insertSubstrateLayer(SubstrateLayersCompanion layer) =>
      into(substrateLayers).insert(layer);

  /// Update a substrate layer
  Future<bool> updateSubstrateLayer(SubstrateLayer layer) =>
      update(substrateLayers).replace(layer);

  /// Delete a substrate layer
  Future<int> deleteSubstrateLayer(int id) =>
      (delete(substrateLayers)..where((s) => s.id.equals(id))).go();

  /// Delete all substrate layers for a tank
  Future<int> deleteSubstrateLayersForTank(int tankId) =>
      (delete(substrateLayers)..where((s) => s.tankId.equals(tankId))).go();

  /// Reorder substrate layers for a tank
  /// [layerIds] is an ordered list of layer IDs (index 0 = bottom layer)
  Future<void> reorderSubstrateLayers(int tankId, List<int> layerIds) async {
    await transaction(() async {
      for (var i = 0; i < layerIds.length; i++) {
        await (update(substrateLayers)..where((s) => s.id.equals(layerIds[i])))
            .write(SubstrateLayersCompanion(layerOrder: Value(i)));
      }
    });
  }

  // ============================================================
  // Maintenance Log Operations
  // ============================================================

  /// Get all maintenance logs for a tank (ordered by performedAt desc)
  Future<List<MaintenanceLog>> getMaintenanceLogsForTank(int tankId) =>
      (select(maintenanceLogs)
            ..where((m) => m.tankId.equals(tankId))
            ..orderBy([(m) => OrderingTerm.desc(m.performedAt)]))
          .get();

  /// Watch all maintenance logs for a tank
  Stream<List<MaintenanceLog>> watchMaintenanceLogsForTank(int tankId) =>
      (select(maintenanceLogs)
            ..where((m) => m.tankId.equals(tankId))
            ..orderBy([(m) => OrderingTerm.desc(m.performedAt)]))
          .watch();

  /// Get maintenance log by ID
  Future<MaintenanceLog?> getMaintenanceLogById(int id) => (select(
    maintenanceLogs,
  )..where((m) => m.id.equals(id))).getSingleOrNull();

  /// Get latest maintenance log for a tank
  Future<MaintenanceLog?> getLatestMaintenanceLog(int tankId) =>
      (select(maintenanceLogs)
            ..where((m) => m.tankId.equals(tankId))
            ..orderBy([(m) => OrderingTerm.desc(m.performedAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Get latest maintenance log of a specific type for a tank
  Future<MaintenanceLog?> getLatestMaintenanceLogByType(
    int tankId,
    int maintenanceType,
  ) =>
      (select(maintenanceLogs)
            ..where(
              (m) =>
                  m.tankId.equals(tankId) &
                  m.maintenanceType.equals(maintenanceType),
            )
            ..orderBy([(m) => OrderingTerm.desc(m.performedAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Insert a new maintenance log
  Future<int> insertMaintenanceLog(MaintenanceLogsCompanion log) =>
      into(maintenanceLogs).insert(log);

  /// Update a maintenance log
  Future<bool> updateMaintenanceLog(MaintenanceLog log) =>
      update(maintenanceLogs).replace(log);

  /// Delete a maintenance log
  Future<int> deleteMaintenanceLog(int id) =>
      (delete(maintenanceLogs)..where((m) => m.id.equals(id))).go();

  /// Delete all maintenance logs for a tank
  Future<int> deleteMaintenanceLogsForTank(int tankId) =>
      (delete(maintenanceLogs)..where((m) => m.tankId.equals(tankId))).go();

  /// Get recent maintenance logs across all tanks (for dashboard)
  Future<List<MaintenanceLog>> getRecentMaintenanceLogs({int limit = 10}) =>
      (select(maintenanceLogs)
            ..orderBy([(m) => OrderingTerm.desc(m.performedAt)])
            ..limit(limit))
          .get();

  /// Watch recent maintenance logs across all tanks (for dashboard)
  Stream<List<MaintenanceLog>> watchRecentMaintenanceLogs({int limit = 10}) =>
      (select(maintenanceLogs)
            ..orderBy([(m) => OrderingTerm.desc(m.performedAt)])
            ..limit(limit))
          .watch();

  /// Get recent water parameter logs across all tanks (for dashboard)
  Future<List<WaterParameter>> getRecentWaterParameters({int limit = 10}) =>
      (select(waterParameters)
            ..orderBy([(w) => OrderingTerm.desc(w.measuredAt)])
            ..limit(limit))
          .get();

  /// Watch recent water parameter logs across all tanks (for dashboard)
  Stream<List<WaterParameter>> watchRecentWaterParameters({int limit = 10}) =>
      (select(waterParameters)
            ..orderBy([(w) => OrderingTerm.desc(w.measuredAt)])
            ..limit(limit))
          .watch();

  // ============================================================
  // FeedingLogs operations
  // ============================================================

  /// Get all feeding logs for a tank (ordered by fedAt desc)
  Future<List<FeedingLog>> getFeedingLogsForTank(int tankId) =>
      (select(feedingLogs)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.desc(f.fedAt)]))
          .get();

  /// Watch all feeding logs for a tank
  Stream<List<FeedingLog>> watchFeedingLogsForTank(int tankId) =>
      (select(feedingLogs)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.desc(f.fedAt)]))
          .watch();

  /// Get feeding log by ID
  Future<FeedingLog?> getFeedingLogById(int id) =>
      (select(feedingLogs)..where((f) => f.id.equals(id))).getSingleOrNull();

  /// Get latest feeding log for a tank
  Future<FeedingLog?> getLatestFeedingLog(int tankId) =>
      (select(feedingLogs)
            ..where((f) => f.tankId.equals(tankId))
            ..orderBy([(f) => OrderingTerm.desc(f.fedAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Insert a new feeding log
  Future<int> insertFeedingLog(FeedingLogsCompanion log) =>
      into(feedingLogs).insert(log);

  /// Update a feeding log
  Future<bool> updateFeedingLog(FeedingLog log) =>
      update(feedingLogs).replace(log);

  /// Delete a feeding log
  Future<int> deleteFeedingLog(int id) =>
      (delete(feedingLogs)..where((f) => f.id.equals(id))).go();

  /// Delete all feeding logs for a tank
  Future<int> deleteFeedingLogsForTank(int tankId) =>
      (delete(feedingLogs)..where((f) => f.tankId.equals(tankId))).go();

  /// Get recent feeding logs across all tanks (for dashboard)
  Future<List<FeedingLog>> getRecentFeedingLogs({int limit = 10}) =>
      (select(feedingLogs)
            ..orderBy([(f) => OrderingTerm.desc(f.fedAt)])
            ..limit(limit))
          .get();

  /// Watch recent feeding logs across all tanks (for dashboard)
  Stream<List<FeedingLog>> watchRecentFeedingLogs({int limit = 10}) =>
      (select(feedingLogs)
            ..orderBy([(f) => OrderingTerm.desc(f.fedAt)])
            ..limit(limit))
          .watch();

  /// Get feeding logs for today for a tank
  Future<List<FeedingLog>> getTodaysFeedingLogs(int tankId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(feedingLogs)
          ..where(
            (f) =>
                f.tankId.equals(tankId) &
                f.fedAt.isBiggerOrEqualValue(startOfDay) &
                f.fedAt.isSmallerThanValue(endOfDay),
          )
          ..orderBy([(f) => OrderingTerm.desc(f.fedAt)]))
        .get();
  }

  // ============================================================
  // Plant Operations
  // ============================================================

  /// Get all plants for a tank
  Future<List<Plant>> getPlantsForTank(int tankId) =>
      (select(plants)
            ..where((p) => p.tankId.equals(tankId))
            ..orderBy([(p) => OrderingTerm.asc(p.species)]))
          .get();

  /// Watch all plants for a tank
  Stream<List<Plant>> watchPlantsForTank(int tankId) =>
      (select(plants)
            ..where((p) => p.tankId.equals(tankId))
            ..orderBy([(p) => OrderingTerm.asc(p.species)]))
          .watch();

  /// Get plant by ID
  Future<Plant?> getPlantById(int id) =>
      (select(plants)..where((p) => p.id.equals(id))).getSingleOrNull();

  /// Insert a new plant
  Future<int> insertPlant(PlantsCompanion plant) => into(plants).insert(plant);

  /// Update a plant
  Future<bool> updatePlant(Plant plant) => update(plants).replace(plant);

  /// Delete a plant
  Future<int> deletePlant(int id) =>
      (delete(plants)..where((p) => p.id.equals(id))).go();

  /// Delete all plants for a tank
  Future<int> deletePlantsForTank(int tankId) =>
      (delete(plants)..where((p) => p.tankId.equals(tankId))).go();

  /// Get active plant count for a tank
  Future<int> getActivePlantCount(int tankId) async {
    final result =
        await (selectOnly(plants)
              ..addColumns([plants.id.count()])
              ..where(
                plants.tankId.equals(tankId) & plants.dateRemoved.isNull(),
              ))
            .getSingle();
    return result.read(plants.id.count()) ?? 0;
  }

  // ============================================================
  // Tank Images Operations
  // ============================================================

  /// Get all images for a tank
  Future<List<TankImage>> getImagesForTank(int tankId) =>
      (select(tankImages)..where((i) => i.tankId.equals(tankId))).get();

  /// Watch all images for a tank
  Stream<List<TankImage>> watchImagesForTank(int tankId) =>
      (select(tankImages)
            ..where((i) => i.tankId.equals(tankId))
            ..orderBy([(i) => OrderingTerm.desc(i.createdAt)]))
          .watch();

  /// Get a single tank image by ID
  Future<TankImage?> getTankImageById(int id) =>
      (select(tankImages)..where((i) => i.id.equals(id))).getSingleOrNull();

  /// Get the cover image for a tank
  Future<TankImage?> getCoverImageForTank(int tankId) =>
      (select(tankImages)
            ..where((i) => i.tankId.equals(tankId) & i.isCover.equals(true)))
          .getSingleOrNull();

  /// Insert a new tank image
  Future<int> insertTankImage(TankImagesCompanion image) =>
      into(tankImages).insert(image);

  /// Update a tank image
  Future<bool> updateTankImage(TankImage image) =>
      update(tankImages).replace(image);

  /// Delete a tank image
  Future<int> deleteTankImage(int id) =>
      (delete(tankImages)..where((i) => i.id.equals(id))).go();

  /// Delete all images for a tank
  Future<int> deleteImagesForTank(int tankId) =>
      (delete(tankImages)..where((i) => i.tankId.equals(tankId))).go();

  /// Set an image as the cover image (and unset others)
  Future<void> setCoverImage(int tankId, int imageId) async {
    await transaction(() async {
      // Unset all cover images for this tank
      await (update(tankImages)..where((i) => i.tankId.equals(tankId))).write(
        const TankImagesCompanion(isCover: Value(false)),
      );
      // Set the specified image as cover
      await (update(tankImages)..where((i) => i.id.equals(imageId))).write(
        const TankImagesCompanion(isCover: Value(true)),
      );
    });
  }

  /// Get image count for a tank
  Future<int> getImageCountForTank(int tankId) async {
    final result =
        await (selectOnly(tankImages)
              ..addColumns([tankImages.id.count()])
              ..where(tankImages.tankId.equals(tankId)))
            .getSingle();
    return result.read(tankImages.id.count()) ?? 0;
  }

  // ============================================================
  // Glass Calculations Operations
  // ============================================================

  /// Get all glass calculations
  Future<List<GlassCalculation>> getAllGlassCalculations() {
    return (select(
      glassCalculations,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  /// Watch all glass calculations
  Stream<List<GlassCalculation>> watchAllGlassCalculations() {
    return (select(
      glassCalculations,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  /// Get a glass calculation by ID
  Future<GlassCalculation?> getGlassCalculationById(int id) {
    return (select(
      glassCalculations,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Insert a new glass calculation
  Future<int> insertGlassCalculation(GlassCalculationsCompanion calculation) {
    return into(glassCalculations).insert(calculation);
  }

  /// Update a glass calculation
  Future<bool> updateGlassCalculation(GlassCalculation calculation) {
    return update(glassCalculations).replace(calculation);
  }

  /// Delete a glass calculation
  Future<int> deleteGlassCalculation(int id) {
    return (delete(glassCalculations)..where((t) => t.id.equals(id))).go();
  }
}
