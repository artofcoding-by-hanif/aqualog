// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for ReminderRepository

@ProviderFor(reminderRepository)
final reminderRepositoryProvider = ReminderRepositoryProvider._();

/// Provider for ReminderRepository

final class ReminderRepositoryProvider
    extends
        $FunctionalProvider<
          ReminderRepository,
          ReminderRepository,
          ReminderRepository
        >
    with $Provider<ReminderRepository> {
  /// Provider for ReminderRepository
  ReminderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReminderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderRepository create(Ref ref) {
    return reminderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderRepository>(value),
    );
  }
}

String _$reminderRepositoryHash() =>
    r'0aec11d9c0dc57bfb0f88692709ab3f8eadbb434';

/// Provider for ReminderScheduler

@ProviderFor(reminderScheduler)
final reminderSchedulerProvider = ReminderSchedulerProvider._();

/// Provider for ReminderScheduler

final class ReminderSchedulerProvider
    extends
        $FunctionalProvider<
          ReminderScheduler,
          ReminderScheduler,
          ReminderScheduler
        >
    with $Provider<ReminderScheduler> {
  /// Provider for ReminderScheduler
  ReminderSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSchedulerHash();

  @$internal
  @override
  $ProviderElement<ReminderScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderScheduler create(Ref ref) {
    return reminderScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderScheduler>(value),
    );
  }
}

String _$reminderSchedulerHash() => r'6ed097e75024134425eaaf4b2ece6329415aa851';

/// Provider to watch all reminders

@ProviderFor(remindersStream)
final remindersStreamProvider = RemindersStreamProvider._();

/// Provider to watch all reminders

final class RemindersStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReminderEntity>>,
          List<ReminderEntity>,
          Stream<List<ReminderEntity>>
        >
    with
        $FutureModifier<List<ReminderEntity>>,
        $StreamProvider<List<ReminderEntity>> {
  /// Provider to watch all reminders
  RemindersStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<ReminderEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ReminderEntity>> create(Ref ref) {
    return remindersStream(ref);
  }
}

String _$remindersStreamHash() => r'b4bb044ba83b073b4de5d7c24155bec3b7739ed7';

/// Provider to watch reminders for a specific tank

@ProviderFor(remindersForTankStream)
final remindersForTankStreamProvider = RemindersForTankStreamFamily._();

/// Provider to watch reminders for a specific tank

final class RemindersForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReminderEntity>>,
          List<ReminderEntity>,
          Stream<List<ReminderEntity>>
        >
    with
        $FutureModifier<List<ReminderEntity>>,
        $StreamProvider<List<ReminderEntity>> {
  /// Provider to watch reminders for a specific tank
  RemindersForTankStreamProvider._({
    required RemindersForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'remindersForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remindersForTankStreamHash();

  @override
  String toString() {
    return r'remindersForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ReminderEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ReminderEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return remindersForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemindersForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remindersForTankStreamHash() =>
    r'9e2b6fd0bdfcc244e0ed590cc1c27dab21281402';

/// Provider to watch reminders for a specific tank

final class RemindersForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ReminderEntity>>, int> {
  RemindersForTankStreamFamily._()
    : super(
        retry: null,
        name: r'remindersForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch reminders for a specific tank

  RemindersForTankStreamProvider call(int tankId) =>
      RemindersForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'remindersForTankStreamProvider';
}

/// Provider to get a reminder by ID

@ProviderFor(reminderById)
final reminderByIdProvider = ReminderByIdFamily._();

/// Provider to get a reminder by ID

final class ReminderByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReminderEntity?>,
          ReminderEntity?,
          FutureOr<ReminderEntity?>
        >
    with $FutureModifier<ReminderEntity?>, $FutureProvider<ReminderEntity?> {
  /// Provider to get a reminder by ID
  ReminderByIdProvider._({
    required ReminderByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reminderByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reminderByIdHash();

  @override
  String toString() {
    return r'reminderByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ReminderEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReminderEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return reminderById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReminderByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reminderByIdHash() => r'55ac0075d4f61f1f53c16c4b6417313ea7ca9a81';

/// Provider to get a reminder by ID

final class ReminderByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ReminderEntity?>, int> {
  ReminderByIdFamily._()
    : super(
        retry: null,
        name: r'reminderByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to get a reminder by ID

  ReminderByIdProvider call(int id) =>
      ReminderByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'reminderByIdProvider';
}

/// Provider to get overdue reminders

@ProviderFor(overdueReminders)
final overdueRemindersProvider = OverdueRemindersProvider._();

/// Provider to get overdue reminders

final class OverdueRemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReminderEntity>>,
          List<ReminderEntity>,
          FutureOr<List<ReminderEntity>>
        >
    with
        $FutureModifier<List<ReminderEntity>>,
        $FutureProvider<List<ReminderEntity>> {
  /// Provider to get overdue reminders
  OverdueRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overdueRemindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overdueRemindersHash();

  @$internal
  @override
  $FutureProviderElement<List<ReminderEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReminderEntity>> create(Ref ref) {
    return overdueReminders(ref);
  }
}

String _$overdueRemindersHash() => r'320d8a40691adda77b0fe3cceba5ea97d427fc5b';

/// Provider to get upcoming reminders

@ProviderFor(upcomingReminders)
final upcomingRemindersProvider = UpcomingRemindersFamily._();

/// Provider to get upcoming reminders

final class UpcomingRemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReminderEntity>>,
          List<ReminderEntity>,
          FutureOr<List<ReminderEntity>>
        >
    with
        $FutureModifier<List<ReminderEntity>>,
        $FutureProvider<List<ReminderEntity>> {
  /// Provider to get upcoming reminders
  UpcomingRemindersProvider._({
    required UpcomingRemindersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'upcomingRemindersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingRemindersHash();

  @override
  String toString() {
    return r'upcomingRemindersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReminderEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReminderEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return upcomingReminders(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingRemindersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingRemindersHash() => r'715a6c32c9b69dcb3a4e7c55a7acfff7c0e082e5';

/// Provider to get upcoming reminders

final class UpcomingRemindersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReminderEntity>>, int> {
  UpcomingRemindersFamily._()
    : super(
        retry: null,
        name: r'upcomingRemindersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to get upcoming reminders

  UpcomingRemindersProvider call(int withinDays) =>
      UpcomingRemindersProvider._(argument: withinDays, from: this);

  @override
  String toString() => r'upcomingRemindersProvider';
}

/// Notifier for managing reminder operations with notification scheduling

@ProviderFor(ReminderNotifier)
final reminderProvider = ReminderNotifierProvider._();

/// Notifier for managing reminder operations with notification scheduling
final class ReminderNotifierProvider
    extends $AsyncNotifierProvider<ReminderNotifier, List<ReminderEntity>> {
  /// Notifier for managing reminder operations with notification scheduling
  ReminderNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderNotifierHash();

  @$internal
  @override
  ReminderNotifier create() => ReminderNotifier();
}

String _$reminderNotifierHash() => r'89e9e5b2538a23d68fc40afef42c90b097c242d4';

/// Notifier for managing reminder operations with notification scheduling

abstract class _$ReminderNotifier extends $AsyncNotifier<List<ReminderEntity>> {
  FutureOr<List<ReminderEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ReminderEntity>>, List<ReminderEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ReminderEntity>>,
                List<ReminderEntity>
              >,
              AsyncValue<List<ReminderEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for managing reminders for a specific tank with notification scheduling

@ProviderFor(TankReminderNotifier)
final tankReminderProvider = TankReminderNotifierFamily._();

/// Notifier for managing reminders for a specific tank with notification scheduling
final class TankReminderNotifierProvider
    extends $AsyncNotifierProvider<TankReminderNotifier, List<ReminderEntity>> {
  /// Notifier for managing reminders for a specific tank with notification scheduling
  TankReminderNotifierProvider._({
    required TankReminderNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tankReminderProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tankReminderNotifierHash();

  @override
  String toString() {
    return r'tankReminderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TankReminderNotifier create() => TankReminderNotifier();

  @override
  bool operator ==(Object other) {
    return other is TankReminderNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tankReminderNotifierHash() =>
    r'd6822262933c56755bd84c934ce47a733e0de753';

/// Notifier for managing reminders for a specific tank with notification scheduling

final class TankReminderNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TankReminderNotifier,
          AsyncValue<List<ReminderEntity>>,
          List<ReminderEntity>,
          FutureOr<List<ReminderEntity>>,
          int
        > {
  TankReminderNotifierFamily._()
    : super(
        retry: null,
        name: r'tankReminderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing reminders for a specific tank with notification scheduling

  TankReminderNotifierProvider call(int tankId) =>
      TankReminderNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'tankReminderProvider';
}

/// Notifier for managing reminders for a specific tank with notification scheduling

abstract class _$TankReminderNotifier
    extends $AsyncNotifier<List<ReminderEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<ReminderEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ReminderEntity>>, List<ReminderEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ReminderEntity>>,
                List<ReminderEntity>
              >,
              AsyncValue<List<ReminderEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
