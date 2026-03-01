import 'package:flutter/material.dart';

/// Parameter chart widget

class ParameterChart extends StatelessWidget {
  const ParameterChart({
    super.key,
    required this.parameterType,
  });

  final String parameterType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$parameterType History'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('Chart placeholder\n(Implement with fl_chart or similar)'),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${7.0 + (index * 0.1)}'),
                  subtitle: Text('${10 - index} days ago'),
                  trailing: _getStatusIcon(7.0 + (index * 0.1)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStatusIcon(double value) {
    // TODO: Check against ideal range
    if (value >= 6.5 && value <= 7.5) {
      return const Icon(Icons.check_circle, color: Colors.green);
    } else if (value >= 6.0 && value <= 8.0) {
      return const Icon(Icons.warning, color: Colors.orange);
    } else {
      return const Icon(Icons.error, color: Colors.red);
    }
  }
}

