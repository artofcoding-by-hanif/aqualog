import '../../../core/database/app_database.dart';
import '../../equipment/filtration/data/models/filter_model.dart';
import '../../equipment/lighting/data/models/lighting_model.dart';
import '../../hardscape/data/models/driftwood_model.dart';
import '../../hardscape/data/models/rock_model.dart';
import '../../livestock/fish/data/models/fish_model.dart';
import '../../livestock/invertebrates/data/models/invertebrate_model.dart';
import '../../logs/data/models/feeding_log_model.dart';
import '../../logs/data/models/maintenance_log_model.dart';
import '../../plants/data/models/plant_model.dart';
import '../../reminders/data/models/reminder_model.dart';
import '../../substrate/data/models/substrate_layer_model.dart';
import '../../tank/data/models/tank_model.dart';
import '../../water_parameters/data/models/water_parameter_log_model.dart';

/// Collects everything the assistant should know about one tank into a
/// compact JSON-ready map.
///
/// Only the tank's own records go out: internal ids, file paths and
/// bookkeeping timestamps are stripped, and lists are capped so the request
/// stays small.
class TankContextBuilder {
  TankContextBuilder(this._db);

  final AppDatabase _db;

  static const int _maxWaterTests = 6;
  static const int _maxMaintenance = 10;
  static const int _maxFeedings = 7;

  /// Keys that identify records or files rather than describe the tank
  static const Set<String> _droppedKeys = {
    'id',
    'tankId',
    'filterId',
    'createdAt',
    'updatedAt',
    'imagePath',
    'photoPath',
    'isActive',
  };

  Future<Map<String, dynamic>?> build(int tankId, {DateTime? now}) async {
    final tank = await _db.getTankById(tankId);
    if (tank == null) return null;
    final today = now ?? DateTime.now();

    final waterTests = await _db.getWaterParametersForTank(tankId);
    final maintenance = await _db.getMaintenanceLogsForTank(tankId);
    final feedings = await _db.getFeedingLogsForTank(tankId);
    final reminders = await _db.getRemindersForTank(tankId);

    final context = <String, dynamic>{
      'today': _date(today),
      'tank': _clean(tank.toEntity().toJson()),
      'waterTests': waterTests.take(_maxWaterTests).map((row) {
        final log = row.toEntity();
        return _clean({
          'measuredAt': _date(log.measuredAt),
          'daysAgo': today.difference(log.measuredAt).inDays,
          'temperatureC': log.temperatureCelsius,
          'pH': log.ph,
          'ammoniaPpm': log.ammoniaPpm,
          'nitritePpm': log.nitritePpm,
          'nitratePpm': log.nitratePpm,
          'ghDgh': log.ghDgh,
          'khDkh': log.khDkh,
          'phosphatePpm': log.phosphatePpm,
          'oxygenMgL': log.oxygenMgL,
          'tdsPpm': log.tdsPpm,
          'chlorinePpm': log.chlorinePpm,
          'ironPpm': log.ironPpm,
          'copperPpm': log.copperPpm,
          'salinityPpt': log.salinityPpt,
          'calciumPpm': log.calciumPpm,
          'magnesiumPpm': log.magnesiumPpm,
          'alkalinityDkh': log.alkalinityDkh,
          'notes': log.notes,
        });
      }).toList(),
      'fish': await _entities(
        _db.getFishForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'invertebrates': await _entities(
        _db.getInvertebratesForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'plants': await _entities(
        _db.getPlantsForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'filters': await _entities(
        _db.getFiltersForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'lighting': await _entities(
        _db.getLightingsForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'substrate': await _entities(
        _db.getSubstrateLayersForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'rocks': await _entities(
        _db.getRocksForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'driftwood': await _entities(
        _db.getDriftwoodsForTank(tankId),
        (r) => r.toEntity().toJson(),
      ),
      'recentMaintenance': maintenance.take(_maxMaintenance).map((row) {
        final log = row.toEntity();
        return _clean({
          'type': log.maintenanceType.displayName,
          'title': log.title,
          'date': _date(log.performedAt),
          'daysAgo': today.difference(log.performedAt).inDays,
          'waterChangePercent': log.waterChangePercent,
          'notes': log.notes,
        });
      }).toList(),
      'recentFeedings': feedings.take(_maxFeedings).map((row) {
        final log = row.toEntity();
        return _clean({
          'food': log.foodName ?? log.foodType.displayName,
          'amount': log.amount,
          'date': _date(log.fedAt),
          'notes': log.notes,
        });
      }).toList(),
      'openReminders': reminders
          .map((row) => row.toEntity())
          .where((r) => r.isEnabled && !r.isCompleted)
          .map(
            (r) => _clean({
              'title': r.title,
              'type': r.reminderType.displayName,
              'due': _date(r.scheduledAt),
              'overdue': r.isOverdue,
            }),
          )
          .toList(),
    };

    // Leave out empty sections entirely
    context.removeWhere((_, value) => value is List && value.isEmpty);
    return context;
  }

  Future<List<Map<String, dynamic>>> _entities<T>(
    Future<List<T>> rows,
    Map<String, dynamic> Function(T row) toJson,
  ) async {
    return (await rows).map((row) => _clean(toJson(row))).toList();
  }

  static String _date(DateTime value) =>
      value.toIso8601String().split('T').first;

  /// Remove bookkeeping keys, nulls and empty values, recursively
  static Map<String, dynamic> _clean(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    for (final entry in json.entries) {
      if (_droppedKeys.contains(entry.key)) continue;
      final value = _cleanValue(entry.value);
      if (value == null) continue;
      result[entry.key] = value;
    }
    return result;
  }

  static dynamic _cleanValue(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return null;
      // ISO timestamps from toJson: keep the date part only
      final parsed = RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(trimmed)
          ? trimmed.split('T').first
          : trimmed;
      return parsed;
    }
    if (value is Map<String, dynamic>) {
      final cleaned = _clean(value);
      return cleaned.isEmpty ? null : cleaned;
    }
    if (value is List) {
      final cleaned = value.map(_cleanValue).where((v) => v != null).toList();
      return cleaned.isEmpty ? null : cleaned;
    }
    if (value is double) {
      // Two decimals is plenty for readings and volumes
      return double.parse(value.toStringAsFixed(2));
    }
    return value;
  }
}
