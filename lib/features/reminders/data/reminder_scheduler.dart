import 'dart:convert';

import '../../../core/notifications/local_notification_service.dart';
import '../domain/entities/reminder.dart';

/// Reminder scheduler for managing notification scheduling
///
/// This class handles scheduling and canceling notifications for reminders.
/// It uses the singleton pattern to ensure only one instance exists.
class ReminderScheduler {
  static ReminderScheduler? _instance;
  final LocalNotificationService _notificationService;

  ReminderScheduler._(this._notificationService);

  static ReminderScheduler get instance {
    _instance ??= ReminderScheduler._(LocalNotificationService.instance);
    return _instance!;
  }

  /// For testing - allows injecting a mock notification service
  static void setInstance(ReminderScheduler scheduler) {
    _instance = scheduler;
  }

  /// Schedule a notification for a reminder
  ///
  /// For one-time reminders, schedules a single notification.
  /// For recurring reminders, schedules the next occurrence.
  /// The notification will be rescheduled when completed via the repository.
  Future<void> scheduleReminder(ReminderEntity reminder) async {
    if (reminder.id == null) return;
    if (!reminder.isEnabled) return;
    if (reminder.isCompleted &&
        reminder.repeatFrequency == RepeatFrequency.none) {
      return;
    }

    final scheduledAt = reminder.nextDueAt;

    // Don't schedule if the time has already passed
    if (scheduledAt.isBefore(DateTime.now())) return;

    // Create payload with reminder info for handling notification taps
    final payload = jsonEncode({
      'type': 'reminder',
      'reminderId': reminder.id,
      'tankId': reminder.tankId,
      'reminderType': reminder.reminderType.name,
    });

    await _notificationService.scheduleNotification(
      id: reminder.id!,
      title: _getNotificationTitle(reminder),
      body: _getNotificationBody(reminder),
      scheduledDate: scheduledAt,
      payload: payload,
      channel: NotificationChannel.reminders,
    );
  }

  /// Cancel a scheduled notification for a reminder
  Future<void> cancelReminder(int reminderId) async {
    await _notificationService.cancelNotification(reminderId);
  }

  /// Reschedule all enabled reminders
  ///
  /// This should be called on app startup to ensure all reminders
  /// have their notifications scheduled.
  Future<void> rescheduleAllReminders(List<ReminderEntity> reminders) async {
    // First cancel all existing reminder notifications
    for (final reminder in reminders) {
      if (reminder.id != null) {
        await cancelReminder(reminder.id!);
      }
    }

    // Then schedule enabled reminders
    for (final reminder in reminders) {
      if (reminder.isEnabled) {
        await scheduleReminder(reminder);
      }
    }
  }

  /// Calculate the next due date for a reminder
  /// Note: This is now a computed property on ReminderEntity (nextDueAt)
  /// This method is kept for backward compatibility
  DateTime calculateNextDue(ReminderEntity reminder) {
    return reminder.nextDueAt;
  }

  /// Get the notification title based on reminder type
  String _getNotificationTitle(ReminderEntity reminder) {
    return '${reminder.reminderType.icon} ${reminder.title}';
  }

  /// Get the notification body based on reminder
  String _getNotificationBody(ReminderEntity reminder) {
    if (reminder.description != null && reminder.description!.isNotEmpty) {
      return reminder.description!;
    }

    // Default body based on reminder type
    switch (reminder.reminderType) {
      case ReminderType.waterChange:
        return 'Time for a water change!';
      case ReminderType.feeding:
        return 'Time to feed your fish!';
      case ReminderType.fertilizing:
        return 'Time to add fertilizer!';
      case ReminderType.cleaning:
        return 'Time for tank cleaning!';
      case ReminderType.maintenance:
        return 'Scheduled maintenance reminder';
      case ReminderType.waterTest:
        return 'Time to test your water parameters!';
      case ReminderType.medicationDose:
        return 'Time for medication dose!';
      case ReminderType.custom:
        return 'You have a reminder';
    }
  }

  /// Get pending reminder notifications
  Future<List<int>> getPendingReminderIds() async {
    final pending = await _notificationService.getPendingNotifications();
    return pending.map((n) => n.id).toList();
  }
}
