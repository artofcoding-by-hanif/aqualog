import 'package:flutter/material.dart';

/// Timeline screen

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timeline')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildTimelineItem(context, index);
        },
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, int index) {
    final isLast = index == 9;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '${10 - index}d ago',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Card(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getEventTitle(index),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getEventDescription(index),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getEventTitle(int index) {
    final events = [
      'Water Change',
      'Fed Fish',
      'Added Plants',
      'Parameter Test',
      'Filter Cleaned',
      'Water Change',
      'Fed Fish',
      'Added CO2',
      'Water Change',
      'Tank Setup',
    ];
    return events[index % events.length];
  }

  String _getEventDescription(int index) {
    final descriptions = [
      'Changed 25% of water',
      'Fed flake food',
      'Added 3 Java Ferns',
      'pH: 7.0, Ammonia: 0',
      'Cleaned filter media',
      'Changed 30% of water',
      'Fed bloodworms',
      'Refilled CO2 tank',
      'Changed 25% of water',
      'Initial tank setup',
    ];
    return descriptions[index % descriptions.length];
  }
}
