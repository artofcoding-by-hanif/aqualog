import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../router/app_router.dart';
import '../../tank/presentation/controllers/tank_provider.dart';
import '../domain/entities/reminder.dart';
import 'controllers/reminder_provider.dart';
import 'widgets/reminder_card.dart';

/// Reminder list screen - displays all reminders
class ReminderListScreen extends ConsumerWidget {
  const ReminderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersStreamProvider);
    final tanksAsync = ref.watch(tanksStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: remindersAsync.when(
        data: (reminders) {
          // Build tank name map
          final tankNameMap = <int, String>{};
          tanksAsync.whenData((tanks) {
            for (final tank in tanks) {
              if (tank.id != null) {
                tankNameMap[tank.id!] = tank.name;
              }
            }
          });
          return _buildReminderList(context, ref, reminders, tankNameMap);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddReminder(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildReminderList(
    BuildContext context,
    WidgetRef ref,
    List<ReminderEntity> reminders,
    Map<int, String> tankNameMap,
  ) {
    if (reminders.isEmpty) {
      return EmptyState(
        icon: Icons.notifications_none,
        title: 'No reminders',
        subtitle: 'Set up reminders for water changes, feeding, and more',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddReminder(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Reminder'),
        ),
      );
    }

    // Categorize reminders
    final overdueReminders = reminders
        .where((r) => r.isOverdue && r.isEnabled)
        .toList();
    final dueTodayReminders = reminders
        .where((r) => r.isDueToday && !r.isOverdue && r.isEnabled)
        .toList();
    final upcomingReminders = reminders
        .where((r) => !r.isOverdue && !r.isDueToday && r.isEnabled)
        .toList();
    final disabledReminders = reminders.where((r) => !r.isEnabled).toList();
    final completedReminders = reminders
        .where(
          (r) =>
              r.isCompleted &&
              r.repeatFrequency == RepeatFrequency.none &&
              r.isEnabled,
        )
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(remindersStreamProvider);
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        children: [
          if (overdueReminders.isNotEmpty)
            _buildSection(
              context,
              ref,
              'Overdue (${overdueReminders.length})',
              overdueReminders,
              Theme.of(context).colorScheme.error,
              tankNameMap,
            ),
          if (dueTodayReminders.isNotEmpty)
            _buildSection(
              context,
              ref,
              'Due Today (${dueTodayReminders.length})',
              dueTodayReminders,
              Theme.of(context).colorScheme.tertiary,
              tankNameMap,
            ),
          if (upcomingReminders.isNotEmpty)
            _buildSection(
              context,
              ref,
              'Upcoming (${upcomingReminders.length})',
              upcomingReminders,
              Theme.of(context).colorScheme.primary,
              tankNameMap,
            ),
          if (disabledReminders.isNotEmpty)
            _buildSection(
              context,
              ref,
              'Disabled (${disabledReminders.length})',
              disabledReminders,
              Theme.of(context).colorScheme.outline,
              tankNameMap,
            ),
          if (completedReminders.isNotEmpty)
            _buildSection(
              context,
              ref,
              'Completed (${completedReminders.length})',
              completedReminders,
              Theme.of(context).colorScheme.outline,
              tankNameMap,
            ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    WidgetRef ref,
    String title,
    List<ReminderEntity> reminders,
    Color titleColor,
    Map<int, String> tankNameMap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...reminders.map(
          (reminder) => ReminderCard(
            reminder: reminder,
            tankName: reminder.tankId != null
                ? tankNameMap[reminder.tankId!]
                : null,
            onTap: () => _navigateToEditReminder(context, reminder),
            onToggle: (value) => _toggleReminder(ref, reminder, value),
            onComplete: () => _completeReminder(ref, reminder),
            onSnooze: (duration) => _snoozeReminder(ref, reminder, duration),
          ),
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading reminders',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddReminder(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.reminderForm,
      arguments: {'reminder': null},
    );
  }

  void _navigateToEditReminder(BuildContext context, ReminderEntity reminder) {
    Navigator.pushNamed(
      context,
      AppRouter.reminderForm,
      arguments: {'reminder': reminder},
    );
  }

  void _toggleReminder(WidgetRef ref, ReminderEntity reminder, bool value) {
    if (reminder.id != null) {
      ref
          .read(reminderProvider.notifier)
          .toggleReminderEnabled(reminder.id!, value);
    }
  }

  void _completeReminder(WidgetRef ref, ReminderEntity reminder) {
    if (reminder.id != null) {
      ref.read(reminderProvider.notifier).completeReminder(reminder.id!);
    }
  }

  void _snoozeReminder(
    WidgetRef ref,
    ReminderEntity reminder,
    Duration duration,
  ) {
    if (reminder.id != null) {
      ref
          .read(reminderProvider.notifier)
          .snoozeReminder(reminder.id!, duration);
    }
  }
}
