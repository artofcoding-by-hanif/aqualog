import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/glass_calculation.dart';
import '../controllers/glass_calculation_provider.dart';
import '../../../../core/theme/color_scheme.dart';

/// Screen to display saved glass calculations
class SavedGlassCalculationsScreen extends ConsumerWidget {
  const SavedGlassCalculationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculationsAsync = ref.watch(glassCalculationsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Calculations'),
      ),
      body: calculationsAsync.when(
        data: (calculations) {
          if (calculations.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calculate_outlined, size: 64, color: AquaPalette.mist),
                  SizedBox(height: 16),
                  Text('No saved calculations yet'),
                  SizedBox(height: 8),
                  Text(
                    'Use the calculator to create and save\nglass calculations for your tanks.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AquaPalette.mist),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: calculations.length,
            itemBuilder: (context, index) {
              return _CalculationCard(
                calculation: calculations[index],
                onDelete: () => _deleteCalculation(context, ref, calculations[index]),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _deleteCalculation(
    BuildContext context,
    WidgetRef ref,
    GlassCalculationEntity calculation,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Calculation'),
        content: Text('Delete "${calculation.name}"?'),
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

    if (confirmed == true && calculation.id != null) {
      final repo = ref.read(glassCalculationRepositoryProvider);
      await repo.deleteCalculation(calculation.id!);
    }
  }
}

class _CalculationCard extends StatelessWidget {
  final GlassCalculationEntity calculation;
  final VoidCallback onDelete;

  const _CalculationCard({
    required this.calculation,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(calculation.name),
        subtitle: Text(
          '${calculation.lengthMm.toStringAsFixed(0)} × ${calculation.widthMm.toStringAsFixed(0)} × ${calculation.heightMm.toStringAsFixed(0)} mm  •  ${calculation.volumeLiters.toStringAsFixed(1)} L',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow('Glass Thickness', '${calculation.glassThicknessMm.toStringAsFixed(0)} mm'),
                _buildRow('Glue Thickness', '${calculation.glueThicknessMm.toStringAsFixed(0)} mm'),
                const Divider(),
                Text('Glass Dimensions', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                _buildRow('Bottom', '${calculation.bottomLengthMm.toStringAsFixed(0)} × ${calculation.bottomWidthMm.toStringAsFixed(0)} mm'),
                _buildRow('Front/Back (×2)', '${calculation.frontBackLengthMm.toStringAsFixed(0)} × ${calculation.frontBackHeightMm.toStringAsFixed(0)} mm'),
                _buildRow('Side (×2)', '${calculation.sideWidthMm.toStringAsFixed(0)} × ${calculation.sideHeightMm.toStringAsFixed(0)} mm'),
                const Divider(),
                _buildRow('Total Glass Area', '${calculation.totalGlassAreaSqM.toStringAsFixed(3)} m²'),
                _buildRow('Estimated Weight', '${calculation.estimatedWeightKg.toStringAsFixed(1)} kg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

