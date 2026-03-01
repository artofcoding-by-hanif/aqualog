import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/maintenance_logs_table.dart' as db_types;
import '../../domain/entities/maintenance_log.dart';

/// Extension to map between Drift MaintenanceLog and MaintenanceLogEntity
extension MaintenanceLogMapper on MaintenanceLog {
  /// Convert Drift MaintenanceLog to domain MaintenanceLogEntity
  MaintenanceLogEntity toEntity() {
    return MaintenanceLogEntity(
      id: id,
      tankId: tankId,
      maintenanceType: _mapDbMaintenanceType(maintenanceType),
      title: title,
      notes: notes,
      waterChangePercent: waterChangePercent,
      waterChangeLiters: waterChangeLiters,
      performedAt: performedAt,
      durationMinutes: durationMinutes,
      createdAt: createdAt,
    );
  }

  /// Map database MaintenanceType to domain MaintenanceType
  static MaintenanceType _mapDbMaintenanceType(db_types.MaintenanceType type) {
    switch (type) {
      case db_types.MaintenanceType.waterChange:
        return MaintenanceType.waterChange;
      case db_types.MaintenanceType.filterCleaning:
        return MaintenanceType.filterCleaning;
      case db_types.MaintenanceType.glassCleaning:
        return MaintenanceType.glassCleaning;
      case db_types.MaintenanceType.substrateCleaning:
        return MaintenanceType.substrateCleaning;
      case db_types.MaintenanceType.trimming:
        return MaintenanceType.trimming;
      case db_types.MaintenanceType.equipmentMaintenance:
        return MaintenanceType.equipmentMaintenance;
      case db_types.MaintenanceType.medicationDose:
        return MaintenanceType.medicationDose;
      case db_types.MaintenanceType.other:
        return MaintenanceType.other;
    }
  }
}

/// Extension to convert MaintenanceLogEntity to Drift companion for insert/update
extension MaintenanceLogEntityMapper on MaintenanceLogEntity {
  /// Convert domain MaintenanceLogEntity to Drift MaintenanceLogsCompanion for insert
  MaintenanceLogsCompanion toCompanion() {
    return MaintenanceLogsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      maintenanceType: Value(_mapToDbMaintenanceType(maintenanceType)),
      title: Value(title),
      notes: Value(notes),
      waterChangePercent: Value(waterChangePercent),
      waterChangeLiters: Value(waterChangeLiters),
      performedAt: Value(performedAt),
      durationMinutes: Value(durationMinutes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
    );
  }

  /// Convert to Drift MaintenanceLog for update
  MaintenanceLog toDriftMaintenanceLog() {
    return MaintenanceLog(
      id: id!,
      tankId: tankId,
      maintenanceType: _mapToDbMaintenanceType(maintenanceType),
      title: title,
      notes: notes,
      waterChangePercent: waterChangePercent,
      waterChangeLiters: waterChangeLiters,
      performedAt: performedAt,
      durationMinutes: durationMinutes,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  static db_types.MaintenanceType _mapToDbMaintenanceType(MaintenanceType type) {
    switch (type) {
      case MaintenanceType.waterChange:
        return db_types.MaintenanceType.waterChange;
      case MaintenanceType.filterCleaning:
        return db_types.MaintenanceType.filterCleaning;
      case MaintenanceType.glassCleaning:
        return db_types.MaintenanceType.glassCleaning;
      case MaintenanceType.substrateCleaning:
        return db_types.MaintenanceType.substrateCleaning;
      case MaintenanceType.trimming:
        return db_types.MaintenanceType.trimming;
      case MaintenanceType.equipmentMaintenance:
        return db_types.MaintenanceType.equipmentMaintenance;
      case MaintenanceType.medicationDose:
        return db_types.MaintenanceType.medicationDose;
      case MaintenanceType.other:
        return db_types.MaintenanceType.other;
    }
  }
}

