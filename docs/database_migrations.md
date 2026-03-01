# Database Migrations Guide

This document describes how to manage database schema changes in Aqualog using Drift migrations.

## Overview

Aqualog uses [Drift](https://drift.simonbinder.eu/) (SQLite) for local data persistence. When the database schema changes, migrations ensure existing user data is preserved and transformed to match the new schema.

## Current Schema Version

The current schema version is defined in `lib/core/database/app_database.dart`:

```dart
@override
int get schemaVersion => 1;
```

## Adding a New Migration

### Step 1: Make Schema Changes

Modify the table definitions in `lib/core/database/tables/`:

```dart
// Example: Adding a new column to tanks_table.dart
class Tanks extends Table {
  // ... existing columns ...
  TextColumn get newColumn => text().nullable()();  // New column
}
```

### Step 2: Increment Schema Version

In `lib/core/database/app_database.dart`, increment `schemaVersion`:

```dart
@override
int get schemaVersion => 2;  // Was 1, now 2
```

### Step 3: Add Migration Logic

In `lib/core/database/migrations.dart`, add your migration:

```dart
static Future<void> _runMigration(
  Migrator migrator,
  AppDatabase db,
  int targetVersion,
) async {
  switch (targetVersion) {
    case 2:
      await _migrateV1ToV2(migrator, db);
      break;
    // ... other cases ...
  }
}

static Future<void> _migrateV1ToV2(Migrator m, AppDatabase db) async {
  // Add new column
  await m.addColumn(db.tanks, db.tanks.newColumn);
}
```

### Step 4: Regenerate Code

Run the build runner to regenerate Drift code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 5: Document the Change

Update the version history in `app_database.dart`:

```dart
/// ## Schema Version History:
/// - v1: Initial schema with all base tables
/// - v2: Added newColumn to tanks table
```

## Common Migration Patterns

### Adding a Column

```dart
await m.addColumn(db.tanks, db.tanks.newColumn);
```

### Adding a Column with Default Value (Safe)

```dart
await db.addColumnIfNotExists(
  'tanks',
  'new_column',
  'TEXT',
  defaultValue: "'default_value'",
);
```

### Creating a New Table

```dart
await m.createTable(db.newTable);
```

### Dropping a Table

```dart
await m.deleteTable('old_table_name');
```

### Renaming a Column (Raw SQL)

```dart
await db.customStatement(
  'ALTER TABLE tanks RENAME COLUMN old_name TO new_name',
);
```

### Adding an Index

```dart
await db.customStatement(
  'CREATE INDEX idx_tanks_name ON tanks(name)',
);
```

### Data Migration

```dart
// Copy data from old structure to new
final oldData = await db.customSelect('SELECT * FROM old_table').get();
for (final row in oldData) {
  await db.into(db.newTable).insert(
    NewTableCompanion.insert(
      field: row.read<String>('old_field'),
    ),
  );
}
```

## Helper Methods

The `MigrationHelpers` extension on `AppDatabase` provides utilities:

| Method | Description |
|--------|-------------|
| `addColumnIfNotExists()` | Safely adds a column only if it doesn't exist |
| `tableExists()` | Checks if a table exists in the database |
| `getCurrentSchemaVersion()` | Returns the current schema version |
| `createBackup()` | Placeholder for backup functionality |

## Best Practices

1. **Test migrations thoroughly** - Test on a copy of production data before release
2. **Keep migrations idempotent** - Use helpers like `addColumnIfNotExists()`
3. **Never delete old migrations** - Users may upgrade from very old versions
4. **Document every change** - Update the version history
5. **Make columns nullable or provide defaults** - Required for existing rows
6. **Backup before migration** - Consider implementing automatic backups

## Testing Migrations

```dart
// In your test file
test('migration from v1 to v2 works', () async {
  // Create a v1 database with test data
  final db = AppDatabase(NativeDatabase.memory());
  
  // Insert test data in v1 format
  await db.into(db.tanks).insert(...);
  
  // Close and reopen with v2 schema
  await db.close();
  
  // Verify data migrated correctly
  final tanks = await db.select(db.tanks).get();
  expect(tanks.first.newColumn, isNotNull);
});
```

## Troubleshooting

### Migration Failed

If a migration fails:
1. Check the error logs for the specific SQL error
2. Ensure column types match between old and new schema
3. Verify foreign key constraints are satisfied

### Schema Mismatch

If the schema doesn't match after migration:
1. Verify `schemaVersion` is incremented correctly
2. Check that all migration steps are registered in the switch statement
3. Run `build_runner` to regenerate Drift code

