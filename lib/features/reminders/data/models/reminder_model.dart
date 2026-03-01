import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/reminders_table.dart' as db_types;
import '../../domain/entities/reminder.dart';

/// Extension to map between Drift Reminder and ReminderEntity
extension ReminderMapper on Reminder {
  /// Convert Drift Reminder to domain ReminderEntity
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      tankId: tankId,
      filterId: filterId,
      foodType: foodType != null ? _mapDbFoodType(foodType!) : null,
      title: title,
      description: description,
      reminderType: _mapDbReminderType(reminderType),
      scheduledAt: scheduledAt,
      repeatFrequency: _mapDbRepeatFrequency(repeatFrequency),
      customIntervalDays: customIntervalDays,
      isEnabled: isEnabled,
      isCompleted: isCompleted,
      lastCompletedAt: lastCompletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

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

  static ReminderType _mapDbReminderType(db_types.ReminderType dbType) {
    switch (dbType) {
      case db_types.ReminderType.waterChange:
        return ReminderType.waterChange;
      case db_types.ReminderType.feeding:
        return ReminderType.feeding;
      case db_types.ReminderType.fertilizing:
        return ReminderType.fertilizing;
      case db_types.ReminderType.cleaning:
        return ReminderType.cleaning;
      case db_types.ReminderType.maintenance:
        return ReminderType.maintenance;
      case db_types.ReminderType.waterTest:
        return ReminderType.waterTest;
      case db_types.ReminderType.medicationDose:
        return ReminderType.medicationDose;
      case db_types.ReminderType.custom:
        return ReminderType.custom;
    }
  }

  static RepeatFrequency _mapDbRepeatFrequency(
    db_types.RepeatFrequency dbFreq,
  ) {
    switch (dbFreq) {
      case db_types.RepeatFrequency.none:
        return RepeatFrequency.none;
      case db_types.RepeatFrequency.daily:
        return RepeatFrequency.daily;
      case db_types.RepeatFrequency.weekly:
        return RepeatFrequency.weekly;
      case db_types.RepeatFrequency.biweekly:
        return RepeatFrequency.biweekly;
      case db_types.RepeatFrequency.monthly:
        return RepeatFrequency.monthly;
      case db_types.RepeatFrequency.custom:
        return RepeatFrequency.custom;
    }
  }
}

/// Extension to convert ReminderEntity to Drift companion for insert/update
extension ReminderEntityMapper on ReminderEntity {
  /// Convert domain ReminderEntity to Drift RemindersCompanion for insert
  RemindersCompanion toCompanion() {
    return RemindersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      tankId: Value(tankId),
      filterId: Value(filterId),
      foodType: Value(foodType != null ? _mapToDbFoodType(foodType!) : null),
      title: Value(title),
      description: Value(description),
      reminderType: Value(_mapToDbReminderType(reminderType)),
      scheduledAt: Value(scheduledAt),
      repeatFrequency: Value(_mapToDbRepeatFrequency(repeatFrequency)),
      customIntervalDays: Value(customIntervalDays),
      isEnabled: Value(isEnabled),
      isCompleted: Value(isCompleted),
      lastCompletedAt: Value(lastCompletedAt),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert to Drift Reminder for update
  Reminder toDriftReminder() {
    return Reminder(
      id: id!,
      tankId: tankId,
      filterId: filterId,
      foodType: foodType != null ? _mapToDbFoodType(foodType!) : null,
      title: title,
      description: description,
      reminderType: _mapToDbReminderType(reminderType),
      scheduledAt: scheduledAt,
      repeatFrequency: _mapToDbRepeatFrequency(repeatFrequency),
      customIntervalDays: customIntervalDays,
      isEnabled: isEnabled,
      isCompleted: isCompleted,
      lastCompletedAt: lastCompletedAt,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
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

  static db_types.ReminderType _mapToDbReminderType(ReminderType type) {
    switch (type) {
      case ReminderType.waterChange:
        return db_types.ReminderType.waterChange;
      case ReminderType.feeding:
        return db_types.ReminderType.feeding;
      case ReminderType.fertilizing:
        return db_types.ReminderType.fertilizing;
      case ReminderType.cleaning:
        return db_types.ReminderType.cleaning;
      case ReminderType.maintenance:
        return db_types.ReminderType.maintenance;
      case ReminderType.waterTest:
        return db_types.ReminderType.waterTest;
      case ReminderType.medicationDose:
        return db_types.ReminderType.medicationDose;
      case ReminderType.custom:
        return db_types.ReminderType.custom;
    }
  }

  static db_types.RepeatFrequency _mapToDbRepeatFrequency(
    RepeatFrequency freq,
  ) {
    switch (freq) {
      case RepeatFrequency.none:
        return db_types.RepeatFrequency.none;
      case RepeatFrequency.daily:
        return db_types.RepeatFrequency.daily;
      case RepeatFrequency.weekly:
        return db_types.RepeatFrequency.weekly;
      case RepeatFrequency.biweekly:
        return db_types.RepeatFrequency.biweekly;
      case RepeatFrequency.monthly:
        return db_types.RepeatFrequency.monthly;
      case RepeatFrequency.custom:
        return db_types.RepeatFrequency.custom;
    }
  }
}
