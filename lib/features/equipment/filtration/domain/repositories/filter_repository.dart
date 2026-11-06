import '../entities/filter.dart';

/// Filter repository interface
abstract class FilterRepository {
  /// Get all filters for a tank
  Future<List<FilterEntity>> getFiltersForTank(int tankId);

  /// Get a filter by ID
  Future<FilterEntity?> getFilterById(int id);

  /// Add a new filter
  Future<int> addFilter(FilterEntity filter);

  /// Update an existing filter
  Future<void> updateFilter(FilterEntity filter);

  /// Delete a filter
  Future<void> deleteFilter(int id);

  /// Delete all filters for a tank
  Future<void> deleteFiltersForTank(int tankId);

  /// Watch all filters for a tank (reactive stream)
  Stream<List<FilterEntity>> watchFiltersForTank(int tankId);
}
