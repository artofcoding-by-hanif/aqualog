import '../../../../core/database/app_database.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../models/reminder_model.dart';

/// Implementation of ReminderRepository using Drift database
class ReminderRepositoryImpl implements ReminderRepository {
  final AppDatabase _database;

  ReminderRepositoryImpl({required AppDatabase database}) : _database = database;

  @override
  Future<List<ReminderEntity>> getAllReminders() async {
    final reminders = await _database.getAllReminders();
    return reminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<ReminderEntity>> getRemindersForTank(int tankId) async {
    final reminders = await _database.getRemindersForTank(tankId);
    return reminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<ReminderEntity>> getRemindersForFilter(int filterId) async {
    final reminders = await _database.getRemindersForFilter(filterId);
    return reminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<ReminderEntity?> getReminderById(int id) async {
    final reminder = await _database.getReminderById(id);
    return reminder?.toEntity();
  }

  @override
  Future<List<ReminderEntity>> getEnabledReminders() async {
    final reminders = await _database.getEnabledReminders();
    return reminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<ReminderEntity>> getOverdueReminders() async {
    final reminders = await _database.getOverdueReminders();
    return reminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<ReminderEntity>> getUpcomingReminders(int withinDays) async {
    final reminders = await _database.getUpcomingReminders(withinDays);
    return reminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<int> addReminder(ReminderEntity reminder) {
    return _database.insertReminder(reminder.toCompanion());
  }

  @override
  Future<void> updateReminder(ReminderEntity reminder) async {
    await _database.updateReminder(reminder.toDriftReminder());
  }

  @override
  Future<void> deleteReminder(int id) async {
    await _database.deleteReminder(id);
  }

  @override
  Future<void> deleteRemindersForTank(int tankId) async {
    await _database.deleteRemindersForTank(tankId);
  }

  @override
  Future<void> deleteRemindersForFilter(int filterId) async {
    await _database.deleteRemindersForFilter(filterId);
  }

  @override
  Stream<List<ReminderEntity>> watchAllReminders() {
    return _database.watchAllReminders().map(
      (reminders) => reminders.map((r) => r.toEntity()).toList(),
    );
  }

  @override
  Stream<List<ReminderEntity>> watchRemindersForTank(int tankId) {
    return _database.watchRemindersForTank(tankId).map(
      (reminders) => reminders.map((r) => r.toEntity()).toList(),
    );
  }

  @override
  Future<void> completeReminder(int reminderId) {
    return _database.completeReminder(reminderId);
  }

  @override
  Future<void> toggleReminderEnabled(int reminderId, bool isEnabled) {
    return _database.toggleReminderEnabled(reminderId, isEnabled);
  }

  @override
  Future<void> snoozeReminder(int reminderId, Duration duration) {
    return _database.snoozeReminder(reminderId, duration);
  }
}

