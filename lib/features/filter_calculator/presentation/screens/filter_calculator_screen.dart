import 'package:flutter/material.dart';

import '../../domain/entities/filter_type.dart';
import '../../domain/entities/filter_recommendation.dart';
import '../../domain/entities/filter_media_type.dart';
import '../../domain/entities/filter_media_data.dart';

class FilterCalculatorScreen extends StatefulWidget {
  const FilterCalculatorScreen({super.key});

  @override
  State<FilterCalculatorScreen> createState() => _FilterCalculatorScreenState();
}

class _FilterCalculatorScreenState extends State<FilterCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tankVolumeController = TextEditingController();
  BioloadLevel _selectedBioload = BioloadLevel.medium;

  List<FilterRecommendation>? _recommendations;
  int? _recommendedFlow;

  @override
  void dispose() {
    _tankVolumeController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final tankLiters = double.parse(_tankVolumeController.text);
    final flow = FilterCalculator.calculateRecommendedFlow(
      tankLiters: tankLiters,
      bioload: _selectedBioload,
    );
    final recommendations = FilterCalculator.getRecommendations(
      tankLiters: tankLiters,
      bioload: _selectedBioload,
    );

    setState(() {
      _recommendedFlow = flow;
      _recommendations = recommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputSection(),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate'),
              ),
              if (_recommendations != null) ...[
                const SizedBox(height: 24),
                _buildResultsSection(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tank Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tankVolumeController,
              decoration: const InputDecoration(
                labelText: 'Tank Volume (Liters)',
                hintText: 'e.g., 100',
                suffixText: 'L',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter tank volume';
                }
                final parsed = double.tryParse(value);
                if (parsed == null || parsed <= 0) {
                  return 'Please enter a valid volume';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<BioloadLevel>(
              initialValue: _selectedBioload,
              decoration: const InputDecoration(labelText: 'Bioload Level'),
              items: BioloadLevel.values.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedBioload = value);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              _getBioloadDescription(_selectedBioload),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getBioloadDescription(BioloadLevel level) {
    switch (level) {
      case BioloadLevel.low:
        return 'Shrimp, Betta, few small fish';
      case BioloadLevel.lowMedium:
        return 'Small community, nano fish';
      case BioloadLevel.medium:
        return 'Standard community tank';
      case BioloadLevel.mediumHigh:
        return 'Planted with many fish, small cichlids';
      case BioloadLevel.high:
        return 'Goldfish, large cichlids, heavy stocking';
    }
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended Flow Rate',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        '$_recommendedFlow L/H',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Suitable Filters',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (_recommendations!.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No suitable filters found for this tank size.'),
            ),
          )
        else
          ..._recommendations!.map((rec) => _buildFilterCard(rec)),
      ],
    );
  }

  Widget _buildFilterCard(FilterRecommendation rec) {
    final filter = rec.filterType;
    final suitableMedia = FilterMediaData.getMediaForFilter(filter.name);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(
          rec.isIdealMatch ? Icons.check_circle : Icons.info_outline,
          color: rec.isIdealMatch
              ? Colors.green
              : Theme.of(context).colorScheme.outline,
        ),
        title: Text(filter.name),
        subtitle: Text(
          '${filter.flowMinLph}-${filter.flowMaxLph} L/H • ${filter.powerMinW}-${filter.powerMaxW}W',
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Installation', filter.installation),
                _buildInfoRow(
                  'Tank Size',
                  '${filter.tankSizeMinL}-${filter.tankSizeMaxL} L',
                ),
                _buildInfoRow('Fish Suitability', filter.fishSuitability),
                _buildInfoRow('Bioload', filter.bioloadLevel.displayName),
                _buildInfoRow('Noise', filter.noiseLevel),
                _buildInfoRow('Maintenance', filter.maintenanceFrequency),
                const Divider(),
                _buildInfoRow('Pros', filter.pros, isMultiLine: true),
                _buildInfoRow('Cons', filter.cons, isMultiLine: true),
                if (filter.notes.isNotEmpty)
                  _buildInfoRow('Notes', filter.notes, isMultiLine: true),
                if (suitableMedia.isNotEmpty) ...[
                  const Divider(),
                  _buildMediaSection(suitableMedia),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection(List<FilterMediaType> mediaList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended Media',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...mediaList.map((media) => _buildMediaChip(media)),
      ],
    );
  }

  Widget _buildMediaChip(FilterMediaType media) {
    final categoryColor = _getCategoryColor(media.category);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(left: 16, bottom: 8),
        leading: Icon(
          _getCategoryIcon(media.category),
          color: categoryColor,
          size: 20,
        ),
        title: Text(media.name, style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(
          '${media.category.displayName} • ${media.replaceOrRinse}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Function', media.primaryFunction),
              _buildInfoRow('Lifespan', '${media.lifespanMonths} months'),
              _buildInfoRow('Bioload Support', media.bioloadSupport),
              _buildInfoRow('Flow Resistance', media.flowResistance),
              _buildInfoRow('Pros', media.pros, isMultiLine: true),
              _buildInfoRow('Cons', media.cons, isMultiLine: true),
              if (media.notes.isNotEmpty)
                _buildInfoRow('Notes', media.notes, isMultiLine: true),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(MediaCategory category) {
    switch (category) {
      case MediaCategory.mechanical:
        return Colors.blue;
      case MediaCategory.biological:
        return Colors.green;
      case MediaCategory.chemical:
        return Colors.orange;
      case MediaCategory.mechanicalBiological:
        return Colors.teal;
    }
  }

  IconData _getCategoryIcon(MediaCategory category) {
    switch (category) {
      case MediaCategory.mechanical:
        return Icons.filter_alt;
      case MediaCategory.biological:
        return Icons.eco;
      case MediaCategory.chemical:
        return Icons.science;
      case MediaCategory.mechanicalBiological:
        return Icons.layers;
    }
  }

  Widget _buildInfoRow(String label, String value, {bool isMultiLine = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: isMultiLine
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(value),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(child: Text(value)),
              ],
            ),
    );
  }
}
