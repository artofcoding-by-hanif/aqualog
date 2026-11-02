import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/theme/color_scheme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
import '../../../../router/app_router.dart';
import '../../../ai/presentation/widgets/tank_health_card.dart';
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

  void _open(String route, {bool withName = true}) {
    Navigator.pushNamed(
      context,
      route,
      arguments: {'tankId': _tank.id, if (withName) 'tankName': _tank.name},
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageCount = ref.watch(tankImageCountProvider(_tank.id!)).value;
    final photoLabel = imageCount == null
        ? 'Gallery'
        : imageCount == 0
        ? 'No photos'
        : '$imageCount photo${imageCount == 1 ? '' : 's'}';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeroAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverList.list(
              children: [
                _buildInfoCard(context),
                const SizedBox(height: 16),
                TankHealthCard(tankId: _tank.id!, tankName: _tank.name),
                const SizedBox(height: 24),
                _buildRemindersSection(context),
                const SizedBox(height: 24),
                _SectionGrid(
                  title: 'Livestock & Plants',
                  tiles: [
                    _SectionTileData(
                      'Fish',
                      Icons.set_meal_rounded,
                      AquaHue.fish,
                      () => _open(AppRouter.fishList),
                    ),
                    _SectionTileData(
                      'Invertebrates',
                      Icons.pest_control_rounded,
                      AquaHue.invertebrates,
                      () => _open(AppRouter.invertebrateList),
                    ),
                    _SectionTileData(
                      'Plants',
                      Icons.grass_rounded,
                      AquaHue.plants,
                      () => _open(AppRouter.plantList),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _SectionGrid(
                  title: 'Equipment',
                  tiles: [
                    _SectionTileData(
                      'Filters',
                      Icons.filter_alt_rounded,
                      AquaHue.filters,
                      () => _open(AppRouter.filterList),
                    ),
                    _SectionTileData(
                      'Lighting',
                      Icons.lightbulb_rounded,
                      AquaHue.lighting,
                      () => _open(AppRouter.lightingList),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _SectionGrid(
                  title: 'Aquascape',
                  tiles: [
                    _SectionTileData(
                      'Rocks',
                      Icons.terrain_rounded,
                      AquaHue.rocks,
                      () => _open(AppRouter.rockList),
                    ),
                    _SectionTileData(
                      'Driftwood',
                      Icons.park_rounded,
                      AquaHue.driftwood,
                      () => _open(AppRouter.driftwoodList),
                    ),
                    _SectionTileData(
                      'Substrate',
                      Icons.layers_rounded,
                      AquaHue.substrate,
                      () => _open(AppRouter.substrateEditor, withName: false),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _SectionGrid(
                  title: 'Logs & Care',
                  tiles: [
                    _SectionTileData(
                      'Water\nParameters',
                      Icons.analytics_rounded,
                      AquaHue.testing,
                      () => _open(AppRouter.waterParameterLogList),
                    ),
                    _SectionTileData(
                      'Feeding',
                      Icons.restaurant_rounded,
                      AquaHue.feeding,
                      () => _open(AppRouter.feedingLogList),
                    ),
                    _SectionTileData(
                      'Maintenance',
                      Icons.build_rounded,
                      AquaHue.maintenance,
                      () => _open(AppRouter.maintenanceLogList),
                    ),
                    _SectionTileData(
                      'Timeline',
                      Icons.timeline_rounded,
                      AquaHue.timeline,
                      () => _open(AppRouter.tankTimeline),
                    ),
                    _SectionTileData(
                      photoLabel,
                      Icons.photo_library_rounded,
                      AquaHue.gallery,
                      () => _open(AppRouter.tankGallery),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cover = ref.watch(tankCoverImageProvider(_tank.id!)).value;
    final hasPhoto = cover != null && File(cover.imagePath).existsSync();

    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 260,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.auto_awesome_rounded),
          tooltip: 'Ask the assistant',
          onPressed: () => _open(AppRouter.aiChat),
        ),
        IconButton(
          icon: const Icon(Icons.edit_rounded),
          tooltip: 'Edit',
          onPressed: _navigateToEdit,
        ),
        PopupMenuButton<String>(
          iconColor: Colors.white,
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
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(
          start: 56,
          end: 96,
          bottom: 16,
        ),
        title: Text(
          _tank.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (hasPhoto)
              Image.file(File(cover.imagePath), fit: BoxFit.cover)
            else
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AquaTheme.of(context).accentGradient,
                ),
                child: Center(
                  child: Text(
                    _tank.tankType.icon,
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
              ),
            // Scrims top and bottom keep icons and title readable
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x99020814),
                    Color(0x00020814),
                    Color(0x00020814),
                    Color(0xE6020814),
                  ],
                  stops: [0, 0.3, 0.55, 1],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final aqua = AquaTheme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientIconTile(emoji: _tank.tankType.icon, size: 52),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      _tank.volumeDisplay(),
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _tank.tankType.displayName,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (_tank.isActive)
                const StatusPill(label: 'Active', status: AquaStatus.healthy),
            ],
          ),
          if (_tank.hasDimensions || _tank.setupDate != null) ...[
            const SizedBox(height: 18),
            Row(
              children: [
                if (_tank.hasDimensions)
                  Expanded(
                    child: _InfoMetric(
                      icon: Icons.straighten_rounded,
                      label: 'Dimensions',
                      value: _tank.dimensionsDisplay ?? '',
                    ),
                  ),
                if (_tank.setupDate != null) ...[
                  Expanded(
                    child: _InfoMetric(
                      icon: Icons.calendar_today_rounded,
                      label: 'Set up',
                      value: _formatDate(_tank.setupDate!),
                    ),
                  ),
                  Expanded(
                    child: _InfoMetric(
                      icon: _tank.isCycled
                          ? Icons.verified_rounded
                          : Icons.timer_rounded,
                      label: _tank.isCycled ? 'Cycled' : 'Age',
                      value: '${_tank.daysSinceSetup} days',
                      color: _tank.isCycled ? aqua.healthy : null,
                    ),
                  ),
                ],
              ],
            ),
          ],
          if (_tank.description != null && _tank.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Divider(color: aqua.glassBorder),
            const SizedBox(height: 12),
            Text(
              _tank.description!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildRemindersSection(BuildContext context) {
    final remindersAsync = ref.watch(remindersForTankStreamProvider(_tank.id!));
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('Reminders', style: textTheme.titleMedium)),
            IconButton(
              icon: const Icon(Icons.add_rounded),
              tooltip: 'Add Reminder',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.reminderForm,
                  arguments: {'tankId': _tank.id},
                );
              },
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.reminders),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: remindersAsync.when(
            data: (reminders) {
              // Show up to 3 upcoming reminders
              final activeReminders =
                  reminders.where((r) => r.isEnabled && !r.isCompleted).toList()
                    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

              if (activeReminders.isEmpty) {
                return ListTile(
                  leading: const Icon(Icons.notifications_none_rounded),
                  title: const Text('No reminders set'),
                  subtitle: const Text('Tap + to add one'),
                );
              }

              return Column(
                children: activeReminders
                    .take(3)
                    .map((reminder) => _buildReminderItem(context, reminder))
                    .toList(),
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
        ),
      ],
    );
  }

  Widget _buildReminderItem(BuildContext context, ReminderEntity reminder) {
    final status = reminder.isOverdue
        ? AquaStatus.danger
        : reminder.isDueToday
        ? AquaStatus.caution
        : AquaStatus.neutral;

    return ListTile(
      leading: Text(
        reminder.reminderType.icon,
        style: const TextStyle(fontSize: 22),
      ),
      title: Text(reminder.title),
      trailing: StatusPill(label: reminder.dueStatusDisplay, status: status),
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

class _InfoMetric extends StatelessWidget {
  const _InfoMetric({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color ?? scheme.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: color ?? scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: textTheme.titleSmall),
      ],
    );
  }
}

class _SectionTileData {
  const _SectionTileData(this.label, this.icon, this.hue, this.onTap);

  final String label;
  final IconData icon;
  final Color hue;
  final VoidCallback onTap;
}

/// Titled grid of navigation tiles, three per row
class _SectionGrid extends StatelessWidget {
  const _SectionGrid({required this.title, required this.tiles});

  final String title;
  final List<_SectionTileData> tiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.98,
          children: [
            for (final tile in tiles)
              GlassCard(
                radius: 18,
                padding: const EdgeInsets.all(8),
                onTap: tile.onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientIconTile(
                      icon: tile.icon,
                      color: tile.hue,
                      size: 44,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      tile.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
