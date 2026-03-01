// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lighting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for LightingRepository

@ProviderFor(lightingRepository)
final lightingRepositoryProvider = LightingRepositoryProvider._();

/// Provider for LightingRepository

final class LightingRepositoryProvider
    extends
        $FunctionalProvider<
          LightingRepository,
          LightingRepository,
          LightingRepository
        >
    with $Provider<LightingRepository> {
  /// Provider for LightingRepository
  LightingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightingRepositoryHash();

  @$internal
  @override
  $ProviderElement<LightingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LightingRepository create(Ref ref) {
    return lightingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LightingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LightingRepository>(value),
    );
  }
}

String _$lightingRepositoryHash() =>
    r'028a1f01e2f7e3f02eb5ea811d304c08068c3401';

/// Provider to watch all lightings for a tank

@ProviderFor(lightingsForTankStream)
final lightingsForTankStreamProvider = LightingsForTankStreamFamily._();

/// Provider to watch all lightings for a tank

final class LightingsForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LightingEntity>>,
          List<LightingEntity>,
          Stream<List<LightingEntity>>
        >
    with
        $FutureModifier<List<LightingEntity>>,
        $StreamProvider<List<LightingEntity>> {
  /// Provider to watch all lightings for a tank
  LightingsForTankStreamProvider._({
    required LightingsForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'lightingsForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lightingsForTankStreamHash();

  @override
  String toString() {
    return r'lightingsForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<LightingEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LightingEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return lightingsForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LightingsForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lightingsForTankStreamHash() =>
    r'b284eef5f85ee349bd2356a464797107e60e80eb';

/// Provider to watch all lightings for a tank

final class LightingsForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<LightingEntity>>, int> {
  LightingsForTankStreamFamily._()
    : super(
        retry: null,
        name: r'lightingsForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all lightings for a tank

  LightingsForTankStreamProvider call(int tankId) =>
      LightingsForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'lightingsForTankStreamProvider';
}

/// Provider to get a lighting by ID

@ProviderFor(lightingById)
final lightingByIdProvider = LightingByIdFamily._();

/// Provider to get a lighting by ID

final class LightingByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<LightingEntity?>,
          LightingEntity?,
          FutureOr<LightingEntity?>
        >
    with $FutureModifier<LightingEntity?>, $FutureProvider<LightingEntity?> {
  /// Provider to get a lighting by ID
  LightingByIdProvider._({
    required LightingByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'lightingByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lightingByIdHash();

  @override
  String toString() {
    return r'lightingByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LightingEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LightingEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return lightingById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LightingByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lightingByIdHash() => r'9756e80d928230b67efb7fb25fe13ea6e3146ca2';

/// Provider to get a lighting by ID

final class LightingByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LightingEntity?>, int> {
  LightingByIdFamily._()
    : super(
        retry: null,
        name: r'lightingByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a lighting by ID

  LightingByIdProvider call(int id) =>
      LightingByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'lightingByIdProvider';
}

/// Notifier for managing lighting operations for a specific tank

@ProviderFor(LightingNotifier)
final lightingProvider = LightingNotifierFamily._();

/// Notifier for managing lighting operations for a specific tank
final class LightingNotifierProvider
    extends $AsyncNotifierProvider<LightingNotifier, List<LightingEntity>> {
  /// Notifier for managing lighting operations for a specific tank
  LightingNotifierProvider._({
    required LightingNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'lightingProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lightingNotifierHash();

  @override
  String toString() {
    return r'lightingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LightingNotifier create() => LightingNotifier();

  @override
  bool operator ==(Object other) {
    return other is LightingNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lightingNotifierHash() => r'82e23f3a959c7260b95cc0dc5231b99ad4d80f2a';

/// Notifier for managing lighting operations for a specific tank

final class LightingNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          LightingNotifier,
          AsyncValue<List<LightingEntity>>,
          List<LightingEntity>,
          FutureOr<List<LightingEntity>>,
          int
        > {
  LightingNotifierFamily._()
    : super(
        retry: null,
        name: r'lightingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing lighting operations for a specific tank

  LightingNotifierProvider call(int tankId) =>
      LightingNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'lightingProvider';
}

/// Notifier for managing lighting operations for a specific tank

abstract class _$LightingNotifier extends $AsyncNotifier<List<LightingEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<LightingEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<LightingEntity>>, List<LightingEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<LightingEntity>>,
                List<LightingEntity>
              >,
              AsyncValue<List<LightingEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
