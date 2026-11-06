import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../router/app_router.dart';
import '../../domain/entities/plant.dart';
import '../controllers/plant_provider.dart';
import '../widgets/plant_card.dart';

/// Plant list screen - displays all plants for a tank
class PlantListScreen extends ConsumerWidget {
  const PlantListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(plantsForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Plants')),
      body: plantsAsync.when(
        data: (plantList) => _buildPlantList(context, ref, plantList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPlant(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPlantList(
    BuildContext context,
    WidgetRef ref,
    List<PlantEntity> plantList,
  ) {
    if (plantList.isEmpty) {
      return EmptyState(
        icon: Icons.grass,
        title: 'No plants yet',
        subtitle: 'Add your first plant to this tank',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddPlant(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Plant'),
        ),
      );
    }

    // Separate active and removed plants
    final activePlants = plantList.where((p) => p.isActive).toList();
    final removedPlants = plantList.where((p) => p.isRemoved).toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(plantsForTankStreamProvider(tankId));
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        children: [
          if (activePlants.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Active (${activePlants.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ...activePlants.map(
              (plant) => PlantCard(
                plant: plant,
                onTap: () => _navigateToPlantDetail(context, plant),
              ),
            ),
          ],
          if (removedPlants.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Removed (${removedPlants.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            ...removedPlants.map(
              (plant) => PlantCard(
                plant: plant,
                onTap: () => _navigateToPlantDetail(context, plant),
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
              'Error loading plants',
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

  void _navigateToAddPlant(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.plantForm,
      arguments: {'tankId': tankId, 'plant': null},
    );
  }

  void _navigateToPlantDetail(BuildContext context, PlantEntity plant) {
    Navigator.pushNamed(context, AppRouter.plantDetail, arguments: plant);
  }
}
