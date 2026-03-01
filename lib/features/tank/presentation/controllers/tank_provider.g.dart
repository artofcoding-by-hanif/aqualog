// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for TankRepository

@ProviderFor(tankRepository)
final tankRepositoryProvider = TankRepositoryProvider._();

/// Provider for TankRepository

final class TankRepositoryProvider
    extends $FunctionalProvider<TankRepository, TankRepository, TankRepository>
    with $Provider<TankRepository> {
  /// Provider for TankRepository
  TankRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tankRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tankRepositoryHash();

  @$internal
  @override
  $ProviderElement<TankRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TankRepository create(Ref ref) {
    return tankRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TankRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TankRepository>(value),
    );
  }
}

String _$tankRepositoryHash() => r'4cb1f8e6261f36013f1a4b06aed82d3628beb96e';

/// Provider to watch all tanks as TankEntity

@ProviderFor(tanksStream)
final tanksStreamProvider = TanksStreamProvider._();

/// Provider to watch all tanks as TankEntity

final class TanksStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TankEntity>>,
          List<TankEntity>,
          Stream<List<TankEntity>>
        >
    with $FutureModifier<List<TankEntity>>, $StreamProvider<List<TankEntity>> {
  /// Provider to watch all tanks as TankEntity
  TanksStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tanksStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tanksStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<TankEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TankEntity>> create(Ref ref) {
    return tanksStream(ref);
  }
}

String _$tanksStreamHash() => r'958fd45838bf10ed30036f540ab62c174e52637a';

/// Provider to watch the active tank as TankEntity

@ProviderFor(activeTankStream)
final activeTankStreamProvider = ActiveTankStreamProvider._();

/// Provider to watch the active tank as TankEntity

final class ActiveTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<TankEntity?>,
          TankEntity?,
          Stream<TankEntity?>
        >
    with $FutureModifier<TankEntity?>, $StreamProvider<TankEntity?> {
  /// Provider to watch the active tank as TankEntity
  ActiveTankStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeTankStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeTankStreamHash();

  @$internal
  @override
  $StreamProviderElement<TankEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<TankEntity?> create(Ref ref) {
    return activeTankStream(ref);
  }
}

String _$activeTankStreamHash() => r'7a6dc0c5fe1aa43fcd29a45e22562aabd586f914';

/// Provider to get a tank by ID

@ProviderFor(tankById)
final tankByIdProvider = TankByIdFamily._();

/// Provider to get a tank by ID

final class TankByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<TankEntity?>,
          TankEntity?,
          FutureOr<TankEntity?>
        >
    with $FutureModifier<TankEntity?>, $FutureProvider<TankEntity?> {
  /// Provider to get a tank by ID
  TankByIdProvider._({
    required TankByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tankByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tankByIdHash();

  @override
  String toString() {
    return r'tankByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TankEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TankEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return tankById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TankByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tankByIdHash() => r'5cc04106c1ebeda53205c945c862f31c33b97f43';

/// Provider to get a tank by ID

final class TankByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TankEntity?>, int> {
  TankByIdFamily._()
    : super(
        retry: null,
        name: r'tankByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to get a tank by ID

  TankByIdProvider call(int id) => TankByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'tankByIdProvider';
}

/// Notifier for managing tank operations

@ProviderFor(TankNotifier)
final tankProvider = TankNotifierProvider._();

/// Notifier for managing tank operations
final class TankNotifierProvider
    extends $AsyncNotifierProvider<TankNotifier, List<TankEntity>> {
  /// Notifier for managing tank operations
  TankNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tankProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tankNotifierHash();

  @$internal
  @override
  TankNotifier create() => TankNotifier();
}

String _$tankNotifierHash() => r'52bc158f7f59af4d3ddfeb1b56636c54b3a442d7';

/// Notifier for managing tank operations

abstract class _$TankNotifier extends $AsyncNotifier<List<TankEntity>> {
  FutureOr<List<TankEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TankEntity>>, List<TankEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TankEntity>>, List<TankEntity>>,
              AsyncValue<List<TankEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
