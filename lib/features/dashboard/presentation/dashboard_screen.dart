import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/aqua_theme.dart';
import '../../../core/theme/color_scheme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import '../../../router/app_router.dart';
import '../../logs/domain/entities/maintenance_log.dart';
import '../../reminders/presentation/controllers/reminder_provider.dart';
import '../../tank/domain/entities/tank.dart';
import '../../tank/presentation/controllers/tank_image_provider.dart';
import '../../tank/presentation/controllers/tank_provider.dart';
import '../../share/presentation/milestone_banner.dart';
import 'widgets/upcoming_reminders.dart';
import 'widgets/recent_activity.dart';

/// Dashboard screen

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tanksAsync = ref.watch(tanksStreamProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(tanksStreamProvider);
            ref.invalidate(remindersStreamProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              tanksAsync.when(
                loading: () => const _HeroCardSkeleton(),
                error: (error, _) => _buildTankCardError(context),
                data: (tanks) => tanks.isEmpty
                    ? _buildEmptyTankCard(context)
                    : _EcosystemHeroCard(tanks: tanks),
              ),
              if (tanksAsync.value?.isNotEmpty ?? false) ...[
                const SizedBox(height: 16),
                _TankCarousel(tanks: tanksAsync.value!),
              ],
              const SizedBox(height: 16),
              _AssistantCard(tanks: tanksAsync.value ?? const []),
              const MilestoneBanner(),
              const SizedBox(height: 24),
              _buildQuickActions(context, ref),
              const SizedBox(height: 28),
              const UpcomingReminders(),
              const SizedBox(height: 28),
              const RecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              GradientText(
                'TankMind',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _GlassIconButton(
          icon: Icons.settings_outlined,
          tooltip: 'Settings',
          onPressed: () => Navigator.pushNamed(context, AppRouter.settings),
        ),
      ],
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  Widget _buildTankCardError(BuildContext context) {
    final aqua = AquaTheme.of(context);
    return GlassCard(
      glowColor: aqua.danger,
      child: Row(
        children: [
          GradientIconTile(icon: Icons.error_outline, color: aqua.danger),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Failed to load tanks',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: aqua.danger),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTankCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return GlassCard(
      padding: const EdgeInsets.all(24),
      glowColor: scheme.primary,
      onTap: () => Navigator.pushNamed(context, AppRouter.tankForm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GradientIconTile(icon: Icons.add_rounded, size: 56),
          const SizedBox(height: 20),
          Text('Set up your first aquarium', style: textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Track water quality, livestock, plants and maintenance in one place.',
            style: textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          GradientButton(
            label: 'Add Tank',
            icon: Icons.water_drop_rounded,
            onPressed: () => Navigator.pushNamed(context, AppRouter.tankForm),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    final actions = [
      (
        hue: AquaHue.water,
        icon: Icons.water_drop_rounded,
        label: 'Water\nChange',
        route: AppRouter.maintenanceLogForm,
        args: <String, dynamic>{'initialType': MaintenanceType.waterChange},
      ),
      (
        hue: AquaHue.testing,
        icon: Icons.science_rounded,
        label: 'Test\nWater',
        route: AppRouter.waterParameterLogForm,
        args: <String, dynamic>{},
      ),
      (
        hue: AquaHue.feeding,
        icon: Icons.restaurant_rounded,
        label: 'Feed\nFish',
        route: AppRouter.feedingLogForm,
        args: <String, dynamic>{},
      ),
      (
        hue: AquaHue.notes,
        icon: Icons.edit_note_rounded,
        label: 'Add\nNote',
        route: AppRouter.maintenanceLogForm,
        args: <String, dynamic>{'initialType': MaintenanceType.other},
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Quick Log'),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final (index, action) in actions.indexed) ...[
              if (index > 0) const SizedBox(width: 10),
              Expanded(
                child: _QuickActionTile(
                  icon: action.icon,
                  hue: action.hue,
                  label: action.label,
                  onTap: () => _showTankSelectorAndNavigate(
                    context,
                    ref,
                    route: action.route,
                    extraArgs: action.args,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Future<void> _showTankSelectorAndNavigate(
    BuildContext context,
    WidgetRef ref, {
    required String route,
    Map<String, dynamic>? extraArgs,
  }) async {
    final tanksAsync = ref.read(tanksStreamProvider);

    final tanks = tanksAsync.value ?? [];

    if (tanks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please create a tank first'),
          action: SnackBarAction(
            label: 'Add Tank',
            onPressed: () => Navigator.pushNamed(context, AppRouter.tankForm),
          ),
        ),
      );
      return;
    }

    // If only one tank, navigate directly
    if (tanks.length == 1) {
      final tank = tanks.first;
      Navigator.pushNamed(
        context,
        route,
        arguments: {'tankId': tank.id, 'tankName': tank.name, ...?extraArgs},
      );
      return;
    }

    // Show tank selector dialog
    final selectedTank = await showDialog<TankEntity>(
      context: context,
      builder: (context) => _TankSelectorDialog(tanks: tanks),
    );

    if (selectedTank != null && context.mounted) {
      Navigator.pushNamed(
        context,
        route,
        arguments: {
          'tankId': selectedTank.id,
          'tankName': selectedTank.name,
          ...?extraArgs,
        },
      );
    }
  }
}

/// Entry point to the AI assistant, scoped to the active tank if there is one
class _AssistantCard extends StatelessWidget {
  const _AssistantCard({required this.tanks});

  final List<TankEntity> tanks;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final tank =
        tanks.where((t) => t.isActive).firstOrNull ??
        (tanks.length == 1 ? tanks.first : null);

    return GlassCard(
      padding: const EdgeInsets.all(16),
      glowColor: scheme.tertiary,
      borderColor: scheme.tertiary.withValues(alpha: 0.35),
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.aiChat,
        arguments: {'tankId': tank?.id, 'tankName': tank?.name},
      ),
      child: Row(
        children: [
          GradientIconTile(
            icon: Icons.auto_awesome_rounded,
            size: 48,
            gradient: aqua.accentGradient,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  'Ask TankMind AI',
                  gradient: aqua.accentGradient,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  tank == null
                      ? 'Advice on water quality, livestock and care'
                      : 'Personalised advice for ${tank.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_rounded, color: scheme.tertiary),
        ],
      ),
    );
  }
}

/// Section heading used across the dashboard
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

/// Circular glass button for header actions
class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    return Tooltip(
      message: tooltip ?? '',
      child: Material(
        color: aqua.glassFill,
        shape: CircleBorder(side: BorderSide(color: aqua.glassBorder)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(icon, size: 22),
          ),
        ),
      ),
    );
  }
}

/// Hero summary of every tank: count, total volume and task health
class _EcosystemHeroCard extends ConsumerWidget {
  const _EcosystemHeroCard({required this.tanks});

  final List<TankEntity> tanks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final aqua = AquaTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final totalVolume = tanks.fold<double>(0, (sum, t) => sum + t.volumeLiters);
    final reminders = ref.watch(remindersStreamProvider).value ?? [];
    final overdue = reminders.where((r) => r.isEnabled && r.isOverdue).length;
    final dueToday = reminders
        .where((r) => r.isEnabled && !r.isOverdue && r.isDueToday)
        .length;

    final (status, statusLabel) = overdue > 0
        ? (AquaStatus.danger, '$overdue overdue')
        : dueToday > 0
        ? (AquaStatus.caution, '$dueToday due today')
        : (AquaStatus.healthy, 'All on track');

    return GlassCard(
      padding: const EdgeInsets.all(22),
      glowColor: scheme.primary,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0x3314E0C0),
                const Color(0x1A22D3EE),
                const Color(0x0D3B82F6),
              ]
            : [const Color(0x2614E0C0), const Color(0x1422D3EE), Colors.white],
      ),
      onTap: () => Navigator.pushNamed(context, AppRouter.tankList),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'YOUR ECOSYSTEM',
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  letterSpacing: 1.6,
                ),
              ),
              const Spacer(),
              StatusPill(label: statusLabel, status: status),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _HeroMetric(
                  value: '${tanks.length}',
                  label: tanks.length == 1 ? 'Tank' : 'Tanks',
                ),
              ),
              Container(width: 1, height: 44, color: aqua.glassBorder),
              const SizedBox(width: 20),
              Expanded(
                child: _HeroMetric(
                  value: totalVolume.toStringAsFixed(0),
                  unit: 'L',
                  label: 'Total volume',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                'Manage tanks',
                style: textTheme.labelLarge?.copyWith(color: scheme.primary),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: scheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.value, required this.label, this.unit});

  final String value;
  final String label;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            GradientText(
              value,
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 4),
              Text(unit!, style: textTheme.titleMedium),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _HeroCardSkeleton extends StatelessWidget {
  const _HeroCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      padding: EdgeInsets.all(22),
      child: SizedBox(
        height: 132,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
    );
  }
}

/// Horizontally scrolling tank cards with cover photos
class _TankCarousel extends StatelessWidget {
  const _TankCarousel({required this.tanks});

  final List<TankEntity> tanks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: tanks.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _TankTile(tank: tanks[index]),
      ),
    );
  }
}

class _TankTile extends ConsumerWidget {
  const _TankTile({required this.tank});

  final TankEntity tank;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final aqua = AquaTheme.of(context);
    final cover = tank.id == null
        ? null
        : ref.watch(tankCoverImageProvider(tank.id!)).value;
    final hasPhoto = cover != null && File(cover.imagePath).existsSync();

    return SizedBox(
      width: 148,
      child: GlassCard(
        padding: EdgeInsets.zero,
        onTap: () =>
            Navigator.pushNamed(context, AppRouter.tankDetail, arguments: tank),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasPhoto)
              Image.file(
                File(cover.imagePath),
                fit: BoxFit.cover,
                cacheWidth: 400,
              )
            else
              DecoratedBox(
                decoration: BoxDecoration(gradient: aqua.accentGradient),
                child: Center(
                  child: Text(
                    tank.tankType.icon,
                    style: const TextStyle(fontSize: 44),
                  ),
                ),
              ),
            // Darken the bottom so the label reads on any photo
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xCC020814)],
                  stops: [0.35, 1],
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tank.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${tank.volumeLiters.toStringAsFixed(0)} L · ${tank.tankType.displayName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.hue,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color hue;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      radius: 18,
      onTap: onTap,
      child: Column(
        children: [
          GradientIconTile(icon: icon, color: hue, size: 44),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dialog for selecting a tank
class _TankSelectorDialog extends StatelessWidget {
  const _TankSelectorDialog({required this.tanks});

  final List<TankEntity> tanks;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Tank'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tanks.length,
          itemBuilder: (context, index) {
            final tank = tanks[index];
            return ListTile(
              leading: GradientIconTile(emoji: tank.tankType.icon, size: 40),
              title: Text(tank.name),
              subtitle: Text('${tank.volumeLiters.toStringAsFixed(0)} L'),
              onTap: () => Navigator.pop(context, tank),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
