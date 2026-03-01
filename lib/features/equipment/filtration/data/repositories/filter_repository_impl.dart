import '../../../../../core/database/app_database.dart';
import '../../domain/entities/filter.dart';
import '../../domain/repositories/filter_repository.dart';
import '../models/filter_model.dart';

/// Filter repository implementation using Drift database
class FilterRepositoryImpl implements FilterRepository {
  final AppDatabase _db;

  FilterRepositoryImpl({required AppDatabase database}) : _db = database;

  @override
  Future<List<FilterEntity>> getFiltersForTank(int tankId) async {
    final filters = await _db.getFiltersForTank(tankId);
    return filters.map((f) => f.toEntity()).toList();
  }

  @override
  Future<FilterEntity?> getFilterById(int id) async {
    final filter = await _db.getFilterById(id);
    return filter?.toEntity();
  }

  @override
  Future<int> addFilter(FilterEntity filter) async {
    return await _db.insertFilter(filter.toCompanion());
  }

  @override
  Future<void> updateFilter(FilterEntity filter) async {
    await _db.updateFilter(filter.toDriftFilter());
  }

  @override
  Future<void> deleteFilter(int id) async {
    await _db.deleteFilter(id);
  }

  @override
  Future<void> deleteFiltersForTank(int tankId) async {
    await _db.deleteFiltersForTank(tankId);
  }

  @override
  Stream<List<FilterEntity>> watchFiltersForTank(int tankId) {
    return _db.watchFiltersForTank(tankId).map(
      (filters) => filters.map((f) => f.toEntity()).toList(),
    );
  }
}

