import '../../../../../core/database/app_database.dart';
import '../../domain/entities/invertebrate.dart';
import '../../domain/repositories/invertebrate_repository.dart';
import '../models/invertebrate_model.dart';

/// Invertebrate repository implementation using Drift database
class InvertebrateRepositoryImpl implements InvertebrateRepository {
  final AppDatabase _db;

  InvertebrateRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<InvertebrateEntity>> getInvertebratesForTank(int tankId) async {
    final invertebrates = await _db.getInvertebratesForTank(tankId);
    return invertebrates.map((i) => i.toEntity()).toList();
  }

  @override
  Future<InvertebrateEntity?> getInvertebrateById(int id) async {
    final invertebrate = await _db.getInvertebrateById(id);
    return invertebrate?.toEntity();
  }

  @override
  Future<int> addInvertebrate(InvertebrateEntity invertebrate) async {
    return await _db.insertInvertebrate(invertebrate.toCompanion());
  }

  @override
  Future<void> updateInvertebrate(InvertebrateEntity invertebrate) async {
    await _db.updateInvertebrate(invertebrate.toDriftInvertebrate());
  }

  @override
  Future<void> deleteInvertebrate(int id) async {
    await _db.deleteInvertebrate(id);
  }

  @override
  Future<void> deleteInvertebratesForTank(int tankId) async {
    await _db.deleteInvertebratesForTank(tankId);
  }

  @override
  Stream<List<InvertebrateEntity>> watchInvertebratesForTank(int tankId) {
    return _db
        .watchInvertebratesForTank(tankId)
        .map(
          (invertebrates) => invertebrates.map((i) => i.toEntity()).toList(),
        );
  }

  @override
  Future<int> getAliveInvertebrateCount(int tankId) async {
    return await _db.getAliveInvertebrateCount(tankId);
  }
}
