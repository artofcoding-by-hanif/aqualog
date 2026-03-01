import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

/// Background task identifiers
class BackgroundTaskIds {
  BackgroundTaskIds._();

  /// Reschedule notifications after device restart
  static const rescheduleNotifications = 'rescheduleNotifications';

  /// Periodic reminder check
  static const checkReminders = 'checkReminders';

  /// Sync data in background (future use)
  static const syncData = 'syncData';

  /// Clean up old data
  static const cleanupOldData = 'cleanupOldData';
}

/// Background task dispatcher - must be a top-level function
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    debugPrint('Background task executing: $taskName');

    try {
      switch (taskName) {
        case BackgroundTaskIds.rescheduleNotifications:
          await _handleRescheduleNotifications();
          break;
        case BackgroundTaskIds.checkReminders:
          await _handleCheckReminders();
          break;
        case BackgroundTaskIds.syncData:
          await _handleSyncData();
          break;
        case BackgroundTaskIds.cleanupOldData:
          await _handleCleanupOldData();
          break;
        case Workmanager.iOSBackgroundTask:
          // iOS background fetch
          await _handleIOSBackgroundFetch();
          break;
        default:
          debugPrint('Unknown background task: $taskName');
      }
      return true;
    } catch (e, stack) {
      debugPrint('Background task failed: $e\n$stack');
      return false;
    }
  });
}

// Task handlers
Future<void> _handleRescheduleNotifications() async {
  // This will be called after device restart to reschedule notifications
  // Implementation will be added when reminder system is complete
  debugPrint('Rescheduling notifications...');
}

Future<void> _handleCheckReminders() async {
  // Check for due reminders and show notifications
  debugPrint('Checking reminders...');
}

Future<void> _handleSyncData() async {
  // Sync data with cloud (future feature)
  debugPrint('Syncing data...');
}

Future<void> _handleCleanupOldData() async {
  // Clean up old logs, temporary data, etc.
  debugPrint('Cleaning up old data...');
}

Future<void> _handleIOSBackgroundFetch() async {
  // Handle iOS background fetch
  await _handleCheckReminders();
}

/// Background task service for managing Workmanager tasks
class BackgroundTaskService {
  static BackgroundTaskService? _instance;
  bool _isInitialized = false;

  BackgroundTaskService._();

  static BackgroundTaskService get instance {
    _instance ??= BackgroundTaskService._();
    return _instance!;
  }

  bool get isInitialized => _isInitialized;

  /// Initialize Workmanager
  Future<void> initialize() async {
    if (_isInitialized) return;

    await Workmanager().initialize(callbackDispatcher);

    _isInitialized = true;
    debugPrint('BackgroundTaskService initialized');
  }

  /// Register periodic reminder check task
  Future<void> registerPeriodicReminderCheck() async {
    await _ensureInitialized();

    if (Platform.isAndroid) {
      await Workmanager().registerPeriodicTask(
        BackgroundTaskIds.checkReminders,
        BackgroundTaskIds.checkReminders,
        frequency: const Duration(hours: 1),
        constraints: Constraints(
          networkType: NetworkType.notRequired,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false,
        ),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      );
    }
  }

  /// Register one-time task to reschedule notifications
  Future<void> registerRescheduleNotifications() async {
    await _ensureInitialized();

    await Workmanager().registerOneOffTask(
      BackgroundTaskIds.rescheduleNotifications,
      BackgroundTaskIds.rescheduleNotifications,
      constraints: Constraints(networkType: NetworkType.notRequired),
    );
  }

  /// Register periodic cleanup task
  Future<void> registerPeriodicCleanup() async {
    await _ensureInitialized();

    if (Platform.isAndroid) {
      await Workmanager().registerPeriodicTask(
        BackgroundTaskIds.cleanupOldData,
        BackgroundTaskIds.cleanupOldData,
        frequency: const Duration(days: 1),
        constraints: Constraints(
          networkType: NetworkType.notRequired,
          requiresBatteryNotLow: true,
          requiresCharging: true,
          requiresDeviceIdle: true,
        ),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      );
    }
  }

  /// Cancel all registered tasks
  Future<void> cancelAllTasks() async {
    await Workmanager().cancelAll();
    debugPrint('All background tasks cancelled');
  }

  /// Cancel a specific task
  Future<void> cancelTask(String taskId) async {
    await Workmanager().cancelByUniqueName(taskId);
    debugPrint('Background task cancelled: $taskId');
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }
}
