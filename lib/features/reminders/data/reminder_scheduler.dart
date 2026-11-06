import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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

  @visibleForTesting
  ReminderScheduler.forTesting(this._notificationService);

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
  /// Upcoming reminders fire at their due time; overdue ones fire at the
  /// next occurrence of their time of day. Either way the notification then
  /// repeats daily until the reminder is completed (completing cancels and
  /// reschedules it), so a missed reminder keeps nudging instead of going
  /// silent.
  Future<void> scheduleReminder(
    ReminderEntity reminder, {
    DateTime? now,
  }) async {
    if (reminder.id == null) return;
    if (!reminder.isEnabled) return;
    if (reminder.isCompleted &&
        reminder.repeatFrequency == RepeatFrequency.none) {
      return;
    }

    final current = now ?? DateTime.now();
    // Due day from the repeat rules, at the time of day the user chose
    // (not the time they last happened to tick it off)
    final nextDue = reminder.nextDueAt;
    final due = DateTime(
      nextDue.year,
      nextDue.month,
      nextDue.day,
      reminder.scheduledAt.hour,
      reminder.scheduledAt.minute,
    );
    final overdue = !due.isAfter(current);

    // Create payload with reminder info for handling notification taps
    final payload = jsonEncode({
      'type': 'reminder',
      'reminderId': reminder.id,
      'tankId': reminder.tankId,
      'reminderType': reminder.reminderType.name,
    });

    await _notificationService.scheduleNotification(
      id: reminder.id!,
      title: overdue
          ? 'Overdue: ${_getNotificationTitle(reminder)}'
          : _getNotificationTitle(reminder),
      body: overdue
          ? 'Due since ${DateFormat('d MMM').format(due)}. '
                '${_getNotificationBody(reminder)}'
          : _getNotificationBody(reminder),
      scheduledDate: nextFireTime(due, current),
      payload: payload,
      channel: NotificationChannel.reminders,
      repeatDaily: true,
    );
  }

  /// When to notify for a reminder [due] at that moment, seen from [now]:
  /// the due time itself if it's still ahead, otherwise the next time the
  /// clock shows the due time's hour and minute (today or tomorrow)
  @visibleForTesting
  static DateTime nextFireTime(DateTime due, DateTime now) {
    if (due.isAfter(now)) return due;
    var next = DateTime(now.year, now.month, now.day, due.hour, due.minute);
    if (!next.isAfter(now)) {
      next = DateTime(now.year, now.month, now.day + 1, due.hour, due.minute);
    }
    return next;
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
