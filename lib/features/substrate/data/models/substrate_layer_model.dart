import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/substrate_layers_table.dart' as db_types;
import '../../domain/entities/substrate_layer.dart';

/// Extension to map between Drift SubstrateLayer and SubstrateLayerEntity
extension SubstrateLayerMapper on SubstrateLayer {
  /// Convert Drift SubstrateLayer to domain SubstrateLayerEntity
  SubstrateLayerEntity toEntity() {
    return SubstrateLayerEntity(
      id: id,
      tankId: tankId,
      name: name,
      substrateType: _mapDbSubstrateType(substrateType),
      brand: brand,
      depthCm: depthCm,
      layerOrder: layerOrder,
      volumeLiters: volumeLiters,
      weightKg: weightKg,
      color: color,
      purchasePrice: purchasePrice,
      source: source,
      dateAdded: dateAdded,
      photoUrl: photoUrl,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static SubstrateType _mapDbSubstrateType(db_types.SubstrateTypeDb dbType) {
    switch (dbType) {
      case db_types.SubstrateTypeDb.aquaSoil:
        return SubstrateType.aquaSoil;
      case db_types.SubstrateTypeDb.gravel:
        return SubstrateType.gravel;
      case db_types.SubstrateTypeDb.sand:
        return SubstrateType.sand;
      case db_types.SubstrateTypeDb.crushedCoral:
        return SubstrateType.crushedCoral;
      case db_types.SubstrateTypeDb.fluorite:
        return SubstrateType.fluorite;
      case db_types.SubstrateTypeDb.ecoComplete:
        return SubstrateType.ecoComplete;
      case db_types.SubstrateTypeDb.stratum:
        return SubstrateType.stratum;
      case db_types.SubstrateTypeDb.controsoil:
        return SubstrateType.controsoil;
      case db_types.SubstrateTypeDb.amazonia:
        return SubstrateType.amazonia;
      case db_types.SubstrateTypeDb.powerSand:
        return SubstrateType.powerSand;
      case db_types.SubstrateTypeDb.lavaRockSubstrate:
        return SubstrateType.lavaRockSubstrate;
      case db_types.SubstrateTypeDb.peat:
        return SubstrateType.peat;
      case db_types.SubstrateTypeDb.clay:
        return SubstrateType.clay;
      case db_types.SubstrateTypeDb.rootTabs:
        return SubstrateType.rootTabs;
      case db_types.SubstrateTypeDb.other:
        return SubstrateType.other;
    }
  }
}

/// Extension to convert SubstrateLayerEntity to Drift companion for insert/update
extension SubstrateLayerEntityMapper on SubstrateLayerEntity {
  /// Convert domain SubstrateLayerEntity to Drift SubstrateLayersCompanion for insert
  SubstrateLayersCompanion toCompanion() {
    return SubstrateLayersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      name: Value(name),
      substrateType: Value(_mapToDbSubstrateType(substrateType)),
      brand: Value(brand),
      depthCm: Value(depthCm),
      layerOrder: Value(layerOrder),
      volumeLiters: Value(volumeLiters),
      weightKg: Value(weightKg),
      color: Value(color),
      purchasePrice: Value(purchasePrice),
      source: Value(source),
      dateAdded: Value(dateAdded),
      photoUrl: Value(photoUrl),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift SubstrateLayer for update
  SubstrateLayer toDriftSubstrateLayer() {
    return SubstrateLayer(
      id: id!,
      tankId: tankId,
      name: name,
      substrateType: _mapToDbSubstrateType(substrateType),
      brand: brand,
      depthCm: depthCm,
      layerOrder: layerOrder,
      volumeLiters: volumeLiters,
      weightKg: weightKg,
      color: color,
      purchasePrice: purchasePrice,
      source: source,
      dateAdded: dateAdded,
      photoUrl: photoUrl,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static db_types.SubstrateTypeDb _mapToDbSubstrateType(SubstrateType type) {
    switch (type) {
      case SubstrateType.aquaSoil:
        return db_types.SubstrateTypeDb.aquaSoil;
      case SubstrateType.gravel:
        return db_types.SubstrateTypeDb.gravel;
      case SubstrateType.sand:
        return db_types.SubstrateTypeDb.sand;
      case SubstrateType.crushedCoral:
        return db_types.SubstrateTypeDb.crushedCoral;
      case SubstrateType.fluorite:
        return db_types.SubstrateTypeDb.fluorite;
      case SubstrateType.ecoComplete:
        return db_types.SubstrateTypeDb.ecoComplete;
      case SubstrateType.stratum:
        return db_types.SubstrateTypeDb.stratum;
      case SubstrateType.controsoil:
        return db_types.SubstrateTypeDb.controsoil;
      case SubstrateType.amazonia:
        return db_types.SubstrateTypeDb.amazonia;
      case SubstrateType.powerSand:
        return db_types.SubstrateTypeDb.powerSand;
      case SubstrateType.lavaRockSubstrate:
        return db_types.SubstrateTypeDb.lavaRockSubstrate;
      case SubstrateType.peat:
        return db_types.SubstrateTypeDb.peat;
      case SubstrateType.clay:
        return db_types.SubstrateTypeDb.clay;
      case SubstrateType.rootTabs:
        return db_types.SubstrateTypeDb.rootTabs;
      case SubstrateType.other:
        return db_types.SubstrateTypeDb.other;
    }
  }
}

