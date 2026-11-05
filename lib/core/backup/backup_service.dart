import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';
import '../settings/settings_repository.dart';
import '../storage/local_storage.dart';

/// Thrown when a backup file can't be created or restored
class BackupException implements Exception {
  final String message;
  const BackupException(this.message);

  @override
  String toString() => message;
}

/// Result of a successful restore
class RestoreSummary {
  final int tanks;
  final int images;
  final DateTime? backupCreatedAt;

  const RestoreSummary({
    required this.tanks,
    required this.images,
    this.backupCreatedAt,
  });
}

/// Creates and restores full-data backups as a single .zip file.
///
/// Archive layout:
/// - `manifest.json`      format version, schema version, timestamp, settings
/// - `aqualog_db.sqlite`  consistent snapshot of the Drift database
/// - `tank_images/...`    tank photos, same layout as in app documents
class BackupService {
  BackupService(this._db, this._storage);

  final AppDatabase _db;
  final LocalStorage _storage;

  static const int formatVersion = 1;
  static const String _manifestName = 'manifest.json';
  static const String _dbName = 'aqualog_db.sqlite';
  static const String _imagesDirName = 'tank_images';
  static const String _autoBackupDirName = 'auto_backups';

  /// Create a backup zip in the temporary directory and return it
  Future<File> createBackup() async {
    final tmp = await getTemporaryDirectory();
    final stamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final zipPath = '${tmp.path}/TankMind-backup-$stamp.zip';
    await _writeBackup(zipPath);
    return File(zipPath);
  }

  /// Restore all data from a backup zip, replacing current data.
  ///
  /// The current data is saved to `auto_backups/pre_restore.zip` first.
  Future<RestoreSummary> restoreBackup(File zipFile) async {
    final docs = await getApplicationDocumentsDirectory();
    final tmp = await getTemporaryDirectory();
    final work = Directory(
      '${tmp.path}/restore_${DateTime.now().millisecondsSinceEpoch}',
    );

    try {
      await extractFileToDisk(zipFile.path, work.path);
    } catch (_) {
      throw const BackupException('This file is not a valid TankMind backup.');
    }

    try {
      final manifest = await _readManifest(work);
      final backupSchema = manifest['schemaVersion'] as int? ?? 0;
      if (backupSchema > _db.schemaVersion) {
        throw const BackupException(
          'This backup was made by a newer version of TankMind. '
          'Update the app and try again.',
        );
      }

      final backupDb = File('${work.path}/$_dbName');
      if (!await backupDb.exists()) {
        throw const BackupException('The backup has no database in it.');
      }

      // Safety net: keep a copy of what we're about to replace
      final autoDir = Directory('${docs.path}/$_autoBackupDirName');
      await autoDir.create(recursive: true);
      await _writeBackup('${autoDir.path}/pre_restore.zip');

      // Bring an older backup up to the current schema. It's a separate
      // file, so drift's multiple-instance warning doesn't apply here.
      final warned = driftRuntimeOptions.dontWarnAboutMultipleDatabases;
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      final migrated = AppDatabase(NativeDatabase(backupDb));
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = warned;
      await migrated.customSelect('SELECT 1').get();
      await migrated.close();

      // Stage images next to the live folder so the swap is quick
      final liveImages = Directory('${docs.path}/$_imagesDirName');
      final stagedImages = Directory(
        '${docs.path}/${_imagesDirName}_restoring',
      );
      if (await stagedImages.exists()) {
        await stagedImages.delete(recursive: true);
      }
      final backupImages = Directory('${work.path}/$_imagesDirName');
      if (await backupImages.exists()) {
        await _copyDirectory(backupImages, stagedImages);
      } else {
        await stagedImages.create(recursive: true);
      }

      await _replaceDatabaseContents(backupDb.path, docs.path);

      if (await liveImages.exists()) {
        await liveImages.delete(recursive: true);
      }
      await stagedImages.rename(liveImages.path);

      final settingsJson = manifest['settings'] as String?;
      if (settingsJson != null) {
        await _storage.initialize();
        await _storage.setString(SettingsKeys.settings, settingsJson);
      }

      final tanks = await _count('tanks');
      final images = await _count('tank_images');
      final createdAt = DateTime.tryParse(
        manifest['createdAt'] as String? ?? '',
      );
      return RestoreSummary(
        tanks: tanks,
        images: images,
        backupCreatedAt: createdAt,
      );
    } finally {
      if (await work.exists()) {
        await work.delete(recursive: true);
      }
    }
  }

  Future<void> _writeBackup(String zipPath) async {
    final docs = await getApplicationDocumentsDirectory();
    final tmp = await getTemporaryDirectory();
    final staging = Directory(
      '${tmp.path}/backup_${DateTime.now().millisecondsSinceEpoch}',
    );
    await staging.create(recursive: true);

    try {
      // VACUUM INTO gives a consistent single-file copy even in WAL mode
      final dbCopy = File('${staging.path}/$_dbName');
      await _db.customStatement('VACUUM INTO ?', [dbCopy.path]);

      await _storage.initialize();
      final manifest = File('${staging.path}/$_manifestName');
      await manifest.writeAsString(
        jsonEncode({
          'app': 'aqualog',
          'format': formatVersion,
          'schemaVersion': _db.schemaVersion,
          'createdAt': DateTime.now().toIso8601String(),
          'settings': _storage.getString(SettingsKeys.settings),
        }),
      );

      final zipFile = File(zipPath);
      if (await zipFile.exists()) {
        await zipFile.delete();
      }

      final encoder = ZipFileEncoder()..create(zipPath);
      await encoder.addFile(manifest, _manifestName);
      await encoder.addFile(dbCopy, _dbName);
      final images = Directory('${docs.path}/$_imagesDirName');
      if (await images.exists()) {
        await encoder.addDirectory(images);
      }
      await encoder.close();
    } catch (e) {
      if (e is BackupException) rethrow;
      throw BackupException('Could not create the backup: $e');
    } finally {
      await staging.delete(recursive: true);
    }
  }

  Future<Map<String, dynamic>> _readManifest(Directory work) async {
    final file = File('${work.path}/$_manifestName');
    if (!await file.exists()) {
      throw const BackupException('This file is not a TankMind backup.');
    }
    final manifest = jsonDecode(await file.readAsString());
    if (manifest is! Map<String, dynamic> || manifest['app'] != 'aqualog') {
      throw const BackupException('This file is not a TankMind backup.');
    }
    return manifest;
  }

  /// Replace every table's rows with the rows from the backup database
  Future<void> _replaceDatabaseContents(
    String backupPath,
    String docsPath,
  ) async {
    await _db.customStatement('PRAGMA foreign_keys = OFF');
    await _db.customStatement('ATTACH DATABASE ? AS bak', [backupPath]);
    try {
      await _db.transaction(() async {
        for (final table in _db.allTables) {
          final name = table.actualTableName;
          final columns = table.$columns.map((c) => '"${c.name}"').join(', ');
          await _db.customStatement('DELETE FROM main."$name"');
          await _db.customStatement(
            'INSERT INTO main."$name" ($columns) '
            'SELECT $columns FROM bak."$name"',
          );
        }

        // Photos are stored with absolute paths; point them at this install
        await _db.customStatement(
          "UPDATE tank_images SET image_path = ? || "
          "substr(image_path, instr(image_path, '/$_imagesDirName/')) "
          "WHERE instr(image_path, '/$_imagesDirName/') > 0",
          [docsPath],
        );
      });
    } finally {
      await _db.customStatement('DETACH DATABASE bak');
      await _db.customStatement('PRAGMA foreign_keys = ON');
    }
    _db.markTablesUpdated(_db.allTables);
  }

  Future<int> _count(String table) async {
    final row = await _db
        .customSelect('SELECT COUNT(*) AS c FROM $table')
        .getSingle();
    return row.read<int>('c');
  }

  Future<void> _copyDirectory(Directory source, Directory target) async {
    await target.create(recursive: true);
    await for (final entity in source.list(recursive: false)) {
      final name = entity.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
      if (entity is Directory) {
        await _copyDirectory(entity, Directory('${target.path}/$name'));
      } else if (entity is File) {
        await entity.copy('${target.path}/$name');
      }
    }
  }
}
