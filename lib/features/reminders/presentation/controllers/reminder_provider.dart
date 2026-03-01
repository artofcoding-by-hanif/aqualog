import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database_provider.dart'
    hide ReminderType, RepeatFrequency;
import '../../data/reminder_scheduler.dart';
import '../../data/repositories/reminder_repository_impl.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/repositories/reminder_repository.dart';

part 'reminder_provider.g.dart';

/// Provider for ReminderRepository
@Riverpod(keepAlive: true)
ReminderRepository reminderRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ReminderRepositoryImpl(database: db);
}

/// Provider for ReminderScheduler
@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) {
  return ReminderScheduler.instance;
}

/// Provider to watch all reminders
@Riverpod(keepAlive: true)
Stream<List<ReminderEntity>> remindersStream(Ref ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return repo.watchAllReminders();
}

/// Provider to watch reminders for a specific tank
@Riverpod(keepAlive: true)
Stream<List<ReminderEntity>> remindersForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(reminderRepositoryProvider);
  return repo.watchRemindersForTank(tankId);
}

/// Provider to get a reminder by ID
@riverpod
Future<ReminderEntity?> reminderById(Ref ref, int id) async {
  final repo = ref.watch(reminderRepositoryProvider);
  return repo.getReminderById(id);
}

/// Provider to get overdue reminders
@riverpod
Future<List<ReminderEntity>> overdueReminders(Ref ref) async {
  final repo = ref.watch(reminderRepositoryProvider);
  return repo.getOverdueReminders();
}

/// Provider to get upcoming reminders
@riverpod
Future<List<ReminderEntity>> upcomingReminders(Ref ref, int withinDays) async {
  final repo = ref.watch(reminderRepositoryProvider);
  return repo.getUpcomingReminders(withinDays);
}

/// Notifier for managing reminder operations with notification scheduling
@Riverpod(keepAlive: true)
class ReminderNotifier extends _$ReminderNotifier {
  @override
  Future<List<ReminderEntity>> build() async {
    final repo = ref.watch(reminderRepositoryProvider);
    return repo.getAllReminders();
  }

  ReminderRepository get _repo => ref.read(reminderRepositoryProvider);
  ReminderScheduler get _scheduler => ref.read(reminderSchedulerProvider);

  /// Add a new reminder and schedule notification
  Future<int> addReminder(ReminderEntity reminder) async {
    final id = await _repo.addReminder(reminder);
    // Schedule notification for the new reminder
    final savedReminder = await _repo.getReminderById(id);
    if (savedReminder != null) {
      await _scheduler.scheduleReminder(savedReminder);
    }
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing reminder and reschedule notification
  Future<void> updateReminder(ReminderEntity reminder) async {
    await _repo.updateReminder(reminder);
    // Cancel old notification and schedule new one
    if (reminder.id != null) {
      await _scheduler.cancelReminder(reminder.id!);
      if (reminder.isEnabled) {
        await _scheduler.scheduleReminder(reminder);
      }
    }
    ref.invalidateSelf();
  }

  /// Delete a reminder and cancel its notification
  Future<void> deleteReminder(int id) async {
    await _scheduler.cancelReminder(id);
    await _repo.deleteReminder(id);
    ref.invalidateSelf();
  }

  /// Complete a reminder and reschedule if recurring
  Future<void> completeReminder(int reminderId) async {
    await _scheduler.cancelReminder(reminderId);
    await _repo.completeReminder(reminderId);
    // For recurring reminders, schedule the next occurrence
    final reminder = await _repo.getReminderById(reminderId);
    if (reminder != null && reminder.repeatFrequency != RepeatFrequency.none) {
      await _scheduler.scheduleReminder(reminder);
    }
    ref.invalidateSelf();
  }

  /// Toggle reminder enabled status and update notification
  Future<void> toggleReminderEnabled(int reminderId, bool isEnabled) async {
    await _repo.toggleReminderEnabled(reminderId, isEnabled);
    if (isEnabled) {
      final reminder = await _repo.getReminderById(reminderId);
      if (reminder != null) {
        await _scheduler.scheduleReminder(reminder);
      }
    } else {
      await _scheduler.cancelReminder(reminderId);
    }
    ref.invalidateSelf();
  }

  /// Snooze a reminder and reschedule notification
  Future<void> snoozeReminder(int reminderId, Duration duration) async {
    await _scheduler.cancelReminder(reminderId);
    await _repo.snoozeReminder(reminderId, duration);
    final reminder = await _repo.getReminderById(reminderId);
    if (reminder != null) {
      await _scheduler.scheduleReminder(reminder);
    }
    ref.invalidateSelf();
  }

  /// Reschedule all reminder notifications (call on app startup)
  Future<void> rescheduleAllNotifications() async {
    final reminders = await _repo.getAllReminders();
    await _scheduler.rescheduleAllReminders(reminders);
  }
}

/// Notifier for managing reminders for a specific tank with notification scheduling
@Riverpod(keepAlive: true)
class TankReminderNotifier extends _$TankReminderNotifier {
  @override
  Future<List<ReminderEntity>> build(int tankId) async {
    final repo = ref.watch(reminderRepositoryProvider);
    return repo.getRemindersForTank(tankId);
  }

  ReminderRepository get _repo => ref.read(reminderRepositoryProvider);
  ReminderScheduler get _scheduler => ref.read(reminderSchedulerProvider);

  /// Add a new reminder for this tank and schedule notification
  Future<int> addReminder(ReminderEntity reminder) async {
    final id = await _repo.addReminder(reminder);
    final savedReminder = await _repo.getReminderById(id);
    if (savedReminder != null) {
      await _scheduler.scheduleReminder(savedReminder);
    }
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing reminder and reschedule notification
  Future<void> updateReminder(ReminderEntity reminder) async {
    await _repo.updateReminder(reminder);
    if (reminder.id != null) {
      await _scheduler.cancelReminder(reminder.id!);
      if (reminder.isEnabled) {
        await _scheduler.scheduleReminder(reminder);
      }
    }
    ref.invalidateSelf();
  }

  /// Delete a reminder and cancel its notification
  Future<void> deleteReminder(int id) async {
    await _scheduler.cancelReminder(id);
    await _repo.deleteReminder(id);
    ref.invalidateSelf();
  }

  /// Complete a reminder and reschedule if recurring
  Future<void> completeReminder(int reminderId) async {
    await _scheduler.cancelReminder(reminderId);
    await _repo.completeReminder(reminderId);
    final reminder = await _repo.getReminderById(reminderId);
    if (reminder != null && reminder.repeatFrequency != RepeatFrequency.none) {
      await _scheduler.scheduleReminder(reminder);
    }
    ref.invalidateSelf();
  }

  /// Toggle reminder enabled status and update notification
  Future<void> toggleReminderEnabled(int reminderId, bool isEnabled) async {
    await _repo.toggleReminderEnabled(reminderId, isEnabled);
    if (isEnabled) {
      final reminder = await _repo.getReminderById(reminderId);
      if (reminder != null) {
        await _scheduler.scheduleReminder(reminder);
      }
    } else {
      await _scheduler.cancelReminder(reminderId);
    }
    ref.invalidateSelf();
  }

  /// Snooze a reminder and reschedule notification
  Future<void> snoozeReminder(int reminderId, Duration duration) async {
    await _scheduler.cancelReminder(reminderId);
    await _repo.snoozeReminder(reminderId, duration);
    final reminder = await _repo.getReminderById(reminderId);
    if (reminder != null) {
      await _scheduler.scheduleReminder(reminder);
    }
    ref.invalidateSelf();
  }
}
