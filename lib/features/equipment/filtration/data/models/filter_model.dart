import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/tables/filters_table.dart' as db_types;
import '../../domain/entities/filter.dart';

/// Extension to map between Drift Filter and FilterEntity
extension FilterMapper on Filter {
  /// Convert Drift Filter to domain FilterEntity
  FilterEntity toEntity() {
    return FilterEntity(
      id: id,
      tankId: tankId,
      name: name,
      filterType: _mapDbFilterType(filterType),
      brand: brand,
      model: model,
      flowRateLph: flowRateLph,
      mediaVolumeLiters: mediaVolumeLiters,
      lastCleanedAt: lastCleanedAt,
      mediaReplacedAt: mediaReplacedAt,
      cleaningIntervalDays: cleaningIntervalDays,
      mediaReplacementIntervalDays: mediaReplacementIntervalDays,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Map database FilterType enum to domain FilterType enum
  static FilterType _mapDbFilterType(db_types.FilterType dbType) {
    switch (dbType) {
      case db_types.FilterType.hob:
        return FilterType.hob;
      case db_types.FilterType.canister:
        return FilterType.canister;
      case db_types.FilterType.sponge:
        return FilterType.sponge;
      case db_types.FilterType.internal:
        return FilterType.internal;
      case db_types.FilterType.sump:
        return FilterType.sump;
      case db_types.FilterType.undergravel:
        return FilterType.undergravel;
      case db_types.FilterType.fluidizedBed:
        return FilterType.fluidizedBed;
      case db_types.FilterType.wetDry:
        return FilterType.wetDry;
      case db_types.FilterType.other:
        return FilterType.other;
    }
  }
}

/// Extension to convert FilterEntity to Drift companion for insert/update
extension FilterEntityMapper on FilterEntity {
  /// Convert domain FilterEntity to Drift FiltersCompanion for insert
  FiltersCompanion toCompanion() {
    return FiltersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      name: Value(name),
      filterType: Value(_mapToDbFilterType(filterType)),
      brand: Value(brand),
      model: Value(model),
      flowRateLph: Value(flowRateLph),
      mediaVolumeLiters: Value(mediaVolumeLiters),
      lastCleanedAt: Value(lastCleanedAt),
      mediaReplacedAt: Value(mediaReplacedAt),
      cleaningIntervalDays: Value(cleaningIntervalDays),
      mediaReplacementIntervalDays: Value(mediaReplacementIntervalDays),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Filter for update
  Filter toDriftFilter() {
    return Filter(
      id: id!,
      tankId: tankId,
      name: name,
      filterType: _mapToDbFilterType(filterType),
      brand: brand,
      model: model,
      flowRateLph: flowRateLph,
      mediaVolumeLiters: mediaVolumeLiters,
      lastCleanedAt: lastCleanedAt,
      mediaReplacedAt: mediaReplacedAt,
      cleaningIntervalDays: cleaningIntervalDays,
      mediaReplacementIntervalDays: mediaReplacementIntervalDays,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Map domain FilterType enum to database FilterType enum
  static db_types.FilterType _mapToDbFilterType(FilterType type) {
    switch (type) {
      case FilterType.hob:
        return db_types.FilterType.hob;
      case FilterType.canister:
        return db_types.FilterType.canister;
      case FilterType.sponge:
        return db_types.FilterType.sponge;
      case FilterType.internal:
        return db_types.FilterType.internal;
      case FilterType.sump:
        return db_types.FilterType.sump;
      case FilterType.undergravel:
        return db_types.FilterType.undergravel;
      case FilterType.fluidizedBed:
        return db_types.FilterType.fluidizedBed;
      case FilterType.wetDry:
        return db_types.FilterType.wetDry;
      case FilterType.other:
        return db_types.FilterType.other;
    }
  }
}
