import 'package:flutter/material.dart';

/// Parameter entry screen

class ParameterEntryScreen extends StatefulWidget {
  const ParameterEntryScreen({super.key});

  @override
  State<ParameterEntryScreen> createState() => _ParameterEntryScreenState();
}

class _ParameterEntryScreenState extends State<ParameterEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phController = TextEditingController();
  final _ammoniaController = TextEditingController();
  final _nitriteController = TextEditingController();
  final _nitrateController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  void dispose() {
    _phController.dispose();
    _ammoniaController.dispose();
    _nitriteController.dispose();
    _nitrateController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Parameters'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildParameterField(
              controller: _phController,
              label: 'pH',
              hint: 'e.g., 7.0',
              suffix: '',
            ),
            const SizedBox(height: 16),
            _buildParameterField(
              controller: _ammoniaController,
              label: 'Ammonia (NH3)',
              hint: 'e.g., 0',
              suffix: 'ppm',
            ),
            const SizedBox(height: 16),
            _buildParameterField(
              controller: _nitriteController,
              label: 'Nitrite (NO2)',
              hint: 'e.g., 0',
              suffix: 'ppm',
            ),
            const SizedBox(height: 16),
            _buildParameterField(
              controller: _nitrateController,
              label: 'Nitrate (NO3)',
              hint: 'e.g., 10',
              suffix: 'ppm',
            ),
            const SizedBox(height: 16),
            _buildParameterField(
              controller: _temperatureController,
              label: 'Temperature',
              hint: 'e.g., 25',
              suffix: '°C',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saveParameters,
              child: const Text('Save Parameters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String suffix,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixText: suffix,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  void _saveParameters() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save parameters
      Navigator.of(context).pop();
    }
  }
}

