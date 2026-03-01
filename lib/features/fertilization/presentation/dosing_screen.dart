import 'package:flutter/material.dart';

/// Dosing screen widget

class DosingScreen extends StatelessWidget {
  const DosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertilization'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add fertilizer
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(context, 'Today\'s Doses', [
            _buildDoseCard(
              context,
              name: 'Macro Fertilizer',
              dose: '5 ml',
              isDone: false,
            ),
            _buildDoseCard(
              context,
              name: 'Micro Fertilizer',
              dose: '3 ml',
              isDone: true,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, 'My Fertilizers', [
            _buildFertilizerCard(
              context,
              name: 'Macro Fertilizer',
              type: 'Macro',
              dose: '5 ml daily',
            ),
            _buildFertilizerCard(
              context,
              name: 'Micro Fertilizer',
              type: 'Micro',
              dose: '3 ml alternate days',
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildDoseCard(
    BuildContext context, {
    required String name,
    required String dose,
    required bool isDone,
  }) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (value) {
            // TODO: Mark dose as done
          },
        ),
        title: Text(name),
        subtitle: Text(dose),
      ),
    );
  }

  Widget _buildFertilizerCard(
    BuildContext context, {
    required String name,
    required String type,
    required String dose,
  }) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('$type • $dose'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Edit fertilizer
        },
      ),
    );
  }
}

