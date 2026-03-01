// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_parameter_log_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for WaterParameterLogRepository

@ProviderFor(waterParameterLogRepository)
final waterParameterLogRepositoryProvider =
    WaterParameterLogRepositoryProvider._();

/// Provider for WaterParameterLogRepository

final class WaterParameterLogRepositoryProvider
    extends
        $FunctionalProvider<
          WaterParameterLogRepository,
          WaterParameterLogRepository,
          WaterParameterLogRepository
        >
    with $Provider<WaterParameterLogRepository> {
  /// Provider for WaterParameterLogRepository
  WaterParameterLogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waterParameterLogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waterParameterLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<WaterParameterLogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WaterParameterLogRepository create(Ref ref) {
    return waterParameterLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WaterParameterLogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WaterParameterLogRepository>(value),
    );
  }
}

String _$waterParameterLogRepositoryHash() =>
    r'005986d7a2bd555be4aa80c5b8237d4b65fc66ea';

/// Provider to watch all water parameter logs for a tank

@ProviderFor(waterParameterLogsForTankStream)
final waterParameterLogsForTankStreamProvider =
    WaterParameterLogsForTankStreamFamily._();

/// Provider to watch all water parameter logs for a tank

final class WaterParameterLogsForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WaterParameterLogEntity>>,
          List<WaterParameterLogEntity>,
          Stream<List<WaterParameterLogEntity>>
        >
    with
        $FutureModifier<List<WaterParameterLogEntity>>,
        $StreamProvider<List<WaterParameterLogEntity>> {
  /// Provider to watch all water parameter logs for a tank
  WaterParameterLogsForTankStreamProvider._({
    required WaterParameterLogsForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'waterParameterLogsForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$waterParameterLogsForTankStreamHash();

  @override
  String toString() {
    return r'waterParameterLogsForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<WaterParameterLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WaterParameterLogEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return waterParameterLogsForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WaterParameterLogsForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$waterParameterLogsForTankStreamHash() =>
    r'12aad095144249b81633e4e08d4e1095a198d779';

/// Provider to watch all water parameter logs for a tank

final class WaterParameterLogsForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<WaterParameterLogEntity>>, int> {
  WaterParameterLogsForTankStreamFamily._()
    : super(
        retry: null,
        name: r'waterParameterLogsForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all water parameter logs for a tank

  WaterParameterLogsForTankStreamProvider call(int tankId) =>
      WaterParameterLogsForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'waterParameterLogsForTankStreamProvider';
}

/// Provider to get a water parameter log by ID

@ProviderFor(waterParameterLogById)
final waterParameterLogByIdProvider = WaterParameterLogByIdFamily._();

/// Provider to get a water parameter log by ID

final class WaterParameterLogByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<WaterParameterLogEntity?>,
          WaterParameterLogEntity?,
          FutureOr<WaterParameterLogEntity?>
        >
    with
        $FutureModifier<WaterParameterLogEntity?>,
        $FutureProvider<WaterParameterLogEntity?> {
  /// Provider to get a water parameter log by ID
  WaterParameterLogByIdProvider._({
    required WaterParameterLogByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'waterParameterLogByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$waterParameterLogByIdHash();

  @override
  String toString() {
    return r'waterParameterLogByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WaterParameterLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WaterParameterLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return waterParameterLogById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WaterParameterLogByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$waterParameterLogByIdHash() =>
    r'1a51a91d0a8bc8256d162def5de7c4d5193aa070';

/// Provider to get a water parameter log by ID

final class WaterParameterLogByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WaterParameterLogEntity?>, int> {
  WaterParameterLogByIdFamily._()
    : super(
        retry: null,
        name: r'waterParameterLogByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a water parameter log by ID

  WaterParameterLogByIdProvider call(int id) =>
      WaterParameterLogByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'waterParameterLogByIdProvider';
}

/// Provider to get the latest water parameter log for a tank

@ProviderFor(latestWaterParameterLog)
final latestWaterParameterLogProvider = LatestWaterParameterLogFamily._();

/// Provider to get the latest water parameter log for a tank

final class LatestWaterParameterLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<WaterParameterLogEntity?>,
          WaterParameterLogEntity?,
          FutureOr<WaterParameterLogEntity?>
        >
    with
        $FutureModifier<WaterParameterLogEntity?>,
        $FutureProvider<WaterParameterLogEntity?> {
  /// Provider to get the latest water parameter log for a tank
  LatestWaterParameterLogProvider._({
    required LatestWaterParameterLogFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'latestWaterParameterLogProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$latestWaterParameterLogHash();

  @override
  String toString() {
    return r'latestWaterParameterLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WaterParameterLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WaterParameterLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return latestWaterParameterLog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestWaterParameterLogProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$latestWaterParameterLogHash() =>
    r'1b05ca3c690a3bd685f1e57fcbb60f076de210f7';

/// Provider to get the latest water parameter log for a tank

final class LatestWaterParameterLogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WaterParameterLogEntity?>, int> {
  LatestWaterParameterLogFamily._()
    : super(
        retry: null,
        name: r'latestWaterParameterLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get the latest water parameter log for a tank

  LatestWaterParameterLogProvider call(int tankId) =>
      LatestWaterParameterLogProvider._(argument: tankId, from: this);

  @override
  String toString() => r'latestWaterParameterLogProvider';
}

/// Notifier for managing water parameter log operations for a specific tank

@ProviderFor(WaterParameterLogNotifier)
final waterParameterLogProvider = WaterParameterLogNotifierFamily._();

/// Notifier for managing water parameter log operations for a specific tank
final class WaterParameterLogNotifierProvider
    extends
        $AsyncNotifierProvider<
          WaterParameterLogNotifier,
          List<WaterParameterLogEntity>
        > {
  /// Notifier for managing water parameter log operations for a specific tank
  WaterParameterLogNotifierProvider._({
    required WaterParameterLogNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'waterParameterLogProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$waterParameterLogNotifierHash();

  @override
  String toString() {
    return r'waterParameterLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WaterParameterLogNotifier create() => WaterParameterLogNotifier();

  @override
  bool operator ==(Object other) {
    return other is WaterParameterLogNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$waterParameterLogNotifierHash() =>
    r'a8c5126208d2edd1ddcba45a12c2b962e8dbef01';

/// Notifier for managing water parameter log operations for a specific tank

final class WaterParameterLogNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          WaterParameterLogNotifier,
          AsyncValue<List<WaterParameterLogEntity>>,
          List<WaterParameterLogEntity>,
          FutureOr<List<WaterParameterLogEntity>>,
          int
        > {
  WaterParameterLogNotifierFamily._()
    : super(
        retry: null,
        name: r'waterParameterLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing water parameter log operations for a specific tank

  WaterParameterLogNotifierProvider call(int tankId) =>
      WaterParameterLogNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'waterParameterLogProvider';
}

/// Notifier for managing water parameter log operations for a specific tank

abstract class _$WaterParameterLogNotifier
    extends $AsyncNotifier<List<WaterParameterLogEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<WaterParameterLogEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<WaterParameterLogEntity>>,
              List<WaterParameterLogEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WaterParameterLogEntity>>,
                List<WaterParameterLogEntity>
              >,
              AsyncValue<List<WaterParameterLogEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Provider to watch recent water parameter logs across all tanks (for dashboard)

@ProviderFor(recentWaterParameterLogsStream)
final recentWaterParameterLogsStreamProvider =
    RecentWaterParameterLogsStreamProvider._();

/// Provider to watch recent water parameter logs across all tanks (for dashboard)

final class RecentWaterParameterLogsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WaterParameterLogEntity>>,
          List<WaterParameterLogEntity>,
          Stream<List<WaterParameterLogEntity>>
        >
    with
        $FutureModifier<List<WaterParameterLogEntity>>,
        $StreamProvider<List<WaterParameterLogEntity>> {
  /// Provider to watch recent water parameter logs across all tanks (for dashboard)
  RecentWaterParameterLogsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentWaterParameterLogsStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentWaterParameterLogsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<WaterParameterLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WaterParameterLogEntity>> create(Ref ref) {
    return recentWaterParameterLogsStream(ref);
  }
}

String _$recentWaterParameterLogsStreamHash() =>
    r'b2b805c2c6b6af40eae43a3c69df5ae717e2058a';
