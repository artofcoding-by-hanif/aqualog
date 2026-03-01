import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/feeding_logs_table.dart' as db_types;
import '../../../../core/database/tables/reminders_table.dart'
    as db_types
    show FoodType;
import '../../domain/entities/feeding_log.dart';

/// Extension to map between Drift FeedingLog and FeedingLogEntity
extension FeedingLogMapper on FeedingLog {
  /// Convert Drift FeedingLog to domain FeedingLogEntity
  FeedingLogEntity toEntity() {
    return FeedingLogEntity(
      id: id,
      tankId: tankId,
      foodType: _mapDbFoodType(foodType),
      foodName: foodName,
      amount: amount,
      response: _mapDbFeedingResponse(response),
      fedAt: fedAt,
      notes: notes,
      createdAt: createdAt,
    );
  }

  /// Map database FoodType to domain FoodType
  static FoodType _mapDbFoodType(db_types.FoodType type) {
    switch (type) {
      case db_types.FoodType.flakes:
        return FoodType.flakes;
      case db_types.FoodType.pellets:
        return FoodType.pellets;
      case db_types.FoodType.granules:
        return FoodType.granules;
      case db_types.FoodType.frozen:
        return FoodType.frozen;
      case db_types.FoodType.freezeDried:
        return FoodType.freezeDried;
      case db_types.FoodType.live:
        return FoodType.live;
      case db_types.FoodType.gel:
        return FoodType.gel;
      case db_types.FoodType.vegetables:
        return FoodType.vegetables;
      case db_types.FoodType.algaeWafer:
        return FoodType.algaeWafer;
      case db_types.FoodType.sinkingPellets:
        return FoodType.sinkingPellets;
      case db_types.FoodType.other:
        return FoodType.other;
    }
  }

  /// Map database FeedingResponse to domain FeedingResponse
  static FeedingResponse _mapDbFeedingResponse(
    db_types.FeedingResponse response,
  ) {
    switch (response) {
      case db_types.FeedingResponse.ateEagerly:
        return FeedingResponse.ateEagerly;
      case db_types.FeedingResponse.ateNormally:
        return FeedingResponse.ateNormally;
      case db_types.FeedingResponse.ateSome:
        return FeedingResponse.ateSome;
      case db_types.FeedingResponse.picky:
        return FeedingResponse.picky;
      case db_types.FeedingResponse.ignored:
        return FeedingResponse.ignored;
      case db_types.FeedingResponse.unknown:
        return FeedingResponse.unknown;
    }
  }
}

/// Extension to convert FeedingLogEntity to Drift companion for insert/update
extension FeedingLogEntityMapper on FeedingLogEntity {
  /// Convert domain FeedingLogEntity to Drift FeedingLogsCompanion for insert
  FeedingLogsCompanion toCompanion() {
    return FeedingLogsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      foodType: Value(_mapToDbFoodType(foodType)),
      foodName: Value(foodName),
      amount: Value(amount),
      response: Value(_mapToDbFeedingResponse(response)),
      fedAt: Value(fedAt),
      notes: Value(notes),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
    );
  }

  /// Convert to Drift FeedingLog for update
  FeedingLog toDriftFeedingLog() {
    return FeedingLog(
      id: id!,
      tankId: tankId,
      foodType: _mapToDbFoodType(foodType),
      foodName: foodName,
      amount: amount,
      response: _mapToDbFeedingResponse(response),
      fedAt: fedAt,
      notes: notes,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  static db_types.FoodType _mapToDbFoodType(FoodType type) {
    switch (type) {
      case FoodType.flakes:
        return db_types.FoodType.flakes;
      case FoodType.pellets:
        return db_types.FoodType.pellets;
      case FoodType.granules:
        return db_types.FoodType.granules;
      case FoodType.frozen:
        return db_types.FoodType.frozen;
      case FoodType.freezeDried:
        return db_types.FoodType.freezeDried;
      case FoodType.live:
        return db_types.FoodType.live;
      case FoodType.gel:
        return db_types.FoodType.gel;
      case FoodType.vegetables:
        return db_types.FoodType.vegetables;
      case FoodType.algaeWafer:
        return db_types.FoodType.algaeWafer;
      case FoodType.sinkingPellets:
        return db_types.FoodType.sinkingPellets;
      case FoodType.other:
        return db_types.FoodType.other;
    }
  }

  static db_types.FeedingResponse _mapToDbFeedingResponse(
    FeedingResponse response,
  ) {
    switch (response) {
      case FeedingResponse.ateEagerly:
        return db_types.FeedingResponse.ateEagerly;
      case FeedingResponse.ateNormally:
        return db_types.FeedingResponse.ateNormally;
      case FeedingResponse.ateSome:
        return db_types.FeedingResponse.ateSome;
      case FeedingResponse.picky:
        return db_types.FeedingResponse.picky;
      case FeedingResponse.ignored:
        return db_types.FeedingResponse.ignored;
      case FeedingResponse.unknown:
        return db_types.FeedingResponse.unknown;
    }
  }
}
