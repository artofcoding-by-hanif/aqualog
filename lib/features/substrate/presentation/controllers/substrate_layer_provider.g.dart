// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substrate_layer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for SubstrateLayerRepository

@ProviderFor(substrateLayerRepository)
final substrateLayerRepositoryProvider = SubstrateLayerRepositoryProvider._();

/// Provider for SubstrateLayerRepository

final class SubstrateLayerRepositoryProvider
    extends
        $FunctionalProvider<
          SubstrateLayerRepository,
          SubstrateLayerRepository,
          SubstrateLayerRepository
        >
    with $Provider<SubstrateLayerRepository> {
  /// Provider for SubstrateLayerRepository
  SubstrateLayerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'substrateLayerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$substrateLayerRepositoryHash();

  @$internal
  @override
  $ProviderElement<SubstrateLayerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubstrateLayerRepository create(Ref ref) {
    return substrateLayerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubstrateLayerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubstrateLayerRepository>(value),
    );
  }
}

String _$substrateLayerRepositoryHash() =>
    r'df9f099546b93b943d336003646512d125c68759';

/// Provider to watch all substrate layers for a tank

@ProviderFor(substrateLayersForTankStream)
final substrateLayersForTankStreamProvider =
    SubstrateLayersForTankStreamFamily._();

/// Provider to watch all substrate layers for a tank

final class SubstrateLayersForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SubstrateLayerEntity>>,
          List<SubstrateLayerEntity>,
          Stream<List<SubstrateLayerEntity>>
        >
    with
        $FutureModifier<List<SubstrateLayerEntity>>,
        $StreamProvider<List<SubstrateLayerEntity>> {
  /// Provider to watch all substrate layers for a tank
  SubstrateLayersForTankStreamProvider._({
    required SubstrateLayersForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'substrateLayersForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$substrateLayersForTankStreamHash();

  @override
  String toString() {
    return r'substrateLayersForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<SubstrateLayerEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SubstrateLayerEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return substrateLayersForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SubstrateLayersForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$substrateLayersForTankStreamHash() =>
    r'78e85ad6abf1c2e7bc129b896f604a9e8bb6f196';

/// Provider to watch all substrate layers for a tank

final class SubstrateLayersForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<SubstrateLayerEntity>>, int> {
  SubstrateLayersForTankStreamFamily._()
    : super(
        retry: null,
        name: r'substrateLayersForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all substrate layers for a tank

  SubstrateLayersForTankStreamProvider call(int tankId) =>
      SubstrateLayersForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'substrateLayersForTankStreamProvider';
}

/// Provider to get a substrate layer by ID

@ProviderFor(substrateLayerById)
final substrateLayerByIdProvider = SubstrateLayerByIdFamily._();

/// Provider to get a substrate layer by ID

final class SubstrateLayerByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<SubstrateLayerEntity?>,
          SubstrateLayerEntity?,
          FutureOr<SubstrateLayerEntity?>
        >
    with
        $FutureModifier<SubstrateLayerEntity?>,
        $FutureProvider<SubstrateLayerEntity?> {
  /// Provider to get a substrate layer by ID
  SubstrateLayerByIdProvider._({
    required SubstrateLayerByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'substrateLayerByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$substrateLayerByIdHash();

  @override
  String toString() {
    return r'substrateLayerByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SubstrateLayerEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SubstrateLayerEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return substrateLayerById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SubstrateLayerByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$substrateLayerByIdHash() =>
    r'cdc7aec82e4024bf337b92eb93cdeb24e6fa85d3';

/// Provider to get a substrate layer by ID

final class SubstrateLayerByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SubstrateLayerEntity?>, int> {
  SubstrateLayerByIdFamily._()
    : super(
        retry: null,
        name: r'substrateLayerByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a substrate layer by ID

  SubstrateLayerByIdProvider call(int id) =>
      SubstrateLayerByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'substrateLayerByIdProvider';
}

/// Notifier for substrate layer operations

@ProviderFor(SubstrateLayerNotifier)
final substrateLayerProvider = SubstrateLayerNotifierProvider._();

/// Notifier for substrate layer operations
final class SubstrateLayerNotifierProvider
    extends $NotifierProvider<SubstrateLayerNotifier, void> {
  /// Notifier for substrate layer operations
  SubstrateLayerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'substrateLayerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$substrateLayerNotifierHash();

  @$internal
  @override
  SubstrateLayerNotifier create() => SubstrateLayerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$substrateLayerNotifierHash() =>
    r'9742ecaae5d50fabcec43cef6ef7c08d8bb8b2eb';

/// Notifier for substrate layer operations

abstract class _$SubstrateLayerNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
