import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/substrate_layer.dart';
import 'controllers/substrate_layer_provider.dart';
import 'substrate_layer_form.dart';
import 'widgets/substrate_layer_card.dart';
import '../../../router/aqua_page_route.dart';
import '../../../core/theme/color_scheme.dart';

/// Substrate editor screen for managing substrate layers
class SubstrateEditor extends ConsumerStatefulWidget {
  const SubstrateEditor({super.key, required this.tankId});

  /// Tank ID this substrate belongs to
  final int tankId;

  @override
  ConsumerState<SubstrateEditor> createState() => _SubstrateEditorState();
}

class _SubstrateEditorState extends ConsumerState<SubstrateEditor> {
  List<SubstrateLayerEntity> _localLayers = [];
  bool _hasReordered = false;

  @override
  Widget build(BuildContext context) {
    final layersAsync = ref.watch(
      substrateLayersForTankStreamProvider(widget.tankId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Substrate Layers'),
        actions: [
          if (_hasReordered)
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Save Order',
              onPressed: _saveOrder,
            ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Layer',
            onPressed: _addLayer,
          ),
        ],
      ),
      body: layersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: AquaPalette.danger,
              ),
              const SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
        data: (layers) {
          // Update local layers if not reordering
          if (!_hasReordered) {
            _localLayers = List.from(layers);
          }

          if (_localLayers.isEmpty) {
            return _buildEmptyState();
          }

          return _buildLayerList();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.layers_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No substrate layers',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first layer',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _addLayer,
            icon: const Icon(Icons.add),
            label: const Text('Add Layer'),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerList() {
    return Column(
      children: [
        // Info banner
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Drag layers to reorder. Layer 1 is at the bottom of your tank.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Layer list
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _localLayers.length,
            onReorder: _onReorder,
            itemBuilder: (context, index) {
              final layer = _localLayers[index];
              return SubstrateLayerCard(
                key: ValueKey(layer.id),
                layer: layer,
                onTap: () => _editLayer(layer),
                onEdit: () => _editLayer(layer),
                onDelete: () => _confirmDelete(layer),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _localLayers.removeAt(oldIndex);
      _localLayers.insert(newIndex, item);
      _hasReordered = true;
    });
  }

  Future<void> _saveOrder() async {
    try {
      final layerIds = _localLayers.map((l) => l.id!).toList();
      await ref
          .read(substrateLayerProvider.notifier)
          .reorderLayers(widget.tankId, layerIds);

      setState(() => _hasReordered = false);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Layer order saved')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving order: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _addLayer() async {
    final result = await Navigator.push<bool>(
      context,
      AquaPageRoute(
        builder: (context) => SubstrateLayerFormScreen(
          tankId: widget.tankId,
          nextLayerOrder: _localLayers.length,
        ),
      ),
    );

    if (result == true) {
      setState(() => _hasReordered = false);
    }
  }

  Future<void> _editLayer(SubstrateLayerEntity layer) async {
    final result = await Navigator.push<bool>(
      context,
      AquaPageRoute(
        builder: (context) =>
            SubstrateLayerFormScreen(tankId: widget.tankId, layer: layer),
      ),
    );

    if (result == true) {
      setState(() => _hasReordered = false);
    }
  }

  Future<void> _confirmDelete(SubstrateLayerEntity layer) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Layer'),
        content: Text('Are you sure you want to delete "${layer.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(substrateLayerProvider.notifier).deleteLayer(layer.id!);

        setState(() => _hasReordered = false);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Layer deleted')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting layer: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }
}
