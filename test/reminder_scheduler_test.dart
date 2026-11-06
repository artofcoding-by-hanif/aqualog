import 'package:aqualog/core/notifications/local_notification_service.dart';
import 'package:aqualog/features/reminders/data/reminder_scheduler.dart';
import 'package:aqualog/features/reminders/domain/entities/reminder.dart';
import 'package:flutter_test/flutter_test.dart';

/// Records scheduleNotification calls instead of talking to Android
class _FakeNotifications implements LocalNotificationService {
  final List<Map<String, Object?>> scheduled = [];

  @override
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    NotificationChannel channel = NotificationChannel.reminders,
    bool repeatDaily = false,
  }) async {
    scheduled.add({
      'id': id,
      'title': title,
      'body': body,
      'at': scheduledDate,
      'repeatDaily': repeatDaily,
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final now = DateTime(2026, 11, 6, 10, 0);

  ReminderEntity reminder({
    required DateTime scheduledAt,
    RepeatFrequency repeat = RepeatFrequency.none,
    bool enabled = true,
    bool completed = false,
    DateTime? lastCompletedAt,
  }) => ReminderEntity(
    lastCompletedAt: lastCompletedAt,
    id: 7,
    title: 'Water change',
    reminderType: ReminderType.waterChange,
    scheduledAt: scheduledAt,
    repeatFrequency: repeat,
    isEnabled: enabled,
    isCompleted: completed,
  );

  group('nextFireTime', () {
    test('upcoming reminders fire at their due time', () {
      final due = DateTime(2026, 11, 8, 9, 0);
      expect(ReminderScheduler.nextFireTime(due, now), due);
    });

    test('overdue reminders fire later today at their time of day', () {
      expect(
        ReminderScheduler.nextFireTime(DateTime(2026, 10, 25, 18, 30), now),
        DateTime(2026, 11, 6, 18, 30),
      );
    });

    test('or tomorrow if that time has already passed today', () {
      expect(
        ReminderScheduler.nextFireTime(DateTime(2026, 10, 25, 9, 0), now),
        DateTime(2026, 11, 7, 9, 0),
      );
    });
  });

  group('scheduleReminder', () {
    late _FakeNotifications notifications;
    late ReminderScheduler scheduler;

    setUp(() {
      notifications = _FakeNotifications();
      scheduler = ReminderScheduler.forTesting(notifications);
    });

    test(
      'overdue reminders are still scheduled, daily, marked overdue',
      () async {
        await scheduler.scheduleReminder(
          reminder(
            scheduledAt: DateTime(2026, 10, 25, 9, 0),
            repeat: RepeatFrequency.weekly,
          ),
          now: now,
        );

        final call = notifications.scheduled.single;
        expect(call['at'], DateTime(2026, 11, 7, 9, 0));
        expect(call['repeatDaily'], isTrue);
        expect(call['title'], startsWith('Overdue: '));
        expect(call['body'], startsWith('Due since 25 Oct.'));
      },
    );

    test('upcoming reminders fire on time and repeat until done', () async {
      final due = DateTime(2026, 11, 8, 9, 0);
      await scheduler.scheduleReminder(reminder(scheduledAt: due), now: now);

      final call = notifications.scheduled.single;
      expect(call['at'], due);
      expect(call['repeatDaily'], isTrue);
      expect(call['title'], isNot(startsWith('Overdue')));
    });

    test('repeating reminders keep their chosen time of day', () async {
      // Set for 9:00, repeats daily, last ticked off at 19:17 on 2 Nov
      await scheduler.scheduleReminder(
        reminder(
          scheduledAt: DateTime(2026, 10, 1, 9, 0),
          repeat: RepeatFrequency.daily,
          lastCompletedAt: DateTime(2026, 11, 2, 19, 17),
        ),
        now: now,
      );
      expect(notifications.scheduled.single['at'], DateTime(2026, 11, 7, 9, 0));
    });

    test('disabled or finished one-time reminders are not scheduled', () async {
      await scheduler.scheduleReminder(
        reminder(scheduledAt: DateTime(2026, 11, 8), enabled: false),
        now: now,
      );
      await scheduler.scheduleReminder(
        reminder(scheduledAt: DateTime(2026, 10, 1), completed: true),
        now: now,
      );
      expect(notifications.scheduled, isEmpty);
    });
  });
}
