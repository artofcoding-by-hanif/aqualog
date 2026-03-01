// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_log_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for MaintenanceLogRepository

@ProviderFor(maintenanceLogRepository)
final maintenanceLogRepositoryProvider = MaintenanceLogRepositoryProvider._();

/// Provider for MaintenanceLogRepository

final class MaintenanceLogRepositoryProvider
    extends
        $FunctionalProvider<
          MaintenanceLogRepository,
          MaintenanceLogRepository,
          MaintenanceLogRepository
        >
    with $Provider<MaintenanceLogRepository> {
  /// Provider for MaintenanceLogRepository
  MaintenanceLogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'maintenanceLogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$maintenanceLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<MaintenanceLogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MaintenanceLogRepository create(Ref ref) {
    return maintenanceLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MaintenanceLogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MaintenanceLogRepository>(value),
    );
  }
}

String _$maintenanceLogRepositoryHash() =>
    r'5e13da1681c4fdad79bd36a19e48a38b6d1ceeff';

/// Provider to watch all maintenance logs for a tank

@ProviderFor(maintenanceLogsForTankStream)
final maintenanceLogsForTankStreamProvider =
    MaintenanceLogsForTankStreamFamily._();

/// Provider to watch all maintenance logs for a tank

final class MaintenanceLogsForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MaintenanceLogEntity>>,
          List<MaintenanceLogEntity>,
          Stream<List<MaintenanceLogEntity>>
        >
    with
        $FutureModifier<List<MaintenanceLogEntity>>,
        $StreamProvider<List<MaintenanceLogEntity>> {
  /// Provider to watch all maintenance logs for a tank
  MaintenanceLogsForTankStreamProvider._({
    required MaintenanceLogsForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'maintenanceLogsForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$maintenanceLogsForTankStreamHash();

  @override
  String toString() {
    return r'maintenanceLogsForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<MaintenanceLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MaintenanceLogEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return maintenanceLogsForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MaintenanceLogsForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$maintenanceLogsForTankStreamHash() =>
    r'878e68a1e5fa8ed857d239be5ddae9a90fe4b3e1';

/// Provider to watch all maintenance logs for a tank

final class MaintenanceLogsForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<MaintenanceLogEntity>>, int> {
  MaintenanceLogsForTankStreamFamily._()
    : super(
        retry: null,
        name: r'maintenanceLogsForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all maintenance logs for a tank

  MaintenanceLogsForTankStreamProvider call(int tankId) =>
      MaintenanceLogsForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'maintenanceLogsForTankStreamProvider';
}

/// Provider to get a maintenance log by ID

@ProviderFor(maintenanceLogById)
final maintenanceLogByIdProvider = MaintenanceLogByIdFamily._();

/// Provider to get a maintenance log by ID

final class MaintenanceLogByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<MaintenanceLogEntity?>,
          MaintenanceLogEntity?,
          FutureOr<MaintenanceLogEntity?>
        >
    with
        $FutureModifier<MaintenanceLogEntity?>,
        $FutureProvider<MaintenanceLogEntity?> {
  /// Provider to get a maintenance log by ID
  MaintenanceLogByIdProvider._({
    required MaintenanceLogByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'maintenanceLogByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$maintenanceLogByIdHash();

  @override
  String toString() {
    return r'maintenanceLogByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MaintenanceLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MaintenanceLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return maintenanceLogById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MaintenanceLogByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$maintenanceLogByIdHash() =>
    r'2ba10e380090a77204ae5d8d099a2b88b42d2ebe';

/// Provider to get a maintenance log by ID

final class MaintenanceLogByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MaintenanceLogEntity?>, int> {
  MaintenanceLogByIdFamily._()
    : super(
        retry: null,
        name: r'maintenanceLogByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a maintenance log by ID

  MaintenanceLogByIdProvider call(int id) =>
      MaintenanceLogByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'maintenanceLogByIdProvider';
}

/// Provider to get the latest maintenance log for a tank

@ProviderFor(latestMaintenanceLog)
final latestMaintenanceLogProvider = LatestMaintenanceLogFamily._();

/// Provider to get the latest maintenance log for a tank

final class LatestMaintenanceLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<MaintenanceLogEntity?>,
          MaintenanceLogEntity?,
          FutureOr<MaintenanceLogEntity?>
        >
    with
        $FutureModifier<MaintenanceLogEntity?>,
        $FutureProvider<MaintenanceLogEntity?> {
  /// Provider to get the latest maintenance log for a tank
  LatestMaintenanceLogProvider._({
    required LatestMaintenanceLogFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'latestMaintenanceLogProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$latestMaintenanceLogHash();

  @override
  String toString() {
    return r'latestMaintenanceLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MaintenanceLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MaintenanceLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return latestMaintenanceLog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestMaintenanceLogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$latestMaintenanceLogHash() =>
    r'8f86324eb9d66614c5aa693b17258f4ae2b9f345';

/// Provider to get the latest maintenance log for a tank

final class LatestMaintenanceLogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MaintenanceLogEntity?>, int> {
  LatestMaintenanceLogFamily._()
    : super(
        retry: null,
        name: r'latestMaintenanceLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get the latest maintenance log for a tank

  LatestMaintenanceLogProvider call(int tankId) =>
      LatestMaintenanceLogProvider._(argument: tankId, from: this);

  @override
  String toString() => r'latestMaintenanceLogProvider';
}

/// Provider to get the latest water change for a tank

@ProviderFor(latestWaterChange)
final latestWaterChangeProvider = LatestWaterChangeFamily._();

/// Provider to get the latest water change for a tank

final class LatestWaterChangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<MaintenanceLogEntity?>,
          MaintenanceLogEntity?,
          FutureOr<MaintenanceLogEntity?>
        >
    with
        $FutureModifier<MaintenanceLogEntity?>,
        $FutureProvider<MaintenanceLogEntity?> {
  /// Provider to get the latest water change for a tank
  LatestWaterChangeProvider._({
    required LatestWaterChangeFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'latestWaterChangeProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$latestWaterChangeHash();

  @override
  String toString() {
    return r'latestWaterChangeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MaintenanceLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MaintenanceLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return latestWaterChange(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestWaterChangeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$latestWaterChangeHash() => r'b34c8fa3e0bf81b57a35417ffc5f653e38d1293a';

/// Provider to get the latest water change for a tank

final class LatestWaterChangeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MaintenanceLogEntity?>, int> {
  LatestWaterChangeFamily._()
    : super(
        retry: null,
        name: r'latestWaterChangeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get the latest water change for a tank

  LatestWaterChangeProvider call(int tankId) =>
      LatestWaterChangeProvider._(argument: tankId, from: this);

  @override
  String toString() => r'latestWaterChangeProvider';
}

/// Notifier for managing maintenance log operations for a specific tank

@ProviderFor(MaintenanceLogNotifier)
final maintenanceLogProvider = MaintenanceLogNotifierFamily._();

/// Notifier for managing maintenance log operations for a specific tank
final class MaintenanceLogNotifierProvider
    extends
        $AsyncNotifierProvider<
          MaintenanceLogNotifier,
          List<MaintenanceLogEntity>
        > {
  /// Notifier for managing maintenance log operations for a specific tank
  MaintenanceLogNotifierProvider._({
    required MaintenanceLogNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'maintenanceLogProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$maintenanceLogNotifierHash();

  @override
  String toString() {
    return r'maintenanceLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MaintenanceLogNotifier create() => MaintenanceLogNotifier();

  @override
  bool operator ==(Object other) {
    return other is MaintenanceLogNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$maintenanceLogNotifierHash() =>
    r'44621fbc0b42d26f1c8169649e1c11581b8f4b62';

/// Notifier for managing maintenance log operations for a specific tank

final class MaintenanceLogNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MaintenanceLogNotifier,
          AsyncValue<List<MaintenanceLogEntity>>,
          List<MaintenanceLogEntity>,
          FutureOr<List<MaintenanceLogEntity>>,
          int
        > {
  MaintenanceLogNotifierFamily._()
    : super(
        retry: null,
        name: r'maintenanceLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing maintenance log operations for a specific tank

  MaintenanceLogNotifierProvider call(int tankId) =>
      MaintenanceLogNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'maintenanceLogProvider';
}

/// Notifier for managing maintenance log operations for a specific tank

abstract class _$MaintenanceLogNotifier
    extends $AsyncNotifier<List<MaintenanceLogEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<MaintenanceLogEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<MaintenanceLogEntity>>,
              List<MaintenanceLogEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MaintenanceLogEntity>>,
                List<MaintenanceLogEntity>
              >,
              AsyncValue<List<MaintenanceLogEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Provider to watch recent maintenance logs across all tanks (for dashboard)

@ProviderFor(recentMaintenanceLogsStream)
final recentMaintenanceLogsStreamProvider =
    RecentMaintenanceLogsStreamProvider._();

/// Provider to watch recent maintenance logs across all tanks (for dashboard)

final class RecentMaintenanceLogsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MaintenanceLogEntity>>,
          List<MaintenanceLogEntity>,
          Stream<List<MaintenanceLogEntity>>
        >
    with
        $FutureModifier<List<MaintenanceLogEntity>>,
        $StreamProvider<List<MaintenanceLogEntity>> {
  /// Provider to watch recent maintenance logs across all tanks (for dashboard)
  RecentMaintenanceLogsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentMaintenanceLogsStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentMaintenanceLogsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<MaintenanceLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MaintenanceLogEntity>> create(Ref ref) {
    return recentMaintenanceLogsStream(ref);
  }
}

String _$recentMaintenanceLogsStreamHash() =>
    r'89c0a3df8d4f6c7ef38371110f2ac02d5eec97f0';
