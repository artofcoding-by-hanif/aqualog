import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/app_router.dart';
import '../../logs/domain/entities/maintenance_log.dart';
import '../../tank/domain/entities/tank.dart';
import '../../tank/presentation/controllers/tank_provider.dart';
import 'widgets/upcoming_reminders.dart';
import 'widgets/recent_activity.dart';

/// Dashboard screen

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaLog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh data
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTankSection(context, ref),
            const SizedBox(height: 24),
            _buildQuickActions(context, ref),
            const SizedBox(height: 24),
            const UpcomingReminders(),
            const SizedBox(height: 24),
            const RecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildTankSection(BuildContext context, WidgetRef ref) {
    final tanksAsync = ref.watch(tanksStreamProvider);

    return tanksAsync.when(
      loading: () => _buildTankCardLoading(context),
      error: (error, _) => _buildTankCardError(context, error),
      data: (tanks) {
        if (tanks.isEmpty) {
          return _buildEmptyTankCard(context);
        }
        return _buildTankCard(context, tanks);
      },
    );
  }

  Widget _buildTankCardLoading(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 16,
                    child: LinearProgressIndicator(),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 150,
                    height: 12,
                    child: LinearProgressIndicator(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTankCardError(BuildContext context, Object error) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.error_outline,
                size: 32,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Failed to load tanks',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTankCard(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouter.tankForm),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No tanks yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to add your first aquarium',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTankCard(BuildContext context, List<TankEntity> tanks) {
    final tankCount = tanks.length;
    // Calculate total volume across all tanks
    final totalVolume = tanks.fold<double>(
      0,
      (sum, tank) => sum + tank.volumeLiters,
    );

    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouter.tankList),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.water_drop,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tankCount == 1 ? '1 Tank' : '$tankCount Tanks',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${totalVolume.toStringAsFixed(0)}L total volume',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to manage tanks',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickAction(
            context,
            icon: Icons.water_drop,
            label: 'Water\nChange',
            onTap: () => _showTankSelectorAndNavigate(
              context,
              ref,
              route: AppRouter.maintenanceLogForm,
              extraArgs: {'initialType': MaintenanceType.waterChange},
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickAction(
            context,
            icon: Icons.science,
            label: 'Test\nWater',
            onTap: () => _showTankSelectorAndNavigate(
              context,
              ref,
              route: AppRouter.waterParameterLogForm,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickAction(
            context,
            icon: Icons.restaurant,
            label: 'Feed\nFish',
            onTap: () => _showTankSelectorAndNavigate(
              context,
              ref,
              route: AppRouter.feedingLogForm,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickAction(
            context,
            icon: Icons.note_add,
            label: 'Add\nNote',
            onTap: () => _showTankSelectorAndNavigate(
              context,
              ref,
              route: AppRouter.maintenanceLogForm,
              extraArgs: {'initialType': MaintenanceType.other},
            ),
          ),
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

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
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
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    tank.tankType.icon,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              title: Text(tank.name),
              subtitle: Text('${tank.volumeLiters.toStringAsFixed(0)}L'),
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
