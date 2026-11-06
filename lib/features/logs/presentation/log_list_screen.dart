import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../core/theme/color_scheme.dart';

/// Log list screen

class LogListScreen extends StatelessWidget {
  const LogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter options
            },
          ),
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add log entry
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    // TODO: Replace with actual data
    final logs = <dynamic>[];

    if (logs.isEmpty) {
      return const EmptyState(
        icon: Icons.history,
        title: 'No activity yet',
        subtitle: 'Your tank activity will appear here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 88),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        return _buildLogCard(context);
      },
    );
  }

  Widget _buildLogCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AquaPalette.azure.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.water_drop, color: AquaPalette.azure),
        ),
        title: const Text('Water Change'),
        subtitle: const Text('Changed 25% of water'),
        trailing: const Text('2h ago'),
        onTap: () {
          // TODO: View log detail
        },
      ),
    );
  }
}
