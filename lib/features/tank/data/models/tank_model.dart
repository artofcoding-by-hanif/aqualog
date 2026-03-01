import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/tanks_table.dart' as db_types;
import '../../domain/entities/tank.dart';

/// Extension to map between Drift Tank and TankEntity
extension TankMapper on Tank {
  /// Convert Drift Tank to domain TankEntity
  TankEntity toEntity() {
    return TankEntity(
      id: id,
      name: name,
      tankType: _mapDbTankType(tankType),
      volumeLiters: volumeLiters,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
      description: description,
      photoPath: photoPath,
      setupDate: setupDate,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static TankType _mapDbTankType(db_types.TankType dbType) {
    switch (dbType) {
      case db_types.TankType.freshwater:
        return TankType.freshwater;
      case db_types.TankType.saltwater:
        return TankType.saltwater;
      case db_types.TankType.brackish:
        return TankType.brackish;
      case db_types.TankType.planted:
        return TankType.planted;
      case db_types.TankType.reef:
        return TankType.reef;
      case db_types.TankType.shrimp:
        return TankType.shrimp;
      case db_types.TankType.pond:
        return TankType.pond;
    }
  }
}

/// Extension to convert TankEntity to Drift companion for insert/update
extension TankEntityMapper on TankEntity {
  /// Convert domain TankEntity to Drift TanksCompanion for insert
  TanksCompanion toCompanion() {
    return TanksCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      tankType: Value(_mapToDbTankType(tankType)),
      volumeLiters: Value(volumeLiters),
      lengthCm: Value(lengthCm),
      widthCm: Value(widthCm),
      heightCm: Value(heightCm),
      description: Value(description),
      photoPath: Value(photoPath),
      setupDate: Value(setupDate),
      isActive: Value(isActive),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Tank for update
  Tank toDriftTank() {
    return Tank(
      id: id!,
      name: name,
      tankType: _mapToDbTankType(tankType),
      volumeLiters: volumeLiters,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
      description: description,
      photoPath: photoPath,
      setupDate: setupDate,
      isActive: isActive,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.TankType _mapToDbTankType(TankType type) {
    switch (type) {
      case TankType.freshwater:
        return db_types.TankType.freshwater;
      case TankType.saltwater:
        return db_types.TankType.saltwater;
      case TankType.brackish:
        return db_types.TankType.brackish;
      case TankType.planted:
        return db_types.TankType.planted;
      case TankType.reef:
        return db_types.TankType.reef;
      case TankType.shrimp:
        return db_types.TankType.shrimp;
      case TankType.pond:
        return db_types.TankType.pond;
    }
  }
}
