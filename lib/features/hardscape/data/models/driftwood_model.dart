import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/driftwoods_table.dart' as db_types;
import '../../domain/entities/driftwood.dart';

/// Extension to map between Drift Driftwood and DriftwoodEntity
extension DriftwoodMapper on Driftwood {
  /// Convert Drift Driftwood to domain DriftwoodEntity
  DriftwoodEntity toEntity() {
    return DriftwoodEntity(
      id: id,
      tankId: tankId,
      name: name,
      driftwoodType: _mapDbDriftwoodType(driftwoodType),
      isCured: isCured,
      isReleasingTannins: isReleasingTannins,
      quantity: quantity,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
      purchasePrice: purchasePrice,
      source: source,
      dateAdded: dateAdded,
      curingStartDate: curingStartDate,
      photoUrl: photoUrl,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static DriftwoodType _mapDbDriftwoodType(db_types.DriftwoodTypeDb dbType) {
    switch (dbType) {
      case db_types.DriftwoodTypeDb.manzanita:
        return DriftwoodType.manzanita;
      case db_types.DriftwoodTypeDb.spiderWood:
        return DriftwoodType.spiderWood;
      case db_types.DriftwoodTypeDb.malaysian:
        return DriftwoodType.malaysian;
      case db_types.DriftwoodTypeDb.mopani:
        return DriftwoodType.mopani;
      case db_types.DriftwoodTypeDb.cholla:
        return DriftwoodType.cholla;
      case db_types.DriftwoodTypeDb.bogwood:
        return DriftwoodType.bogwood;
      case db_types.DriftwoodTypeDb.redmoor:
        return DriftwoodType.redmoor;
      case db_types.DriftwoodTypeDb.sumatra:
        return DriftwoodType.sumatra;
      case db_types.DriftwoodTypeDb.savanna:
        return DriftwoodType.savanna;
      case db_types.DriftwoodTypeDb.bonsai:
        return DriftwoodType.bonsai;
      case db_types.DriftwoodTypeDb.branch:
        return DriftwoodType.branch;
      case db_types.DriftwoodTypeDb.other:
        return DriftwoodType.other;
    }
  }
}

/// Extension to convert DriftwoodEntity to Drift companion for insert/update
extension DriftwoodEntityMapper on DriftwoodEntity {
  /// Convert domain DriftwoodEntity to Drift DriftwoodsCompanion for insert
  DriftwoodsCompanion toCompanion() {
    return DriftwoodsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      name: Value(name),
      driftwoodType: Value(_mapToDbDriftwoodType(driftwoodType)),
      isCured: Value(isCured),
      isReleasingTannins: Value(isReleasingTannins),
      quantity: Value(quantity),
      lengthCm: Value(lengthCm),
      widthCm: Value(widthCm),
      heightCm: Value(heightCm),
      purchasePrice: Value(purchasePrice),
      source: Value(source),
      dateAdded: Value(dateAdded),
      curingStartDate: Value(curingStartDate),
      photoUrl: Value(photoUrl),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Driftwood for update
  Driftwood toDriftDriftwood() {
    return Driftwood(
      id: id!,
      tankId: tankId,
      name: name,
      driftwoodType: _mapToDbDriftwoodType(driftwoodType),
      isCured: isCured,
      isReleasingTannins: isReleasingTannins,
      quantity: quantity,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
      purchasePrice: purchasePrice,
      source: source,
      dateAdded: dateAdded,
      curingStartDate: curingStartDate,
      photoUrl: photoUrl,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.DriftwoodTypeDb _mapToDbDriftwoodType(DriftwoodType type) {
    switch (type) {
      case DriftwoodType.manzanita:
        return db_types.DriftwoodTypeDb.manzanita;
      case DriftwoodType.spiderWood:
        return db_types.DriftwoodTypeDb.spiderWood;
      case DriftwoodType.malaysian:
        return db_types.DriftwoodTypeDb.malaysian;
      case DriftwoodType.mopani:
        return db_types.DriftwoodTypeDb.mopani;
      case DriftwoodType.cholla:
        return db_types.DriftwoodTypeDb.cholla;
      case DriftwoodType.bogwood:
        return db_types.DriftwoodTypeDb.bogwood;
      case DriftwoodType.redmoor:
        return db_types.DriftwoodTypeDb.redmoor;
      case DriftwoodType.sumatra:
        return db_types.DriftwoodTypeDb.sumatra;
      case DriftwoodType.savanna:
        return db_types.DriftwoodTypeDb.savanna;
      case DriftwoodType.bonsai:
        return db_types.DriftwoodTypeDb.bonsai;
      case DriftwoodType.branch:
        return db_types.DriftwoodTypeDb.branch;
      case DriftwoodType.other:
        return db_types.DriftwoodTypeDb.other;
    }
  }
}

