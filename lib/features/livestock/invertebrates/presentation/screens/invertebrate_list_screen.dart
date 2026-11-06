import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/empty_state.dart';
import '../../../../../router/app_router.dart';
import '../../domain/entities/invertebrate.dart';
import '../controllers/invertebrate_provider.dart';
import '../widgets/invertebrate_card.dart';

/// Invertebrate list screen - displays all invertebrates for a tank
class InvertebrateListScreen extends ConsumerWidget {
  const InvertebrateListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invertebratesAsync = ref.watch(
      invertebratesForTankStreamProvider(tankId),
    );

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Invertebrates')),
      body: invertebratesAsync.when(
        data: (invertebrates) =>
            _buildInvertebrateList(context, ref, invertebrates),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddInvertebrate(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInvertebrateList(
    BuildContext context,
    WidgetRef ref,
    List<InvertebrateEntity> invertebrates,
  ) {
    if (invertebrates.isEmpty) {
      return EmptyState(
        icon: Icons.bug_report,
        title: 'No invertebrates yet',
        subtitle: 'Add your first invertebrate to this tank',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddInvertebrate(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Invertebrate'),
        ),
      );
    }

    // Separate alive and deceased invertebrates
    final alive = invertebrates.where((i) => i.isAlive).toList();
    final deceased = invertebrates.where((i) => i.isDeceased).toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(invertebratesForTankStreamProvider(tankId));
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        children: [
          if (alive.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Active (${alive.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ...alive.map(
              (invertebrate) => InvertebrateCard(
                invertebrate: invertebrate,
                onTap: () =>
                    _navigateToInvertebrateDetail(context, invertebrate),
              ),
            ),
          ],
          if (deceased.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Deceased (${deceased.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            ...deceased.map(
              (invertebrate) => InvertebrateCard(
                invertebrate: invertebrate,
                onTap: () =>
                    _navigateToInvertebrateDetail(context, invertebrate),
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
              'Error loading invertebrates',
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

  void _navigateToAddInvertebrate(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.invertebrateForm,
      arguments: {'tankId': tankId, 'invertebrate': null},
    );
  }

  void _navigateToInvertebrateDetail(
    BuildContext context,
    InvertebrateEntity invertebrate,
  ) {
    Navigator.pushNamed(
      context,
      AppRouter.invertebrateDetail,
      arguments: invertebrate,
    );
  }
}
