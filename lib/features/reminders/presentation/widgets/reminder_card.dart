import 'package:flutter/material.dart';

import '../../domain/entities/reminder.dart';

/// Reminder card widget for displaying reminder summary
class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.reminder,
    this.tankName,
    this.onTap,
    this.onToggle,
    this.onComplete,
    this.onSnooze,
  });

  final ReminderEntity reminder;
  final String? tankName;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onComplete;
  final ValueChanged<Duration>? onSnooze;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _getStatusColor(colorScheme),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    reminder.reminderType.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: _isCompletedOneTime
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (tankName != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 12,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              tankName!,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      reminder.infoSummary,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    _buildStatusRow(context, colorScheme),
                  ],
                ),
              ),
              _buildTrailing(context, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  bool get _isCompletedOneTime =>
      reminder.isCompleted && reminder.repeatFrequency == RepeatFrequency.none;

  Color _getStatusColor(ColorScheme colorScheme) {
    if (_isCompletedOneTime) {
      return colorScheme.surfaceContainerHighest;
    }
    if (!reminder.isEnabled) {
      return colorScheme.surfaceContainerHighest;
    }
    if (reminder.isOverdue) {
      return colorScheme.errorContainer;
    }
    if (reminder.isDueToday) {
      return colorScheme.tertiaryContainer;
    }
    if (reminder.isDueSoon) {
      return colorScheme.secondaryContainer;
    }
    return colorScheme.primaryContainer;
  }

  Widget _buildStatusRow(BuildContext context, ColorScheme colorScheme) {
    if (_isCompletedOneTime) {
      return Row(
        children: [
          Icon(Icons.check_circle, size: 14, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            'Completed',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.primary),
          ),
        ],
      );
    }

    if (!reminder.isEnabled) {
      return Row(
        children: [
          Icon(Icons.notifications_off, size: 14, color: colorScheme.outline),
          const SizedBox(width: 4),
          Text(
            'Disabled',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
          ),
        ],
      );
    }

    if (reminder.isOverdue) {
      return Row(
        children: [
          Icon(Icons.warning, size: 14, color: colorScheme.error),
          const SizedBox(width: 4),
          Text(
            reminder.dueStatusDisplay,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(Icons.schedule, size: 14, color: colorScheme.outline),
        const SizedBox(width: 4),
        Text(
          reminder.dueStatusDisplay,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
        ),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context, ColorScheme colorScheme) {
    if (_isCompletedOneTime) {
      return const Icon(Icons.chevron_right);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (reminder.isEnabled && !_isCompletedOneTime)
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: colorScheme.outline),
            tooltip: 'More options',
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'complete',
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text('Mark as done'),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const PopupMenuItem(
                value: 'snooze',
                child: ListTile(
                  leading: Icon(Icons.snooze),
                  title: Text('Snooze'),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        Switch(value: reminder.isEnabled, onChanged: onToggle),
      ],
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'complete':
        _showCompleteConfirmation(context);
        break;
      case 'snooze':
        _showSnoozeDialog(context);
        break;
    }
  }

  void _showCompleteConfirmation(BuildContext context) {
    final isRecurring = reminder.repeatFrequency != RepeatFrequency.none;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Done'),
        content: Text(
          isRecurring
              ? 'This will mark "${reminder.title}" as completed and schedule the next occurrence.'
              : 'This will mark "${reminder.title}" as completed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              onComplete?.call();
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _showSnoozeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Snooze Reminder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Snooze "${reminder.title}" for:'),
            const SizedBox(height: 16),
            _SnoozeOption(
              label: '1 hour',
              onTap: () {
                Navigator.of(context).pop();
                onSnooze?.call(const Duration(hours: 1));
              },
            ),
            _SnoozeOption(
              label: '3 hours',
              onTap: () {
                Navigator.of(context).pop();
                onSnooze?.call(const Duration(hours: 3));
              },
            ),
            _SnoozeOption(
              label: '1 day',
              onTap: () {
                Navigator.of(context).pop();
                onSnooze?.call(const Duration(days: 1));
              },
            ),
            _SnoozeOption(
              label: '3 days',
              onTap: () {
                Navigator.of(context).pop();
                onSnooze?.call(const Duration(days: 3));
              },
            ),
            _SnoozeOption(
              label: '1 week',
              onTap: () {
                Navigator.of(context).pop();
                onSnooze?.call(const Duration(days: 7));
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class _SnoozeOption extends StatelessWidget {
  const _SnoozeOption({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
