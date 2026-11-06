import 'package:flutter/material.dart';

/// Knowledge detail screen

class KnowledgeDetailScreen extends StatelessWidget {
  const KnowledgeDetailScreen({
    super.key,
    required this.id,
    required this.type, // 'fish' or 'plant'
  });

  final String id;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == 'fish' ? 'Fish Details' : 'Plant Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildSection(context, 'Overview', [
              _buildInfoRow('Scientific Name', 'Species name'),
              _buildInfoRow('Family', 'Family name'),
              _buildInfoRow('Origin', 'Region'),
              _buildInfoRow('Care Level', 'Easy'),
            ]),
            const SizedBox(height: 16),
            _buildSection(context, 'Requirements', [
              _buildInfoRow('Temperature', '24-28°C'),
              _buildInfoRow('pH', '6.5-7.5'),
              if (type == 'fish') _buildInfoRow('Min Tank Size', '40L'),
              if (type == 'plant') _buildInfoRow('Light', 'Low to Medium'),
            ]),
            const SizedBox(height: 16),
            _buildSection(context, 'Description', []),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Detailed description of the ${type == 'fish' ? 'fish species' : 'plant species'} goes here. '
                'This would include care tips, breeding information, and other helpful details.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              type == 'fish' ? Icons.pets : Icons.eco,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Common Name',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Scientific name',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        if (children.isNotEmpty) Card(child: Column(children: children)),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
