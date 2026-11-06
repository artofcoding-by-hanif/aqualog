import 'package:flutter/material.dart';

/// Photoperiod editor widget

class PhotoperiodEditor extends StatefulWidget {
  const PhotoperiodEditor({super.key});

  @override
  State<PhotoperiodEditor> createState() => _PhotoperiodEditorState();
}

class _PhotoperiodEditorState extends State<PhotoperiodEditor> {
  final List<PhotoperiodItem> _periods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Schedule'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addPeriod),
        ],
      ),
      body: _periods.isEmpty
          ? const Center(child: Text('No schedule set. Tap + to add a period.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _periods.length,
              itemBuilder: (context, index) {
                final period = _periods[index];
                return Card(
                  child: ListTile(
                    title: Text('${period.startTime} - ${period.endTime}'),
                    subtitle: Text('Intensity: ${period.intensity}%'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _periods.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _addPeriod() {
    // TODO: Show time picker dialog
    setState(() {
      _periods.add(
        PhotoperiodItem(startTime: '08:00', endTime: '20:00', intensity: 100),
      );
    });
  }
}

class PhotoperiodItem {
  final String startTime;
  final String endTime;
  final int intensity;

  PhotoperiodItem({
    required this.startTime,
    required this.endTime,
    required this.intensity,
  });
}
