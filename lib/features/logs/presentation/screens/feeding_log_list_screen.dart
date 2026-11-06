import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../router/app_router.dart';
import '../../domain/entities/feeding_log.dart';
import '../controllers/feeding_log_provider.dart';
import '../widgets/feeding_log_card.dart';

/// Feeding log list screen - displays all feeding logs for a tank
class FeedingLogListScreen extends ConsumerWidget {
  const FeedingLogListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(feedingLogsForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Feeding Log')),
      body: logsAsync.when(
        data: (logs) => _buildLogList(context, ref, logs),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddLog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLogList(
    BuildContext context,
    WidgetRef ref,
    List<FeedingLogEntity> logs,
  ) {
    if (logs.isEmpty) {
      return EmptyState(
        icon: Icons.restaurant,
        title: 'No feeding logs yet',
        subtitle: 'Track your fish feeding habits here',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddLog(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Feeding'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(feedingLogsForTankStreamProvider(tankId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return FeedingLogCard(
            log: log,
            onTap: () => _navigateToEditLog(context, log),
            onDelete: () => _confirmDelete(context, ref, log),
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
              'Error loading feeding logs',
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

  void _navigateToAddLog(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.feedingLogForm,
      arguments: {'tankId': tankId, 'tankName': tankName, 'log': null},
    );
  }

  void _navigateToEditLog(BuildContext context, FeedingLogEntity log) {
    Navigator.pushNamed(
      context,
      AppRouter.feedingLogForm,
      arguments: {'tankId': tankId, 'tankName': tankName, 'log': log},
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    FeedingLogEntity log,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Feeding Log'),
        content: Text('Are you sure you want to delete "${log.displayTitle}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref
          .read(feedingLogProvider(tankId).notifier)
          .deleteLog(log.id!, tankId);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Feeding log deleted')));
      }
    }
  }
}
