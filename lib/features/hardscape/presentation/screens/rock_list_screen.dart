import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../router/app_router.dart';
import '../../domain/entities/rock.dart';
import '../controllers/rock_provider.dart';
import '../widgets/rock_card.dart';

/// Rock list screen - displays all rocks for a tank
class RockListScreen extends ConsumerWidget {
  const RockListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocksAsync = ref.watch(rocksForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(
        title: Text('$tankName Rocks'),
      ),
      body: rocksAsync.when(
        data: (rockList) => _buildRockList(context, ref, rockList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddRock(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRockList(
    BuildContext context,
    WidgetRef ref,
    List<RockEntity> rockList,
  ) {
    if (rockList.isEmpty) {
      return EmptyState(
        icon: Icons.landscape,
        title: 'No rocks yet',
        subtitle: 'Add your first rock to this tank',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddRock(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Rock'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(rocksForTankStreamProvider(tankId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: rockList.length,
        itemBuilder: (context, index) {
          final rock = rockList[index];
          return RockCard(
            rock: rock,
            onTap: () => _navigateToRockDetail(context, rock),
          );
        },
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
              'Error loading rocks',
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

  void _navigateToAddRock(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.rockForm,
      arguments: {'tankId': tankId, 'rock': null},
    );
  }

  void _navigateToRockDetail(BuildContext context, RockEntity rock) {
    Navigator.pushNamed(context, AppRouter.rockDetail, arguments: rock);
  }
}

