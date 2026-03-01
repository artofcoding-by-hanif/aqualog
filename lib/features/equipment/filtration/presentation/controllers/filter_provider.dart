import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/database/database_provider.dart';
import '../../data/repositories/filter_repository_impl.dart';
import '../../domain/entities/filter.dart';
import '../../domain/repositories/filter_repository.dart';

part 'filter_provider.g.dart';

/// Provider for FilterRepository
@Riverpod(keepAlive: true)
FilterRepository filterRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return FilterRepositoryImpl(database: db);
}

/// Provider to watch all filters for a tank
@Riverpod(keepAlive: true)
Stream<List<FilterEntity>> filtersForTankStream(Ref ref, int tankId) {
  final repo = ref.watch(filterRepositoryProvider);
  return repo.watchFiltersForTank(tankId);
}

/// Provider to get a filter by ID
@Riverpod(keepAlive: true)
Future<FilterEntity?> filterById(Ref ref, int id) async {
  final repo = ref.watch(filterRepositoryProvider);
  return repo.getFilterById(id);
}

/// Notifier for managing filter operations for a specific tank
@Riverpod(keepAlive: true)
class FilterNotifier extends _$FilterNotifier {
  @override
  Future<List<FilterEntity>> build(int tankId) async {
    final repo = ref.watch(filterRepositoryProvider);
    return repo.getFiltersForTank(tankId);
  }

  FilterRepository get _repo => ref.read(filterRepositoryProvider);
  AppDatabase get _db => ref.read(appDatabaseProvider);

  /// Add a new filter and create associated reminders
  Future<int> addFilter(FilterEntity filter) async {
    final id = await _repo.addFilter(filter);
    // Create reminders for cleaning and media replacement
    await _createFilterReminders(filter.copyWith(id: id));
    ref.invalidateSelf();
    return id;
  }

  /// Update an existing filter and update associated reminders
  Future<void> updateFilter(FilterEntity filter) async {
    await _repo.updateFilter(filter);
    // Update reminder intervals if they changed
    await _updateFilterReminders(filter);
    ref.invalidateSelf();
  }

  /// Delete a filter and its associated reminders
  Future<void> deleteFilter(int id) async {
    // Delete associated reminders first
    await _db.deleteRemindersForFilter(id);
    await _repo.deleteFilter(id);
    ref.invalidateSelf();
  }

  /// Record filter cleaning and reschedule reminder
  Future<void> recordCleaning(FilterEntity filter) async {
    final now = DateTime.now();
    final updated = filter.copyWith(lastCleanedAt: now);
    await _repo.updateFilter(updated);
    // Reschedule the cleaning reminder
    await _rescheduleCleaningReminder(filter, now);
    ref.invalidateSelf();
  }

  /// Record media replacement and reschedule reminder
  Future<void> recordMediaReplacement(FilterEntity filter) async {
    final now = DateTime.now();
    final updated = filter.copyWith(mediaReplacedAt: now);
    await _repo.updateFilter(updated);
    // Reschedule the media replacement reminder
    await _rescheduleMediaReplacementReminder(filter, now);
    ref.invalidateSelf();
  }

  // ============================================================
  // Private Helper Methods for Reminder Management
  // ============================================================

  /// Create reminders for a new filter (cleaning and media replacement)
  Future<void> _createFilterReminders(FilterEntity filter) async {
    final now = DateTime.now();

    // Create cleaning reminder
    final cleaningScheduledAt = filter.lastCleanedAt != null
        ? filter.lastCleanedAt!.add(Duration(days: filter.cleaningIntervalDays))
        : now.add(Duration(days: filter.cleaningIntervalDays));

    await _db.insertReminder(
      RemindersCompanion.insert(
        tankId: Value(filter.tankId),
        filterId: Value(filter.id),
        title: '${filter.name} - Clean Filter',
        description: Value(
          'Time to clean your ${filter.filterType.displayName} filter',
        ),
        reminderType: ReminderType.cleaning,
        scheduledAt: cleaningScheduledAt,
        repeatFrequency: const Value(RepeatFrequency.custom),
        customIntervalDays: Value(filter.cleaningIntervalDays),
      ),
    );

    // Create media replacement reminder
    final mediaScheduledAt = filter.mediaReplacedAt != null
        ? filter.mediaReplacedAt!.add(
            Duration(days: filter.mediaReplacementIntervalDays),
          )
        : now.add(Duration(days: filter.mediaReplacementIntervalDays));

    await _db.insertReminder(
      RemindersCompanion.insert(
        tankId: Value(filter.tankId),
        filterId: Value(filter.id),
        title: '${filter.name} - Replace Media',
        description: Value(
          'Time to replace media in your ${filter.filterType.displayName} filter',
        ),
        reminderType: ReminderType.maintenance,
        scheduledAt: mediaScheduledAt,
        repeatFrequency: const Value(RepeatFrequency.custom),
        customIntervalDays: Value(filter.mediaReplacementIntervalDays),
      ),
    );
  }

  /// Update reminders when filter intervals change
  Future<void> _updateFilterReminders(FilterEntity filter) async {
    if (filter.id == null) return;

    // Update cleaning reminder interval
    final cleaningReminder = await _db.getReminderByFilterAndType(
      filter.id!,
      ReminderType.cleaning,
    );
    if (cleaningReminder != null) {
      final updatedCleaningReminder = cleaningReminder.copyWith(
        title: '${filter.name} - Clean Filter',
        customIntervalDays: Value(filter.cleaningIntervalDays),
      );
      await _db.updateReminder(updatedCleaningReminder);
    }

    // Update media replacement reminder interval
    final mediaReminder = await _db.getReminderByFilterAndType(
      filter.id!,
      ReminderType.maintenance,
    );
    if (mediaReminder != null) {
      final updatedMediaReminder = mediaReminder.copyWith(
        title: '${filter.name} - Replace Media',
        customIntervalDays: Value(filter.mediaReplacementIntervalDays),
      );
      await _db.updateReminder(updatedMediaReminder);
    }
  }

  /// Reschedule cleaning reminder after cleaning is recorded
  Future<void> _rescheduleCleaningReminder(
    FilterEntity filter,
    DateTime lastCleanedAt,
  ) async {
    if (filter.id == null) return;

    final reminder = await _db.getReminderByFilterAndType(
      filter.id!,
      ReminderType.cleaning,
    );
    if (reminder != null) {
      final nextScheduledAt = lastCleanedAt.add(
        Duration(days: filter.cleaningIntervalDays),
      );
      await _db.updateReminderScheduledAt(reminder.id, nextScheduledAt);
    }
  }

  /// Reschedule media replacement reminder after media is replaced
  Future<void> _rescheduleMediaReplacementReminder(
    FilterEntity filter,
    DateTime mediaReplacedAt,
  ) async {
    if (filter.id == null) return;

    final reminder = await _db.getReminderByFilterAndType(
      filter.id!,
      ReminderType.maintenance,
    );
    if (reminder != null) {
      final nextScheduledAt = mediaReplacedAt.add(
        Duration(days: filter.mediaReplacementIntervalDays),
      );
      await _db.updateReminderScheduledAt(reminder.id, nextScheduledAt);
    }
  }
}
