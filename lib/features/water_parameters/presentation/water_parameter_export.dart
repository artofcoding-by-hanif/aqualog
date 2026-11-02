import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/entities/water_parameter_log.dart';
import '../domain/parameter_trends.dart';

/// Writes a tank's water test history to a CSV file and opens the share
/// sheet with it (Premium only; callers check entitlement)
Future<void> shareWaterParameterCsv({
  required String tankName,
  required List<WaterParameterLogEntity> logs,
}) async {
  final dir = await getTemporaryDirectory();
  final slug = tankName
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');
  final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final file = File(
    '${dir.path}/aqualog_${slug.isEmpty ? 'tank' : slug}_water_$date.csv',
  );
  await file.writeAsString(waterParametersToCsv(logs));

  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path, mimeType: 'text/csv')],
      subject: '$tankName water parameters',
    ),
  );
}
