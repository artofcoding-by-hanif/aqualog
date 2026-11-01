import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_provider.dart';
import '../settings/settings_provider.dart';
import 'backup_service.dart';

/// Provider for the backup/restore service
final backupServiceProvider = Provider<BackupService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final storage = ref.watch(localStorageProvider);
  return BackupService(db, storage);
});
