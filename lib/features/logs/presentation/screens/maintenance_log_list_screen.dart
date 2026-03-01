import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../router/app_router.dart';
import '../../domain/entities/maintenance_log.dart';
import '../controllers/maintenance_log_provider.dart';
import '../widgets/maintenance_log_card.dart';

/// Maintenance log list screen - displays all maintenance logs for a tank
class MaintenanceLogListScreen extends ConsumerWidget {
  const MaintenanceLogListScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(maintenanceLogsForTankStreamProvider(tankId));

    return Scaffold(
      appBar: AppBar(title: Text('$tankName Logs')),
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
    List<MaintenanceLogEntity> logs,
  ) {
    if (logs.isEmpty) {
      return EmptyState(
        icon: Icons.history,
        title: 'No maintenance logs yet',
        subtitle: 'Add your first maintenance log for this tank',
        action: FilledButton.icon(
          onPressed: () => _navigateToAddLog(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Log'),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(maintenanceLogsForTankStreamProvider(tankId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return MaintenanceLogCard(
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
              'Error loading logs',
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
      AppRouter.maintenanceLogForm,
      arguments: {'tankId': tankId, 'tankName': tankName, 'log': null},
    );
  }

  void _navigateToEditLog(BuildContext context, MaintenanceLogEntity log) {
    Navigator.pushNamed(
      context,
      AppRouter.maintenanceLogForm,
      arguments: {'tankId': tankId, 'tankName': tankName, 'log': log},
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    MaintenanceLogEntity log,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Log'),
        content: Text('Are you sure you want to delete "${log.title}"?'),
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
          .read(maintenanceLogProvider(tankId).notifier)
          .deleteLog(log.id!, tankId);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Log deleted')));
      }
    }
  }
}
