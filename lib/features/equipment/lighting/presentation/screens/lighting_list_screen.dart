import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/empty_state.dart';
import '../../../../../router/app_router.dart';
import '../../domain/entities/lighting.dart';
import '../controllers/lighting_provider.dart';
import '../widgets/lighting_card.dart';

/// Lighting list screen - displays all lightings for a tank
class LightingListScreen extends ConsumerWidget {
  const LightingListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightingsAsync = ref.watch(lightingsForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Lighting')),
      body: lightingsAsync.when(
        data: (lightings) => _buildLightingList(context, ref, lightings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddLighting(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLightingList(
    BuildContext context,
    WidgetRef ref,
    List<LightingEntity> lightings,
  ) {
    if (lightings.isEmpty) {
      return EmptyState(
        icon: Icons.lightbulb_outline,
        title: 'No lighting yet',
        subtitle: 'Add your first light to track schedules and maintenance',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddLighting(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Lighting'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(lightingsForTankStreamProvider(tankId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: lightings.length,
        itemBuilder: (context, index) {
          final lighting = lightings[index];
          return LightingCard(
            lighting: lighting,
            onTap: () => _navigateToLightingDetail(context, lighting),
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
              'Failed to load lightings',
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

  void _navigateToAddLighting(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.lightingForm,
      arguments: {'tankId': tankId, 'tankName': tankName},
    );
  }

  void _navigateToLightingDetail(
    BuildContext context,
    LightingEntity lighting,
  ) {
    Navigator.pushNamed(context, AppRouter.lightingDetail, arguments: lighting);
  }
}
