import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/app_router.dart';
import '../../../reminders/domain/entities/reminder.dart';
import '../../../reminders/presentation/controllers/reminder_provider.dart';
import '../../../tank/presentation/controllers/tank_provider.dart';

/// Upcoming reminders widget - shows overdue and upcoming reminders
class UpcomingReminders extends ConsumerWidget {
  const UpcomingReminders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersStreamProvider);
    final tanksAsync = ref.watch(tanksStreamProvider);

    // Build tank name map
    final tankNameMap = <int, String>{};
    tanksAsync.whenData((tanks) {
      for (final tank in tanks) {
        if (tank.id != null) {
          tankNameMap[tank.id!] = tank.name;
        }
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Reminders',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.reminders);
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        remindersAsync.when(
          data: (reminders) =>
              _buildRemindersList(context, ref, reminders, tankNameMap),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Card(
            child: ListTile(
              leading: const Icon(Icons.error_outline),
              title: const Text('Error loading reminders'),
              subtitle: Text(error.toString()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRemindersList(
    BuildContext context,
    WidgetRef ref,
    List<ReminderEntity> reminders,
    Map<int, String> tankNameMap,
  ) {
    // Filter to only enabled, non-completed reminders that are overdue, due today, or due tomorrow
    final activeReminders = reminders
        .where(
          (r) =>
              r.isEnabled &&
              !(r.isCompleted && r.repeatFrequency == RepeatFrequency.none) &&
              (r.isOverdue || r.isDueTodayOrTomorrow),
        )
        .toList();

    // Sort by due date (overdue first, then by scheduledAt)
    activeReminders.sort((a, b) {
      if (a.isOverdue && !b.isOverdue) return -1;
      if (!a.isOverdue && b.isOverdue) return 1;
      return a.scheduledAt.compareTo(b.scheduledAt);
    });

    // Take only the first 5 reminders for the dashboard
    final displayReminders = activeReminders.take(5).toList();

    if (displayReminders.isEmpty) {
      return Card(
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          title: const Text('All caught up!'),
          subtitle: const Text('No reminders for today or tomorrow'),
          onTap: () => Navigator.pushNamed(context, AppRouter.reminders),
        ),
      );
    }

    return Column(
      children: displayReminders
          .map(
            (reminder) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildReminderItem(
                context,
                ref,
                reminder,
                reminder.tankId != null ? tankNameMap[reminder.tankId!] : null,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildReminderItem(
    BuildContext context,
    WidgetRef ref,
    ReminderEntity reminder,
    String? tankName,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = _getStatusColor(reminder, colorScheme);

    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(
          context,
          AppRouter.reminderForm,
          arguments: {'reminder': reminder},
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              reminder.reminderType.icon,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        title: Text(
          reminder.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tankName != null)
              Row(
                children: [
                  Icon(Icons.water_drop, size: 12, color: colorScheme.primary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      tankName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            Text(
              reminder.dueStatusDisplay,
              style: TextStyle(
                color: reminder.isOverdue ? colorScheme.error : null,
                fontWeight: reminder.isOverdue ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.check_circle_outline,
            color: reminder.isOverdue || reminder.isDueToday
                ? colorScheme.primary
                : colorScheme.outline,
          ),
          onPressed: () => _completeReminder(ref, reminder),
          tooltip: 'Mark as done',
        ),
      ),
    );
  }

  Color _getStatusColor(ReminderEntity reminder, ColorScheme colorScheme) {
    if (reminder.isOverdue) {
      return colorScheme.error;
    }
    if (reminder.isDueToday) {
      return colorScheme.tertiary;
    }
    if (reminder.isDueSoon) {
      return colorScheme.secondary;
    }
    return colorScheme.primary;
  }

  void _completeReminder(WidgetRef ref, ReminderEntity reminder) {
    if (reminder.id != null) {
      ref.read(reminderProvider.notifier).completeReminder(reminder.id!);
    }
  }
}
