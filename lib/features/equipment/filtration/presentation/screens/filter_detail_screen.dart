import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../router/app_router.dart';
import '../../domain/entities/filter.dart';
import '../controllers/filter_provider.dart';

/// Filter detail screen - displays filter information and actions
class FilterDetailScreen extends ConsumerStatefulWidget {
  const FilterDetailScreen({super.key, required this.filter});

  final FilterEntity filter;

  @override
  ConsumerState<FilterDetailScreen> createState() => _FilterDetailScreenState();
}

class _FilterDetailScreenState extends ConsumerState<FilterDetailScreen> {
  late FilterEntity _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_filter.name),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editFilter),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') _deleteFilter();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(context, colorScheme),
          const SizedBox(height: 24),
          _buildMaintenanceSection(context, colorScheme),
          const SizedBox(height: 24),
          _buildDetailsSection(context, colorScheme),
          if (_filter.notes != null && _filter.notes!.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildNotesSection(context, colorScheme),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _filter.filterType.icon,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _filter.filterType.displayName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (_filter.brand != null || _filter.model != null)
                    Text(
                      [
                        _filter.brand,
                        _filter.model,
                      ].where((s) => s != null).join(' '),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  if (_filter.flowRateLph != null)
                    Text(
                      '${_filter.flowRateLph!.toInt()} L/h flow rate',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceSection(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Maintenance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            _buildMaintenanceRow(
              context,
              colorScheme,
              icon: Icons.cleaning_services,
              title: 'Last Cleaned',
              value: _filter.lastCleanedAt != null
                  ? '${_filter.daysSinceLastCleaned} days ago'
                  : 'Never',
              isOverdue: _filter.isCleaningDue,
              onAction: _recordCleaning,
              actionLabel: 'Record Cleaning',
            ),
            const Divider(height: 24),
            _buildMaintenanceRow(
              context,
              colorScheme,
              icon: Icons.swap_horiz,
              title: 'Media Replaced',
              value: _filter.mediaReplacedAt != null
                  ? '${_filter.daysSinceMediaReplaced} days ago'
                  : 'Never',
              isOverdue: _filter.isMediaReplacementDue,
              onAction: _recordMediaReplacement,
              actionLabel: 'Record Replacement',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceRow(
    BuildContext context,
    ColorScheme colorScheme, {
    required IconData icon,
    required String title,
    required String value,
    required bool isOverdue,
    required VoidCallback onAction,
    required String actionLabel,
  }) {
    return Row(
      children: [
        Icon(icon, color: isOverdue ? colorScheme.error : colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodySmall),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isOverdue ? colorScheme.error : null,
                  fontWeight: isOverdue ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
        TextButton(onPressed: onAction, child: Text(actionLabel)),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              'Cleaning Interval',
              '${_filter.cleaningIntervalDays} days',
            ),
            _buildDetailRow(
              context,
              'Media Replacement Interval',
              '${_filter.mediaReplacementIntervalDays} days',
            ),
            if (_filter.mediaVolumeLiters != null)
              _buildDetailRow(
                context,
                'Media Volume',
                '${_filter.mediaVolumeLiters} L',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(_filter.notes!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Future<void> _editFilter() async {
    final result = await Navigator.pushNamed(
      context,
      AppRouter.filterForm,
      arguments: {'tankId': _filter.tankId, 'filter': _filter},
    );
    if (result == true) {
      final updated = await ref.read(filterByIdProvider(_filter.id!).future);
      if (updated != null && mounted) {
        setState(() => _filter = updated);
      }
    }
  }

  Future<void> _deleteFilter() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Filter'),
        content: Text('Are you sure you want to delete "${_filter.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref
            .read(filterProvider(_filter.tankId).notifier)
            .deleteFilter(_filter.id!);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Filter deleted')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting filter: $e')));
        }
      }
    }
  }

  Future<void> _recordCleaning() async {
    try {
      await ref
          .read(filterProvider(_filter.tankId).notifier)
          .recordCleaning(_filter);
      final updated = await ref.read(filterByIdProvider(_filter.id!).future);
      if (updated != null && mounted) {
        setState(() => _filter = updated);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cleaning recorded')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _recordMediaReplacement() async {
    try {
      await ref
          .read(filterProvider(_filter.tankId).notifier)
          .recordMediaReplacement(_filter);
      final updated = await ref.read(filterByIdProvider(_filter.id!).future);
      if (updated != null && mounted) {
        setState(() => _filter = updated);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Media replacement recorded')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
