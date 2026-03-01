import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/app_router.dart';
import '../../../reminders/domain/entities/reminder.dart';
import '../../../reminders/presentation/controllers/reminder_provider.dart';
import '../../domain/entities/tank.dart';
import '../controllers/tank_image_provider.dart';
import '../controllers/tank_provider.dart';

/// Tank detail screen showing tank information and navigation to sub-features
class TankDetailScreen extends ConsumerStatefulWidget {
  const TankDetailScreen({super.key, required this.tank});

  final TankEntity tank;

  @override
  ConsumerState<TankDetailScreen> createState() => _TankDetailScreenState();
}

class _TankDetailScreenState extends ConsumerState<TankDetailScreen> {
  late TankEntity _tank;

  @override
  void initState() {
    super.initState();
    _tank = widget.tank;
  }

  Future<void> _navigateToEdit() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.tankForm,
      arguments: _tank,
    );
    if (result == true && mounted) {
      // Refresh tank data after edit
      final updatedTank = await ref.read(tankByIdProvider(_tank.id!).future);
      if (updatedTank != null && mounted) {
        setState(() {
          _tank = updatedTank;
        });
      }
    }
  }

  Future<void> _deleteTank() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tank'),
        content: Text('Are you sure you want to delete "${_tank.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref.read(tankProvider.notifier).deleteTank(_tank.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tank deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting tank: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  Future<void> _setAsActive() async {
    try {
      await ref.read(tankProvider.notifier).setActiveTank(_tank.id!);
      if (mounted) {
        setState(() {
          _tank = _tank.copyWith(isActive: true);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${_tank.name} is now active')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error setting active tank: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tank.name),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _navigateToEdit),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _deleteTank();
              } else if (value == 'setActive') {
                _setAsActive();
              }
            },
            itemBuilder: (context) => [
              if (!_tank.isActive)
                const PopupMenuItem(
                  value: 'setActive',
                  child: Text('Set as Active'),
                ),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(context),
            const SizedBox(height: 16),
            _buildGalleryCard(context),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Filters',
              icon: Icons.filter_alt,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.filterList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Lighting',
              icon: Icons.lightbulb,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.lightingList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Fish',
              icon: Icons.water,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.fishList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Invertebrates',
              icon: Icons.bug_report,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.invertebrateList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Plants',
              icon: Icons.grass,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.plantList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Rocks',
              icon: Icons.terrain,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.rockList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Driftwood',
              icon: Icons.park,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.driftwoodList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Substrate',
              icon: Icons.layers,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.substrateEditor,
                  arguments: {'tankId': _tank.id},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildRemindersSection(context),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Water Parameters',
              icon: Icons.analytics,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.waterParameterLogList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Feeding Log',
              icon: Icons.restaurant,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.feedingLogList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Maintenance Log',
              icon: Icons.history,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.maintenanceLogList,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
            const SizedBox(height: 8),
            _buildSectionCard(
              context,
              title: 'Timeline',
              icon: Icons.timeline,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.tankTimeline,
                  arguments: {'tankId': _tank.id, 'tankName': _tank.name},
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(_tank.tankType.icon, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _tank.volumeDisplay(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      _tank.tankType.displayName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (_tank.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Active',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (_tank.hasDimensions) ...[
              _buildInfoRow(
                context,
                icon: Icons.straighten,
                label: 'Dimensions',
                value: _tank.dimensionsDisplay ?? '',
              ),
              const SizedBox(height: 8),
            ],
            if (_tank.setupDate != null) ...[
              _buildInfoRow(
                context,
                icon: Icons.calendar_today,
                label: 'Setup Date',
                value: _formatDate(_tank.setupDate!),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                icon: Icons.timer,
                label: 'Age',
                value:
                    '${_tank.daysSinceSetup} days${_tank.isCycled ? ' (Cycled)' : ''}',
              ),
              const SizedBox(height: 8),
            ],
            if (_tank.description != null && _tank.description!.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              Text(
                _tank.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildGalleryCard(BuildContext context) {
    final imageCountAsync = ref.watch(tankImageCountProvider(_tank.id!));

    return Card(
      child: ListTile(
        leading: const Icon(Icons.photo_library),
        title: const Text('Gallery'),
        subtitle: imageCountAsync.when(
          data: (count) => Text(
            count == 0 ? 'No photos' : '$count photo${count == 1 ? '' : 's'}',
          ),
          loading: () => const Text('...'),
          error: (e, s) => const Text(''),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouter.tankGallery,
            arguments: {'tankId': _tank.id, 'tankName': _tank.name},
          );
        },
      ),
    );
  }

  Widget _buildRemindersSection(BuildContext context) {
    final remindersAsync = ref.watch(remindersForTankStreamProvider(_tank.id!));

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Reminders'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.reminderForm,
                      arguments: {'tankId': _tank.id},
                    );
                  },
                  tooltip: 'Add Reminder',
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.reminders);
            },
          ),
          remindersAsync.when(
            data: (reminders) {
              if (reminders.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Text(
                    'No reminders set',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                );
              }

              // Show up to 3 upcoming reminders
              final activeReminders =
                  reminders.where((r) => r.isEnabled && !r.isCompleted).toList()
                    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

              final displayReminders = activeReminders.take(3).toList();

              return Column(
                children: displayReminders.map((reminder) {
                  return _buildReminderItem(context, reminder);
                }).toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Error: $e'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderItem(BuildContext context, ReminderEntity reminder) {
    final colorScheme = Theme.of(context).colorScheme;
    Color statusColor;

    if (reminder.isOverdue) {
      statusColor = colorScheme.error;
    } else if (reminder.isDueToday) {
      statusColor = colorScheme.tertiary;
    } else if (reminder.isDueSoon) {
      statusColor = colorScheme.secondary;
    } else {
      statusColor = colorScheme.primary;
    }

    return ListTile(
      dense: true,
      leading: Text(
        reminder.reminderType.icon,
        style: const TextStyle(fontSize: 20),
      ),
      title: Text(reminder.title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
        reminder.dueStatusDisplay,
        style: TextStyle(color: statusColor, fontSize: 12),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.reminderForm,
          arguments: {'reminder': reminder},
        );
      },
    );
  }
}
