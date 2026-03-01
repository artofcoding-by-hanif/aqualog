import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../router/app_router.dart';
import '../../domain/entities/driftwood.dart';
import '../controllers/driftwood_provider.dart';
import '../widgets/driftwood_card.dart';

/// Driftwood list screen - displays all driftwood for a tank
class DriftwoodListScreen extends ConsumerWidget {
  const DriftwoodListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driftwoodsAsync = ref.watch(driftwoodsForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(
        title: Text('$tankName Driftwood'),
      ),
      body: driftwoodsAsync.when(
        data: (driftwoodList) => _buildDriftwoodList(context, ref, driftwoodList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddDriftwood(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDriftwoodList(
    BuildContext context,
    WidgetRef ref,
    List<DriftwoodEntity> driftwoodList,
  ) {
    if (driftwoodList.isEmpty) {
      return EmptyState(
        icon: Icons.park,
        title: 'No driftwood yet',
        subtitle: 'Add your first driftwood to this tank',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddDriftwood(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Driftwood'),
        ),
      );
    }

    // Separate curing and stable driftwood
    final curingDriftwood = driftwoodList.where((d) => !d.isCured).toList();
    final stableDriftwood = driftwoodList.where((d) => d.isCured).toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(driftwoodsForTankStreamProvider(tankId));
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        children: [
          if (curingDriftwood.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Curing (${curingDriftwood.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
            ),
            ...curingDriftwood.map(
              (driftwood) => DriftwoodCard(
                driftwood: driftwood,
                onTap: () => _navigateToDetail(context, driftwood),
              ),
            ),
          ],
          if (stableDriftwood.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Stable (${stableDriftwood.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            ...stableDriftwood.map(
              (driftwood) => DriftwoodCard(
                driftwood: driftwood,
                onTap: () => _navigateToDetail(context, driftwood),
              ),
            ),
          ],
        ],
      ),
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
              'Error loading driftwood',
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

  void _navigateToAddDriftwood(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.driftwoodForm,
      arguments: {'tankId': tankId, 'driftwood': null},
    );
  }

  void _navigateToDetail(BuildContext context, DriftwoodEntity driftwood) {
    Navigator.pushNamed(context, AppRouter.driftwoodDetail, arguments: driftwood);
  }
}

