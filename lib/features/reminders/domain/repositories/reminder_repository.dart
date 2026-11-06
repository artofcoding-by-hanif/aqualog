import '../entities/reminder.dart';

/// Reminder repository interface
abstract class ReminderRepository {
  /// Get all reminders (ordered by scheduled time)
  Future<List<ReminderEntity>> getAllReminders();

  /// Get all reminders for a tank
  Future<List<ReminderEntity>> getRemindersForTank(int tankId);

  /// Get all reminders for a filter
  Future<List<ReminderEntity>> getRemindersForFilter(int filterId);

  /// Get a reminder by ID
  Future<ReminderEntity?> getReminderById(int id);

  /// Get enabled reminders (for scheduling)
  Future<List<ReminderEntity>> getEnabledReminders();

  /// Get overdue reminders
  Future<List<ReminderEntity>> getOverdueReminders();

  /// Get upcoming reminders (due within specified days)
  Future<List<ReminderEntity>> getUpcomingReminders(int withinDays);

  /// Add a new reminder
  Future<int> addReminder(ReminderEntity reminder);

  /// Update an existing reminder
  Future<void> updateReminder(ReminderEntity reminder);

  /// Delete a reminder
  Future<void> deleteReminder(int id);

  /// Delete all reminders for a tank
  Future<void> deleteRemindersForTank(int tankId);

  /// Delete all reminders for a filter
  Future<void> deleteRemindersForFilter(int filterId);

  /// Watch all reminders (reactive stream)
  Stream<List<ReminderEntity>> watchAllReminders();

  /// Watch all reminders for a tank (reactive stream)
  Stream<List<ReminderEntity>> watchRemindersForTank(int tankId);

  /// Mark reminder as completed and reschedule if recurring
  Future<void> completeReminder(int reminderId);

  /// Toggle reminder enabled status
  Future<void> toggleReminderEnabled(int reminderId, bool isEnabled);

  /// Snooze a reminder by a specified duration
  Future<void> snoozeReminder(int reminderId, Duration duration);
}
