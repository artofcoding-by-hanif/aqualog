import 'package:flutter/material.dart';

/// Heater form widget

class HeaterForm extends StatefulWidget {
  const HeaterForm({super.key});

  @override
  State<HeaterForm> createState() => _HeaterFormState();
}

class _HeaterFormState extends State<HeaterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _wattageController = TextEditingController();
  final _temperatureController = TextEditingController();

  bool _hasThermometer = false;

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _wattageController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Heater')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Heater Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Brand (optional)'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _wattageController,
              decoration: const InputDecoration(
                labelText: 'Wattage (optional)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _temperatureController,
              decoration: const InputDecoration(
                labelText: 'Target Temperature (°C)',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter target temperature';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Has built-in thermometer'),
              value: _hasThermometer,
              onChanged: (value) {
                setState(() {
                  _hasThermometer = value;
                });
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saveHeater,
              child: const Text('Save Heater'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveHeater() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save heater
      Navigator.of(context).pop();
    }
  }
}
