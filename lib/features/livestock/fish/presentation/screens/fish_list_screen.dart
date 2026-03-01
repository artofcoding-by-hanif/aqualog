import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/empty_state.dart';
import '../../../../../router/app_router.dart';
import '../../domain/entities/fish.dart';
import '../controllers/fish_provider.dart';
import '../widgets/fish_card.dart';

/// Fish list screen - displays all fish for a tank
class FishListScreen extends ConsumerWidget {
  const FishListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fishAsync = ref.watch(fishForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(
        title: Text('$tankName Fish'),
      ),
      body: fishAsync.when(
        data: (fishList) => _buildFishList(context, ref, fishList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFish(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFishList(
    BuildContext context,
    WidgetRef ref,
    List<FishEntity> fishList,
  ) {
    if (fishList.isEmpty) {
      return EmptyState(
        icon: Icons.pets,
        title: 'No fish yet',
        subtitle: 'Add your first fish to this tank',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddFish(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Fish'),
        ),
      );
    }

    // Separate alive and deceased fish
    final aliveFish = fishList.where((f) => f.isAlive).toList();
    final deceasedFish = fishList.where((f) => f.isDeceased).toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(fishForTankStreamProvider(tankId));
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        children: [
          if (aliveFish.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Active (${aliveFish.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            ...aliveFish.map(
              (fish) => FishCard(
                fish: fish,
                onTap: () => _navigateToFishDetail(context, fish),
              ),
            ),
          ],
          if (deceasedFish.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Deceased (${deceasedFish.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ),
            ...deceasedFish.map(
              (fish) => FishCard(
                fish: fish,
                onTap: () => _navigateToFishDetail(context, fish),
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
              'Error loading fish',
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

  void _navigateToAddFish(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.fishForm,
      arguments: {'tankId': tankId, 'fish': null},
    );
  }

  void _navigateToFishDetail(BuildContext context, FishEntity fish) {
    Navigator.pushNamed(context, AppRouter.fishDetail, arguments: fish);
  }
}

