import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/water_parameter_log.dart';
import '../controllers/water_parameter_log_provider.dart';

/// Water parameter log form screen for adding/editing parameter logs
class WaterParameterLogFormScreen extends ConsumerStatefulWidget {
  const WaterParameterLogFormScreen({
    super.key,
    required this.tankId,
    required this.tankName,
    this.log,
  });

  final int tankId;
  final String tankName;
  final WaterParameterLogEntity? log;

  bool get isEditing => log != null;

  @override
  ConsumerState<WaterParameterLogFormScreen> createState() =>
      _WaterParameterLogFormScreenState();
}

class _WaterParameterLogFormScreenState
    extends ConsumerState<WaterParameterLogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _measuredAt;
  bool _isSaving = false;

  // Core parameters
  late TextEditingController _temperatureController;
  late TextEditingController _phController;
  late TextEditingController _ammoniaController;
  late TextEditingController _nitriteController;
  late TextEditingController _nitrateController;

  // Hardness parameters
  late TextEditingController _ghController;
  late TextEditingController _khController;

  // Additional parameters
  late TextEditingController _phosphateController;
  late TextEditingController _oxygenController;
  late TextEditingController _co2Controller;
  late TextEditingController _tdsController;
  late TextEditingController _chlorineController;
  late TextEditingController _ironController;
  late TextEditingController _copperController;

  // Saltwater parameters
  late TextEditingController _salinityController;
  late TextEditingController _calciumController;
  late TextEditingController _magnesiumController;
  late TextEditingController _alkalinityController;

  // Notes
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _measuredAt = widget.log?.measuredAt ?? DateTime.now();

    // Initialize controllers with existing values
    _temperatureController = TextEditingController(
      text: widget.log?.temperatureCelsius?.toString() ?? '',
    );
    _phController = TextEditingController(
      text: widget.log?.ph?.toString() ?? '',
    );
    _ammoniaController = TextEditingController(
      text: widget.log?.ammoniaPpm?.toString() ?? '',
    );
    _nitriteController = TextEditingController(
      text: widget.log?.nitritePpm?.toString() ?? '',
    );
    _nitrateController = TextEditingController(
      text: widget.log?.nitratePpm?.toString() ?? '',
    );
    _ghController = TextEditingController(
      text: widget.log?.ghDgh?.toString() ?? '',
    );
    _khController = TextEditingController(
      text: widget.log?.khDkh?.toString() ?? '',
    );
    _phosphateController = TextEditingController(
      text: widget.log?.phosphatePpm?.toString() ?? '',
    );
    _oxygenController = TextEditingController(
      text: widget.log?.oxygenMgL?.toString() ?? '',
    );
    _co2Controller = TextEditingController(
      text: widget.log?.co2MgL?.toString() ?? '',
    );
    _tdsController = TextEditingController(
      text: widget.log?.tdsPpm?.toString() ?? '',
    );
    _chlorineController = TextEditingController(
      text: widget.log?.chlorinePpm?.toString() ?? '',
    );
    _ironController = TextEditingController(
      text: widget.log?.ironPpm?.toString() ?? '',
    );
    _copperController = TextEditingController(
      text: widget.log?.copperPpm?.toString() ?? '',
    );
    _salinityController = TextEditingController(
      text: widget.log?.salinityPpt?.toString() ?? '',
    );
    _calciumController = TextEditingController(
      text: widget.log?.calciumPpm?.toString() ?? '',
    );
    _magnesiumController = TextEditingController(
      text: widget.log?.magnesiumPpm?.toString() ?? '',
    );
    _alkalinityController = TextEditingController(
      text: widget.log?.alkalinityDkh?.toString() ?? '',
    );
    _notesController = TextEditingController(text: widget.log?.notes ?? '');
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    _phController.dispose();
    _ammoniaController.dispose();
    _nitriteController.dispose();
    _nitrateController.dispose();
    _ghController.dispose();
    _khController.dispose();
    _phosphateController.dispose();
    _oxygenController.dispose();
    _co2Controller.dispose();
    _tdsController.dispose();
    _chlorineController.dispose();
    _ironController.dispose();
    _copperController.dispose();
    _salinityController.dispose();
    _calciumController.dispose();
    _magnesiumController.dispose();
    _alkalinityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Test' : 'Log Water Test'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildDateTimePicker(context),
            const SizedBox(height: 24),
            _buildSectionHeader('Core Parameters'),
            _buildParameterRow([
              _buildField(_temperatureController, 'Temperature', '°C'),
              _buildField(_phController, 'pH', ''),
            ]),
            _buildParameterRow([
              _buildField(_ammoniaController, 'Ammonia (NH3)', 'ppm'),
              _buildField(_nitriteController, 'Nitrite (NO2)', 'ppm'),
            ]),
            _buildParameterRow([
              _buildField(_nitrateController, 'Nitrate (NO3)', 'ppm'),
            ]),
            const SizedBox(height: 16),
            _buildSectionHeader('Hardness'),
            _buildParameterRow([
              _buildField(_ghController, 'GH', 'dGH'),
              _buildField(_khController, 'KH', 'dKH'),
            ]),
            const SizedBox(height: 16),
            _buildSectionHeader('Additional (Optional)'),
            _buildParameterRow([
              _buildField(_phosphateController, 'Phosphate', 'ppm'),
              _buildField(_tdsController, 'TDS', 'ppm'),
            ]),
            _buildParameterRow([
              _buildField(_co2Controller, 'CO2', 'mg/L'),
              _buildField(_oxygenController, 'Oxygen', 'mg/L'),
            ]),
            _buildParameterRow([
              _buildField(_ironController, 'Iron', 'ppm'),
              _buildField(_copperController, 'Copper', 'ppm'),
            ]),
            _buildParameterRow([
              _buildField(_chlorineController, 'Chlorine', 'ppm'),
            ]),
            const SizedBox(height: 16),
            _buildSectionHeader('Saltwater (Optional)'),
            _buildParameterRow([
              _buildField(_salinityController, 'Salinity', 'ppt'),
              _buildField(_alkalinityController, 'Alkalinity', 'dKH'),
            ]),
            _buildParameterRow([
              _buildField(_calciumController, 'Calcium', 'ppm'),
              _buildField(_magnesiumController, 'Magnesium', 'ppm'),
            ]),
            const SizedBox(height: 16),
            _buildSectionHeader('Notes'),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                hintText: 'Any observations...',
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSaving ? null : _saveLog,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.isEditing ? 'Update Test' : 'Save Test'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return InkWell(
      onTap: () => _selectDateTime(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Measured At',
          prefixIcon: Icon(Icons.calendar_today),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDateTime(_measuredAt)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    String dateStr;
    if (date == today) {
      dateStr = 'Today';
    } else if (date == today.subtract(const Duration(days: 1))) {
      dateStr = 'Yesterday';
    } else {
      dateStr = '${dt.day}/${dt.month}/${dt.year}';
    }

    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$dateStr at $hour:$minute';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _measuredAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null && context.mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_measuredAt),
      );
      if (time != null) {
        setState(() {
          _measuredAt = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildParameterRow(List<Widget> fields) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children:
            fields
                .map((f) => Expanded(child: f))
                .expand((w) => [w, const SizedBox(width: 12)])
                .toList()
              ..removeLast(),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    String suffix,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix.isNotEmpty ? suffix : null,
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  Future<void> _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final log = WaterParameterLogEntity(
        id: widget.log?.id,
        tankId: widget.tankId,
        measuredAt: _measuredAt,
        temperatureCelsius: double.tryParse(_temperatureController.text),
        ph: double.tryParse(_phController.text),
        ammoniaPpm: double.tryParse(_ammoniaController.text),
        nitritePpm: double.tryParse(_nitriteController.text),
        nitratePpm: double.tryParse(_nitrateController.text),
        ghDgh: double.tryParse(_ghController.text),
        khDkh: double.tryParse(_khController.text),
        phosphatePpm: double.tryParse(_phosphateController.text),
        oxygenMgL: double.tryParse(_oxygenController.text),
        co2MgL: double.tryParse(_co2Controller.text),
        tdsPpm: double.tryParse(_tdsController.text),
        chlorinePpm: double.tryParse(_chlorineController.text),
        ironPpm: double.tryParse(_ironController.text),
        copperPpm: double.tryParse(_copperController.text),
        salinityPpt: double.tryParse(_salinityController.text),
        calciumPpm: double.tryParse(_calciumController.text),
        magnesiumPpm: double.tryParse(_magnesiumController.text),
        alkalinityDkh: double.tryParse(_alkalinityController.text),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        createdAt: widget.log?.createdAt,
      );

      final notifier = ref.read(
        waterParameterLogProvider(widget.tankId).notifier,
      );

      if (widget.isEditing) {
        await notifier.updateLog(log);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Test updated')));
        }
      } else {
        await notifier.addLog(log);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Test saved')));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving test: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
