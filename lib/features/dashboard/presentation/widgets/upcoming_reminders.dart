import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.reminders);
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        remindersAsync.when(
          data: (reminders) =>
              _buildRemindersList(context, ref, reminders, tankNameMap),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => GlassCard(
            padding: EdgeInsets.zero,
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
      final aqua = AquaTheme.of(context);
      return GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        glowColor: aqua.healthy,
        onTap: () => Navigator.pushNamed(context, AppRouter.reminders),
        child: ListTile(
          leading: GradientIconTile(
            icon: Icons.check_rounded,
            color: aqua.healthy,
            size: 44,
          ),
          title: const Text('All caught up!'),
          subtitle: const Text('No reminders for today or tomorrow'),
        ),
      );
    }

    return Column(
      children: displayReminders
          .map(
            (reminder) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
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
    final textTheme = Theme.of(context).textTheme;
    final status = _getStatus(reminder);
    final statusColor = AquaTheme.of(context).statusColor(status, colorScheme);

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
      glowColor: status == AquaStatus.danger ? statusColor : null,
      borderColor: status == AquaStatus.danger
          ? statusColor.withValues(alpha: 0.35)
          : null,
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.reminderForm,
        arguments: {'reminder': reminder},
      ),
      child: Row(
        children: [
          GradientIconTile(
            emoji: reminder.reminderType.icon,
            color: statusColor,
            size: 44,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall,
                ),
                if (tankName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    tankName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                StatusPill(label: reminder.dueStatusDisplay, status: status),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_outline_rounded,
              color: reminder.isOverdue || reminder.isDueToday
                  ? colorScheme.primary
                  : colorScheme.outline,
            ),
            onPressed: () => _completeReminder(ref, reminder),
            tooltip: 'Mark as done',
          ),
        ],
      ),
    );
  }

  AquaStatus _getStatus(ReminderEntity reminder) {
    if (reminder.isOverdue) return AquaStatus.danger;
    if (reminder.isDueToday) return AquaStatus.caution;
    return AquaStatus.neutral;
  }

  void _completeReminder(WidgetRef ref, ReminderEntity reminder) {
    if (reminder.id != null) {
      ref.read(reminderProvider.notifier).completeReminder(reminder.id!);
    }
  }
}
