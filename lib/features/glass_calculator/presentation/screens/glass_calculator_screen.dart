import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/app_router.dart';
import '../../domain/entities/glass_calculation.dart';
import '../controllers/glass_calculation_provider.dart';

/// Glass calculator screen for calculating tank glass dimensions
class GlassCalculatorScreen extends ConsumerStatefulWidget {
  const GlassCalculatorScreen({super.key});

  @override
  ConsumerState<GlassCalculatorScreen> createState() =>
      _GlassCalculatorScreenState();
}

class _GlassCalculatorScreenState extends ConsumerState<GlassCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _glassThicknessController = TextEditingController();
  final _glueThicknessController = TextEditingController(text: '1');
  final _nameController = TextEditingController();

  GlassCalculationEntity? _result;
  bool _showResults = false;

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _glassThicknessController.dispose();
    _glueThicknessController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onHeightChanged(String value) {
    final height = double.tryParse(value);
    if (height != null && height > 0) {
      final suggestedThickness = GlassCalculationEntity.suggestGlassThickness(
        height,
      );
      _glassThicknessController.text = suggestedThickness.toStringAsFixed(0);
    }
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final length = double.parse(_lengthController.text);
    final width = double.parse(_widthController.text);
    final height = double.parse(_heightController.text);
    final glassThickness = double.parse(_glassThicknessController.text);
    final glueThickness = double.parse(_glueThicknessController.text);

    setState(() {
      _result = GlassCalculationEntity.calculate(
        name: 'Calculation',
        lengthMm: length,
        widthMm: width,
        heightMm: height,
        glassThicknessMm: glassThickness,
        glueThicknessMm: glueThickness,
      );
      _showResults = true;
    });
  }

  Future<void> _saveCalculation() async {
    if (_result == null) return;

    final name = await showDialog<String>(
      context: context,
      builder: (context) => _SaveDialog(controller: _nameController),
    );

    if (name == null || name.isEmpty) return;

    final calculation = _result!.copyWith(name: name);
    final repo = ref.read(glassCalculationRepositoryProvider);
    await repo.saveCalculation(calculation);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Calculation saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glass Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Saved Calculations',
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.savedGlassCalculations);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputSection(),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate'),
              ),
              if (_showResults && _result != null) ...[
                const SizedBox(height: 24),
                _buildResultsSection(),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _saveCalculation,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Calculation'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tank Dimensions (mm)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _lengthController,
                    label: 'Length',
                    hint: 'e.g. 600',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _widthController,
                    label: 'Width',
                    hint: 'e.g. 300',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _heightController,
                    label: 'Height',
                    hint: 'e.g. 400',
                    onChanged: _onHeightChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Glass Settings (mm)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _glassThicknessController,
                    label: 'Glass Thickness',
                    hint: 'Auto-suggested',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _glueThicknessController,
                    label: 'Glue Thickness',
                    hint: 'Default: 1',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (double.tryParse(value) == null) {
          return 'Invalid';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget _buildResultsSection() {
    final result = _result!;
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            _buildResultRow(
              'Volume',
              '${result.volumeLiters.toStringAsFixed(1)} L',
            ),
            const Divider(),
            Text(
              'Glass Dimensions',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            _buildResultRow(
              'Bottom',
              '${result.bottomLengthMm.toStringAsFixed(0)} × ${result.bottomWidthMm.toStringAsFixed(0)} mm',
            ),
            _buildResultRow(
              'Front/Back (×2)',
              '${result.frontBackLengthMm.toStringAsFixed(0)} × ${result.frontBackHeightMm.toStringAsFixed(0)} mm',
            ),
            _buildResultRow(
              'Side (×2)',
              '${result.sideWidthMm.toStringAsFixed(0)} × ${result.sideHeightMm.toStringAsFixed(0)} mm',
            ),
            const Divider(),
            _buildResultRow(
              'Total Glass Area',
              '${result.totalGlassAreaSqM.toStringAsFixed(3)} m²',
            ),
            _buildResultRow(
              'Estimated Weight',
              '${result.estimatedWeightKg.toStringAsFixed(1)} kg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _SaveDialog extends StatelessWidget {
  final TextEditingController controller;

  const _SaveDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Calculation'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Name',
          hintText: 'e.g. 60cm Living Room Tank',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
