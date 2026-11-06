import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/empty_state.dart';
import '../../../../../router/app_router.dart';
import '../../domain/entities/filter.dart';
import '../controllers/filter_provider.dart';
import '../widgets/filter_card.dart';

/// Filter list screen - displays all filters for a tank
class FilterListScreen extends ConsumerWidget {
  const FilterListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtersAsync = ref.watch(filtersForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Filters')),
      body: filtersAsync.when(
        data: (filters) => _buildFilterList(context, ref, filters),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFilter(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterList(
    BuildContext context,
    WidgetRef ref,
    List<FilterEntity> filters,
  ) {
    if (filters.isEmpty) {
      return EmptyState(
        icon: Icons.filter_alt_outlined,
        title: 'No filters yet',
        subtitle: 'Add your first filter to track maintenance',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddFilter(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Filter'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(filtersForTankStreamProvider(tankId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return FilterCard(
            filter: filter,
            onTap: () => _navigateToFilterDetail(context, filter),
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
              'Failed to load filters',
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

  void _navigateToAddFilter(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.filterForm,
      arguments: {'tankId': tankId},
    );
  }

  void _navigateToFilterDetail(BuildContext context, FilterEntity filter) {
    Navigator.pushNamed(context, AppRouter.filterDetail, arguments: filter);
  }
}
