import 'package:drift/drift.dart';

import 'app_database.dart';

/// Database migration strategy for Aqualog
///
/// ## How to add a new migration:
///
/// 1. Increment `schemaVersion` in `AppDatabase`
/// 2. Add a new migration method in this class (e.g., `_migrateV2ToV3`)
/// 3. Register the migration in `runMigrations` method
/// 4. Run `dart run build_runner build` to regenerate database code
///
/// ## Best Practices:
///
/// - Always test migrations on a copy of production data
/// - Keep migrations idempotent when possible
/// - Document what each migration does
/// - Never remove old migrations - they may be needed for users
///   upgrading from very old versions
class DatabaseMigrations {
  DatabaseMigrations._();

  /// Run all necessary migrations from [from] version to [to] version
  static Future<void> runMigrations(
    Migrator migrator,
    AppDatabase db,
    int from,
    int to,
  ) async {
    // Run migrations sequentially
    for (var version = from + 1; version <= to; version++) {
      await _runMigration(migrator, db, version);
    }
  }

  /// Run a specific migration to target version
  static Future<void> _runMigration(
    Migrator migrator,
    AppDatabase db,
    int targetVersion,
  ) async {
    switch (targetVersion) {
      case 2:
        await _migrateV1ToV2(migrator, db);
        break;
      case 3:
        await _migrateV2ToV3(migrator, db);
        break;
      case 4:
        await _migrateV3ToV4(migrator, db);
        break;
      case 5:
        await _migrateV4ToV5(migrator, db);
        break;
      case 6:
        await _migrateV5ToV6(migrator, db);
        break;
      case 7:
        await _migrateV6ToV7(migrator, db);
        break;
      case 8:
        await _migrateV7ToV8(migrator, db);
        break;
      case 9:
        await _migrateV8ToV9(migrator, db);
        break;
      case 10:
        await _migrateV9ToV10(migrator, db);
        break;
      case 11:
        await _migrateV10ToV11(migrator, db);
        break;
      case 12:
        await _migrateV11ToV12(migrator, db);
        break;
      case 13:
        await _migrateV12ToV13(migrator, db);
        break;
      // Add future migrations here
      default:
        // No migration needed or unknown version
        break;
    }
  }

  // ============================================================
  // Migration: Version 1 -> 2
  // ============================================================
  // Add Filters table for equipment/filtration feature
  static Future<void> _migrateV1ToV2(Migrator m, AppDatabase db) async {
    // Create the Filters table
    await m.createTable(db.filters);
  }

  // ============================================================
  // Migration: Version 2 -> 3
  // ============================================================
  // Add filterId column to Reminders table for filter-linked reminders
  static Future<void> _migrateV2ToV3(Migrator m, AppDatabase db) async {
    // Add filterId column to reminders table
    await db.addColumnIfNotExists('reminders', 'filter_id', 'INTEGER');
  }

  // ============================================================
  // Migration: Version 3 -> 4
  // ============================================================
  // Add Lightings table for equipment/lighting feature
  static Future<void> _migrateV3ToV4(Migrator m, AppDatabase db) async {
    // Create the Lightings table
    await m.createTable(db.lightings);
  }

  // ============================================================
  // Migration: Version 4 -> 5
  // ============================================================
  // Add Fish table for livestock/fish feature
  static Future<void> _migrateV4ToV5(Migrator m, AppDatabase db) async {
    // Create the Fish table
    await m.createTable(db.fish);
  }

  // ============================================================
  // Migration: Version 5 -> 6
  // ============================================================
  // Add Invertebrates table for livestock/invertebrates feature
  static Future<void> _migrateV5ToV6(Migrator m, AppDatabase db) async {
    // Create the Invertebrates table
    await m.createTable(db.invertebrates);
  }

  // ============================================================
  // Migration: Version 6 -> 7
  // ============================================================
  // Add Rocks and Driftwoods tables for hardscape feature
  static Future<void> _migrateV6ToV7(Migrator m, AppDatabase db) async {
    // Create the Rocks table
    await m.createTable(db.rocks);
    // Create the Driftwoods table
    await m.createTable(db.driftwoods);
  }

  // ============================================================
  // Migration: Version 7 -> 8
  // ============================================================
  // Add SubstrateLayers table for substrate feature
  static Future<void> _migrateV7ToV8(Migrator m, AppDatabase db) async {
    // Create the SubstrateLayers table
    await m.createTable(db.substrateLayers);
  }

  // ============================================================
  // Migration: Version 8 -> 9
  // ============================================================
  // Add FeedingLogs table for feeding log feature
  static Future<void> _migrateV8ToV9(Migrator m, AppDatabase db) async {
    // Create the FeedingLogs table
    await m.createTable(db.feedingLogs);
  }

  // ============================================================
  // Migration: Version 9 -> 10
  // ============================================================
  // Add foodType column to Reminders table for feeding reminders
  static Future<void> _migrateV9ToV10(Migrator m, AppDatabase db) async {
    // Add foodType column to reminders table (nullable INTEGER for enum)
    await db.addColumnIfNotExists('reminders', 'food_type', 'INTEGER');
  }

  // ============================================================
  // Migration: Version 10 -> 11
  // ============================================================
  // Add Plants table for plants feature
  static Future<void> _migrateV10ToV11(Migrator m, AppDatabase db) async {
    // Create the Plants table
    await m.createTable(db.plants);
  }

  // ============================================================
  // Migration: Version 11 -> 12
  // ============================================================
  // Add TankImages table for tank photo gallery
  static Future<void> _migrateV11ToV12(Migrator m, AppDatabase db) async {
    // Create the TankImages table
    await m.createTable(db.tankImages);
  }

  // ============================================================
  // Migration: Version 12 -> 13
  // ============================================================
  // Add GlassCalculations table for glass calculator feature
  static Future<void> _migrateV12ToV13(Migrator m, AppDatabase db) async {
    // Create the GlassCalculations table
    await m.createTable(db.glassCalculations);
  }
}

/// Extension to help with common migration patterns
extension MigrationHelpers on AppDatabase {
  /// Safely add a column if it doesn't exist
  Future<void> addColumnIfNotExists(
    String tableName,
    String columnName,
    String columnType, {
    String? defaultValue,
  }) async {
    // Check if column exists
    final result = await customSelect("PRAGMA table_info($tableName)").get();

    final columnExists = result.any(
      (row) => row.read<String>('name') == columnName,
    );

    if (!columnExists) {
      final defaultClause = defaultValue != null
          ? ' DEFAULT $defaultValue'
          : '';
      await customStatement(
        'ALTER TABLE $tableName ADD COLUMN $columnName $columnType$defaultClause',
      );
    }
  }

  /// Check if a table exists
  Future<bool> tableExists(String tableName) async {
    final result = await customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      variables: [Variable.withString(tableName)],
    ).get();
    return result.isNotEmpty;
  }

  /// Get the current schema version from the database
  Future<int> getCurrentSchemaVersion() async {
    final result = await customSelect('PRAGMA user_version').getSingle();
    return result.read<int>('user_version');
  }

  /// Backup the database before migration (returns backup path)
  Future<String?> createBackup() async {
    // This is a placeholder - actual implementation would depend on
    // your backup strategy (local copy, cloud backup, etc.)
    return null;
  }
}
