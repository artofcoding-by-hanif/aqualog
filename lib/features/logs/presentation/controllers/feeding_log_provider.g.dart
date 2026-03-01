// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_log_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for FeedingLogRepository

@ProviderFor(feedingLogRepository)
final feedingLogRepositoryProvider = FeedingLogRepositoryProvider._();

/// Provider for FeedingLogRepository

final class FeedingLogRepositoryProvider
    extends
        $FunctionalProvider<
          FeedingLogRepository,
          FeedingLogRepository,
          FeedingLogRepository
        >
    with $Provider<FeedingLogRepository> {
  /// Provider for FeedingLogRepository
  FeedingLogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedingLogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedingLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<FeedingLogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeedingLogRepository create(Ref ref) {
    return feedingLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedingLogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedingLogRepository>(value),
    );
  }
}

String _$feedingLogRepositoryHash() =>
    r'f78f25c7a279424a3c7c038c8a810d34b3c257a1';

/// Provider to watch all feeding logs for a tank

@ProviderFor(feedingLogsForTankStream)
final feedingLogsForTankStreamProvider = FeedingLogsForTankStreamFamily._();

/// Provider to watch all feeding logs for a tank

final class FeedingLogsForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FeedingLogEntity>>,
          List<FeedingLogEntity>,
          Stream<List<FeedingLogEntity>>
        >
    with
        $FutureModifier<List<FeedingLogEntity>>,
        $StreamProvider<List<FeedingLogEntity>> {
  /// Provider to watch all feeding logs for a tank
  FeedingLogsForTankStreamProvider._({
    required FeedingLogsForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'feedingLogsForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedingLogsForTankStreamHash();

  @override
  String toString() {
    return r'feedingLogsForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<FeedingLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FeedingLogEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return feedingLogsForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedingLogsForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedingLogsForTankStreamHash() =>
    r'2c806f9d42256053bd57801ac812b55729c4e5bf';

/// Provider to watch all feeding logs for a tank

final class FeedingLogsForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<FeedingLogEntity>>, int> {
  FeedingLogsForTankStreamFamily._()
    : super(
        retry: null,
        name: r'feedingLogsForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all feeding logs for a tank

  FeedingLogsForTankStreamProvider call(int tankId) =>
      FeedingLogsForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'feedingLogsForTankStreamProvider';
}

/// Provider to get a feeding log by ID

@ProviderFor(feedingLogById)
final feedingLogByIdProvider = FeedingLogByIdFamily._();

/// Provider to get a feeding log by ID

final class FeedingLogByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<FeedingLogEntity?>,
          FeedingLogEntity?,
          FutureOr<FeedingLogEntity?>
        >
    with
        $FutureModifier<FeedingLogEntity?>,
        $FutureProvider<FeedingLogEntity?> {
  /// Provider to get a feeding log by ID
  FeedingLogByIdProvider._({
    required FeedingLogByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'feedingLogByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedingLogByIdHash();

  @override
  String toString() {
    return r'feedingLogByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FeedingLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FeedingLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return feedingLogById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedingLogByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedingLogByIdHash() => r'e337b7e733612c25fbfc562cddd18f718d2c03c1';

/// Provider to get a feeding log by ID

final class FeedingLogByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FeedingLogEntity?>, int> {
  FeedingLogByIdFamily._()
    : super(
        retry: null,
        name: r'feedingLogByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a feeding log by ID

  FeedingLogByIdProvider call(int id) =>
      FeedingLogByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'feedingLogByIdProvider';
}

/// Provider to get the latest feeding log for a tank

@ProviderFor(latestFeedingLog)
final latestFeedingLogProvider = LatestFeedingLogFamily._();

/// Provider to get the latest feeding log for a tank

final class LatestFeedingLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<FeedingLogEntity?>,
          FeedingLogEntity?,
          FutureOr<FeedingLogEntity?>
        >
    with
        $FutureModifier<FeedingLogEntity?>,
        $FutureProvider<FeedingLogEntity?> {
  /// Provider to get the latest feeding log for a tank
  LatestFeedingLogProvider._({
    required LatestFeedingLogFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'latestFeedingLogProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$latestFeedingLogHash();

  @override
  String toString() {
    return r'latestFeedingLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FeedingLogEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FeedingLogEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return latestFeedingLog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestFeedingLogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$latestFeedingLogHash() => r'45d201bcbbb793af3448223430d7e8b05c592d58';

/// Provider to get the latest feeding log for a tank

final class LatestFeedingLogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FeedingLogEntity?>, int> {
  LatestFeedingLogFamily._()
    : super(
        retry: null,
        name: r'latestFeedingLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get the latest feeding log for a tank

  LatestFeedingLogProvider call(int tankId) =>
      LatestFeedingLogProvider._(argument: tankId, from: this);

  @override
  String toString() => r'latestFeedingLogProvider';
}

/// Provider to get today's feeding logs for a tank

@ProviderFor(todaysFeedingLogs)
final todaysFeedingLogsProvider = TodaysFeedingLogsFamily._();

/// Provider to get today's feeding logs for a tank

final class TodaysFeedingLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FeedingLogEntity>>,
          List<FeedingLogEntity>,
          FutureOr<List<FeedingLogEntity>>
        >
    with
        $FutureModifier<List<FeedingLogEntity>>,
        $FutureProvider<List<FeedingLogEntity>> {
  /// Provider to get today's feeding logs for a tank
  TodaysFeedingLogsProvider._({
    required TodaysFeedingLogsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'todaysFeedingLogsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$todaysFeedingLogsHash();

  @override
  String toString() {
    return r'todaysFeedingLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FeedingLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FeedingLogEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return todaysFeedingLogs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TodaysFeedingLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$todaysFeedingLogsHash() => r'2789334431882658a64d291258602e9214a00afb';

/// Provider to get today's feeding logs for a tank

final class TodaysFeedingLogsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FeedingLogEntity>>, int> {
  TodaysFeedingLogsFamily._()
    : super(
        retry: null,
        name: r'todaysFeedingLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get today's feeding logs for a tank

  TodaysFeedingLogsProvider call(int tankId) =>
      TodaysFeedingLogsProvider._(argument: tankId, from: this);

  @override
  String toString() => r'todaysFeedingLogsProvider';
}

/// Notifier for managing feeding log operations for a specific tank

@ProviderFor(FeedingLogNotifier)
final feedingLogProvider = FeedingLogNotifierFamily._();

/// Notifier for managing feeding log operations for a specific tank
final class FeedingLogNotifierProvider
    extends $AsyncNotifierProvider<FeedingLogNotifier, List<FeedingLogEntity>> {
  /// Notifier for managing feeding log operations for a specific tank
  FeedingLogNotifierProvider._({
    required FeedingLogNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'feedingLogProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedingLogNotifierHash();

  @override
  String toString() {
    return r'feedingLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FeedingLogNotifier create() => FeedingLogNotifier();

  @override
  bool operator ==(Object other) {
    return other is FeedingLogNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedingLogNotifierHash() =>
    r'ddc51a2bfebea42f0c74bdb510a952c7eff7d61d';

/// Notifier for managing feeding log operations for a specific tank

final class FeedingLogNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FeedingLogNotifier,
          AsyncValue<List<FeedingLogEntity>>,
          List<FeedingLogEntity>,
          FutureOr<List<FeedingLogEntity>>,
          int
        > {
  FeedingLogNotifierFamily._()
    : super(
        retry: null,
        name: r'feedingLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing feeding log operations for a specific tank

  FeedingLogNotifierProvider call(int tankId) =>
      FeedingLogNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'feedingLogProvider';
}

/// Notifier for managing feeding log operations for a specific tank

abstract class _$FeedingLogNotifier
    extends $AsyncNotifier<List<FeedingLogEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<FeedingLogEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<FeedingLogEntity>>, List<FeedingLogEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FeedingLogEntity>>,
                List<FeedingLogEntity>
              >,
              AsyncValue<List<FeedingLogEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Provider to watch recent feeding logs across all tanks (for dashboard)

@ProviderFor(recentFeedingLogsStream)
final recentFeedingLogsStreamProvider = RecentFeedingLogsStreamProvider._();

/// Provider to watch recent feeding logs across all tanks (for dashboard)

final class RecentFeedingLogsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FeedingLogEntity>>,
          List<FeedingLogEntity>,
          Stream<List<FeedingLogEntity>>
        >
    with
        $FutureModifier<List<FeedingLogEntity>>,
        $StreamProvider<List<FeedingLogEntity>> {
  /// Provider to watch recent feeding logs across all tanks (for dashboard)
  RecentFeedingLogsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentFeedingLogsStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentFeedingLogsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<FeedingLogEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FeedingLogEntity>> create(Ref ref) {
    return recentFeedingLogsStream(ref);
  }
}

String _$recentFeedingLogsStreamHash() =>
    r'9657c31deed6c4eab6db30b1fcbf492b178f01ce';
