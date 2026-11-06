import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/rocks_table.dart' as db_types;
import '../../domain/entities/rock.dart';

/// Extension to map between Drift Rock and RockEntity
extension RockMapper on Rock {
  /// Convert Drift Rock to domain RockEntity
  RockEntity toEntity() {
    return RockEntity(
      id: id,
      tankId: tankId,
      name: name,
      rockType: _mapDbRockType(rockType),
      weightKg: weightKg,
      quantity: quantity,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
      purchasePrice: purchasePrice,
      source: source,
      dateAdded: dateAdded,
      photoUrl: photoUrl,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RockType _mapDbRockType(db_types.RockTypeDb dbType) {
    switch (dbType) {
      case db_types.RockTypeDb.dragonStone:
        return RockType.dragonStone;
      case db_types.RockTypeDb.seiryu:
        return RockType.seiryu;
      case db_types.RockTypeDb.lavaRock:
        return RockType.lavaRock;
      case db_types.RockTypeDb.slate:
        return RockType.slate;
      case db_types.RockTypeDb.riverRock:
        return RockType.riverRock;
      case db_types.RockTypeDb.petrifiedWood:
        return RockType.petrifiedWood;
      case db_types.RockTypeDb.texasHoley:
        return RockType.texasHoley;
      case db_types.RockTypeDb.rainbowRock:
        return RockType.rainbowRock;
      case db_types.RockTypeDb.pagoda:
        return RockType.pagoda;
      case db_types.RockTypeDb.elephantSkin:
        return RockType.elephantSkin;
      case db_types.RockTypeDb.mapleLeaf:
        return RockType.mapleLeaf;
      case db_types.RockTypeDb.other:
        return RockType.other;
    }
  }
}

/// Extension to convert RockEntity to Drift companion for insert/update
extension RockEntityMapper on RockEntity {
  /// Convert domain RockEntity to Drift RocksCompanion for insert
  RocksCompanion toCompanion() {
    return RocksCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      name: Value(name),
      rockType: Value(_mapToDbRockType(rockType)),
      weightKg: Value(weightKg),
      quantity: Value(quantity),
      lengthCm: Value(lengthCm),
      widthCm: Value(widthCm),
      heightCm: Value(heightCm),
      purchasePrice: Value(purchasePrice),
      source: Value(source),
      dateAdded: Value(dateAdded),
      photoUrl: Value(photoUrl),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Rock for update
  Rock toDriftRock() {
    return Rock(
      id: id!,
      tankId: tankId,
      name: name,
      rockType: _mapToDbRockType(rockType),
      weightKg: weightKg,
      quantity: quantity,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
      purchasePrice: purchasePrice,
      source: source,
      dateAdded: dateAdded,
      photoUrl: photoUrl,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.RockTypeDb _mapToDbRockType(RockType type) {
    switch (type) {
      case RockType.dragonStone:
        return db_types.RockTypeDb.dragonStone;
      case RockType.seiryu:
        return db_types.RockTypeDb.seiryu;
      case RockType.lavaRock:
        return db_types.RockTypeDb.lavaRock;
      case RockType.slate:
        return db_types.RockTypeDb.slate;
      case RockType.riverRock:
        return db_types.RockTypeDb.riverRock;
      case RockType.petrifiedWood:
        return db_types.RockTypeDb.petrifiedWood;
      case RockType.texasHoley:
        return db_types.RockTypeDb.texasHoley;
      case RockType.rainbowRock:
        return db_types.RockTypeDb.rainbowRock;
      case RockType.pagoda:
        return db_types.RockTypeDb.pagoda;
      case RockType.elephantSkin:
        return db_types.RockTypeDb.elephantSkin;
      case RockType.mapleLeaf:
        return db_types.RockTypeDb.mapleLeaf;
      case RockType.other:
        return db_types.RockTypeDb.other;
    }
  }
}
