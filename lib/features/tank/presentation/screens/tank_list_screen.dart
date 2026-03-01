import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../router/app_router.dart';
import '../../domain/entities/tank.dart';
import '../controllers/tank_provider.dart';
import '../widgets/tank_card.dart';

/// Tank list screen - displays all tanks
class TankListScreen extends ConsumerWidget {
  const TankListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tanksAsync = ref.watch(tanksStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tanks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.settings);
            },
          ),
        ],
      ),
      body: tanksAsync.when(
        data: (tanks) => _buildTankList(context, ref, tanks),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTank(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTankList(
    BuildContext context,
    WidgetRef ref,
    List<TankEntity> tanks,
  ) {
    if (tanks.isEmpty) {
      return EmptyState(
        icon: Icons.water_drop_outlined,
        title: 'No tanks yet',
        subtitle: 'Add your first aquarium to get started',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddTank(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Tank'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(tanksStreamProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: tanks.length,
        itemBuilder: (context, index) {
          final tank = tanks[index];
          return TankCard(
            tank: tank,
            isSelected: tank.isActive,
            onTap: () => _navigateToTankDetail(context, tank),
          );
        },
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load tanks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddTank(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.tankForm);
  }

  void _navigateToTankDetail(BuildContext context, TankEntity tank) {
    Navigator.pushNamed(context, AppRouter.tankDetail, arguments: tank);
  }
}
