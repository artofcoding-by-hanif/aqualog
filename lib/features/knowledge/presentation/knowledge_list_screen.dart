import 'package:flutter/material.dart';

/// Knowledge list screen

class KnowledgeListScreen extends StatelessWidget {
  const KnowledgeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Knowledge Base'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Fish'),
              Tab(text: 'Plants'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFishList(context),
            _buildPlantList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFishList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildKnowledgeCard(
          context,
          title: 'Betta Fish',
          subtitle: 'Betta splendens',
          icon: Icons.pets,
        ),
        _buildKnowledgeCard(
          context,
          title: 'Neon Tetra',
          subtitle: 'Paracheirodon innesi',
          icon: Icons.pets,
        ),
        _buildKnowledgeCard(
          context,
          title: 'Guppy',
          subtitle: 'Poecilia reticulata',
          icon: Icons.pets,
        ),
      ],
    );
  }

  Widget _buildPlantList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildKnowledgeCard(
          context,
          title: 'Java Fern',
          subtitle: 'Microsorum pteropus',
          icon: Icons.eco,
        ),
        _buildKnowledgeCard(
          context,
          title: 'Anubias',
          subtitle: 'Anubias barteri',
          icon: Icons.eco,
        ),
        _buildKnowledgeCard(
          context,
          title: 'Amazon Sword',
          subtitle: 'Echinodorus amazonicus',
          icon: Icons.eco,
        ),
      ],
    );
  }

  Widget _buildKnowledgeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to knowledge detail
        },
      ),
    );
  }
}

