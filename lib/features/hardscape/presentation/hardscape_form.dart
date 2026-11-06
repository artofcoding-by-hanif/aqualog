import 'package:flutter/material.dart';

/// Hardscape form widget

class HardscapeForm extends StatefulWidget {
  const HardscapeForm({super.key});

  @override
  State<HardscapeForm> createState() => _HardscapeFormState();
}

class _HardscapeFormState extends State<HardscapeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  String _category = 'rock';
  String _type = 'dragon_stone';

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Hardscape')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: const [
                DropdownMenuItem(value: 'rock', child: Text('Rock')),
                DropdownMenuItem(value: 'driftwood', child: Text('Driftwood')),
              ],
              onChanged: (value) {
                setState(() {
                  _category = value!;
                  _type = _category == 'rock' ? 'dragon_stone' : 'manzanita';
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(labelText: 'Type'),
              items: _category == 'rock'
                  ? const [
                      DropdownMenuItem(
                        value: 'dragon_stone',
                        child: Text('Dragon Stone'),
                      ),
                      DropdownMenuItem(
                        value: 'seiryu',
                        child: Text('Seiryu Stone'),
                      ),
                      DropdownMenuItem(
                        value: 'lava_rock',
                        child: Text('Lava Rock'),
                      ),
                      DropdownMenuItem(value: 'slate', child: Text('Slate')),
                    ]
                  : const [
                      DropdownMenuItem(
                        value: 'manzanita',
                        child: Text('Manzanita'),
                      ),
                      DropdownMenuItem(
                        value: 'spider_wood',
                        child: Text('Spider Wood'),
                      ),
                      DropdownMenuItem(
                        value: 'malaysian',
                        child: Text('Malaysian'),
                      ),
                      DropdownMenuItem(value: 'mopani', child: Text('Mopani')),
                    ],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saveHardscape,
              child: const Text('Add Hardscape'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveHardscape() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save hardscape
      Navigator.of(context).pop();
    }
  }
}
