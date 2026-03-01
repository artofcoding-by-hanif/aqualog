// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rock_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for RockRepository

@ProviderFor(rockRepository)
final rockRepositoryProvider = RockRepositoryProvider._();

/// Provider for RockRepository

final class RockRepositoryProvider
    extends $FunctionalProvider<RockRepository, RockRepository, RockRepository>
    with $Provider<RockRepository> {
  /// Provider for RockRepository
  RockRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rockRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rockRepositoryHash();

  @$internal
  @override
  $ProviderElement<RockRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RockRepository create(Ref ref) {
    return rockRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RockRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RockRepository>(value),
    );
  }
}

String _$rockRepositoryHash() => r'8b21adb0e85250ff8c20dadd36f06bd36c6c996d';

/// Provider to watch all rocks for a tank

@ProviderFor(rocksForTankStream)
final rocksForTankStreamProvider = RocksForTankStreamFamily._();

/// Provider to watch all rocks for a tank

final class RocksForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RockEntity>>,
          List<RockEntity>,
          Stream<List<RockEntity>>
        >
    with $FutureModifier<List<RockEntity>>, $StreamProvider<List<RockEntity>> {
  /// Provider to watch all rocks for a tank
  RocksForTankStreamProvider._({
    required RocksForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'rocksForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rocksForTankStreamHash();

  @override
  String toString() {
    return r'rocksForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<RockEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RockEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return rocksForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RocksForTankStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rocksForTankStreamHash() =>
    r'd8ed7a60f79a08702a19dec2948c45d161f06610';

/// Provider to watch all rocks for a tank

final class RocksForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<RockEntity>>, int> {
  RocksForTankStreamFamily._()
    : super(
        retry: null,
        name: r'rocksForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all rocks for a tank

  RocksForTankStreamProvider call(int tankId) =>
      RocksForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'rocksForTankStreamProvider';
}

/// Provider to get a rock by ID

@ProviderFor(rockById)
final rockByIdProvider = RockByIdFamily._();

/// Provider to get a rock by ID

final class RockByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<RockEntity?>,
          RockEntity?,
          FutureOr<RockEntity?>
        >
    with $FutureModifier<RockEntity?>, $FutureProvider<RockEntity?> {
  /// Provider to get a rock by ID
  RockByIdProvider._({
    required RockByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'rockByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rockByIdHash();

  @override
  String toString() {
    return r'rockByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RockEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RockEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return rockById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RockByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rockByIdHash() => r'517523b7970d72930bb00c5606d4706ddb5838d2';

/// Provider to get a rock by ID

final class RockByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RockEntity?>, int> {
  RockByIdFamily._()
    : super(
        retry: null,
        name: r'rockByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a rock by ID

  RockByIdProvider call(int id) => RockByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'rockByIdProvider';
}

/// Notifier for managing rock operations for a specific tank

@ProviderFor(RockNotifier)
final rockProvider = RockNotifierFamily._();

/// Notifier for managing rock operations for a specific tank
final class RockNotifierProvider
    extends $AsyncNotifierProvider<RockNotifier, List<RockEntity>> {
  /// Notifier for managing rock operations for a specific tank
  RockNotifierProvider._({
    required RockNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'rockProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rockNotifierHash();

  @override
  String toString() {
    return r'rockProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RockNotifier create() => RockNotifier();

  @override
  bool operator ==(Object other) {
    return other is RockNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rockNotifierHash() => r'064ad831aa2d810f96e5d779cea7db838fac05de';

/// Notifier for managing rock operations for a specific tank

final class RockNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RockNotifier,
          AsyncValue<List<RockEntity>>,
          List<RockEntity>,
          FutureOr<List<RockEntity>>,
          int
        > {
  RockNotifierFamily._()
    : super(
        retry: null,
        name: r'rockProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing rock operations for a specific tank

  RockNotifierProvider call(int tankId) =>
      RockNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'rockProvider';
}

/// Notifier for managing rock operations for a specific tank

abstract class _$RockNotifier extends $AsyncNotifier<List<RockEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<RockEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<RockEntity>>, List<RockEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RockEntity>>, List<RockEntity>>,
              AsyncValue<List<RockEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
