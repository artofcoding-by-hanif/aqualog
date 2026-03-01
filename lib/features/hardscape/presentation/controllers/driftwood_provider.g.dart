// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driftwood_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for DriftwoodRepository

@ProviderFor(driftwoodRepository)
final driftwoodRepositoryProvider = DriftwoodRepositoryProvider._();

/// Provider for DriftwoodRepository

final class DriftwoodRepositoryProvider
    extends
        $FunctionalProvider<
          DriftwoodRepository,
          DriftwoodRepository,
          DriftwoodRepository
        >
    with $Provider<DriftwoodRepository> {
  /// Provider for DriftwoodRepository
  DriftwoodRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftwoodRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftwoodRepositoryHash();

  @$internal
  @override
  $ProviderElement<DriftwoodRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriftwoodRepository create(Ref ref) {
    return driftwoodRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriftwoodRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriftwoodRepository>(value),
    );
  }
}

String _$driftwoodRepositoryHash() =>
    r'9d6efd67f96f9cc1af3ef8c992815a2d7137e6bb';

/// Provider to watch all driftwoods for a tank

@ProviderFor(driftwoodsForTankStream)
final driftwoodsForTankStreamProvider = DriftwoodsForTankStreamFamily._();

/// Provider to watch all driftwoods for a tank

final class DriftwoodsForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DriftwoodEntity>>,
          List<DriftwoodEntity>,
          Stream<List<DriftwoodEntity>>
        >
    with
        $FutureModifier<List<DriftwoodEntity>>,
        $StreamProvider<List<DriftwoodEntity>> {
  /// Provider to watch all driftwoods for a tank
  DriftwoodsForTankStreamProvider._({
    required DriftwoodsForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'driftwoodsForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driftwoodsForTankStreamHash();

  @override
  String toString() {
    return r'driftwoodsForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<DriftwoodEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DriftwoodEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return driftwoodsForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DriftwoodsForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driftwoodsForTankStreamHash() =>
    r'82d8aae395ff5629dd0f78be8c976876ead89175';

/// Provider to watch all driftwoods for a tank

final class DriftwoodsForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<DriftwoodEntity>>, int> {
  DriftwoodsForTankStreamFamily._()
    : super(
        retry: null,
        name: r'driftwoodsForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all driftwoods for a tank

  DriftwoodsForTankStreamProvider call(int tankId) =>
      DriftwoodsForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'driftwoodsForTankStreamProvider';
}

/// Provider to get a driftwood by ID

@ProviderFor(driftwoodById)
final driftwoodByIdProvider = DriftwoodByIdFamily._();

/// Provider to get a driftwood by ID

final class DriftwoodByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<DriftwoodEntity?>,
          DriftwoodEntity?,
          FutureOr<DriftwoodEntity?>
        >
    with $FutureModifier<DriftwoodEntity?>, $FutureProvider<DriftwoodEntity?> {
  /// Provider to get a driftwood by ID
  DriftwoodByIdProvider._({
    required DriftwoodByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'driftwoodByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driftwoodByIdHash();

  @override
  String toString() {
    return r'driftwoodByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DriftwoodEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DriftwoodEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return driftwoodById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DriftwoodByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driftwoodByIdHash() => r'b9200a9cff6f75d6d390d53f2df9228b77794ebd';

/// Provider to get a driftwood by ID

final class DriftwoodByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<DriftwoodEntity?>, int> {
  DriftwoodByIdFamily._()
    : super(
        retry: null,
        name: r'driftwoodByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a driftwood by ID

  DriftwoodByIdProvider call(int id) =>
      DriftwoodByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'driftwoodByIdProvider';
}

/// Notifier for managing driftwood operations for a specific tank

@ProviderFor(DriftwoodNotifier)
final driftwoodProvider = DriftwoodNotifierFamily._();

/// Notifier for managing driftwood operations for a specific tank
final class DriftwoodNotifierProvider
    extends $AsyncNotifierProvider<DriftwoodNotifier, List<DriftwoodEntity>> {
  /// Notifier for managing driftwood operations for a specific tank
  DriftwoodNotifierProvider._({
    required DriftwoodNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'driftwoodProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driftwoodNotifierHash();

  @override
  String toString() {
    return r'driftwoodProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DriftwoodNotifier create() => DriftwoodNotifier();

  @override
  bool operator ==(Object other) {
    return other is DriftwoodNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driftwoodNotifierHash() => r'ddcf66c7c2a365001f71434ec59c7df5f38d3fa2';

/// Notifier for managing driftwood operations for a specific tank

final class DriftwoodNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DriftwoodNotifier,
          AsyncValue<List<DriftwoodEntity>>,
          List<DriftwoodEntity>,
          FutureOr<List<DriftwoodEntity>>,
          int
        > {
  DriftwoodNotifierFamily._()
    : super(
        retry: null,
        name: r'driftwoodProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing driftwood operations for a specific tank

  DriftwoodNotifierProvider call(int tankId) =>
      DriftwoodNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'driftwoodProvider';
}

/// Notifier for managing driftwood operations for a specific tank

abstract class _$DriftwoodNotifier
    extends $AsyncNotifier<List<DriftwoodEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<DriftwoodEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<DriftwoodEntity>>, List<DriftwoodEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DriftwoodEntity>>,
                List<DriftwoodEntity>
              >,
              AsyncValue<List<DriftwoodEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
