// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for FishRepository

@ProviderFor(fishRepository)
final fishRepositoryProvider = FishRepositoryProvider._();

/// Provider for FishRepository

final class FishRepositoryProvider
    extends $FunctionalProvider<FishRepository, FishRepository, FishRepository>
    with $Provider<FishRepository> {
  /// Provider for FishRepository
  FishRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fishRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fishRepositoryHash();

  @$internal
  @override
  $ProviderElement<FishRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FishRepository create(Ref ref) {
    return fishRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FishRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FishRepository>(value),
    );
  }
}

String _$fishRepositoryHash() => r'686e2f84f565c405cc608a51117883afa0a531c3';

/// Provider to watch all fish for a tank

@ProviderFor(fishForTankStream)
final fishForTankStreamProvider = FishForTankStreamFamily._();

/// Provider to watch all fish for a tank

final class FishForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FishEntity>>,
          List<FishEntity>,
          Stream<List<FishEntity>>
        >
    with $FutureModifier<List<FishEntity>>, $StreamProvider<List<FishEntity>> {
  /// Provider to watch all fish for a tank
  FishForTankStreamProvider._({
    required FishForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fishForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fishForTankStreamHash();

  @override
  String toString() {
    return r'fishForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<FishEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FishEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return fishForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FishForTankStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fishForTankStreamHash() => r'9b98d9af1efa86a2b91953c0ada323f31f0a52d0';

/// Provider to watch all fish for a tank

final class FishForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<FishEntity>>, int> {
  FishForTankStreamFamily._()
    : super(
        retry: null,
        name: r'fishForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all fish for a tank

  FishForTankStreamProvider call(int tankId) =>
      FishForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'fishForTankStreamProvider';
}

/// Provider to get a fish by ID

@ProviderFor(fishById)
final fishByIdProvider = FishByIdFamily._();

/// Provider to get a fish by ID

final class FishByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<FishEntity?>,
          FishEntity?,
          FutureOr<FishEntity?>
        >
    with $FutureModifier<FishEntity?>, $FutureProvider<FishEntity?> {
  /// Provider to get a fish by ID
  FishByIdProvider._({
    required FishByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fishByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fishByIdHash();

  @override
  String toString() {
    return r'fishByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FishEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FishEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return fishById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FishByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fishByIdHash() => r'fc6a3feebd2ed593f0fdf76d96bd962dbb7d749d';

/// Provider to get a fish by ID

final class FishByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FishEntity?>, int> {
  FishByIdFamily._()
    : super(
        retry: null,
        name: r'fishByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a fish by ID

  FishByIdProvider call(int id) => FishByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'fishByIdProvider';
}

/// Provider to get alive fish count for a tank

@ProviderFor(aliveFishCount)
final aliveFishCountProvider = AliveFishCountFamily._();

/// Provider to get alive fish count for a tank

final class AliveFishCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provider to get alive fish count for a tank
  AliveFishCountProvider._({
    required AliveFishCountFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'aliveFishCountProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aliveFishCountHash();

  @override
  String toString() {
    return r'aliveFishCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as int;
    return aliveFishCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AliveFishCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aliveFishCountHash() => r'c5e146d1be06d6e7fa96effb09e7ae0a3f9c1c24';

/// Provider to get alive fish count for a tank

final class AliveFishCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, int> {
  AliveFishCountFamily._()
    : super(
        retry: null,
        name: r'aliveFishCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get alive fish count for a tank

  AliveFishCountProvider call(int tankId) =>
      AliveFishCountProvider._(argument: tankId, from: this);

  @override
  String toString() => r'aliveFishCountProvider';
}

/// Notifier for managing fish operations for a specific tank

@ProviderFor(FishNotifier)
final fishProvider = FishNotifierFamily._();

/// Notifier for managing fish operations for a specific tank
final class FishNotifierProvider
    extends $AsyncNotifierProvider<FishNotifier, List<FishEntity>> {
  /// Notifier for managing fish operations for a specific tank
  FishNotifierProvider._({
    required FishNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fishProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fishNotifierHash();

  @override
  String toString() {
    return r'fishProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FishNotifier create() => FishNotifier();

  @override
  bool operator ==(Object other) {
    return other is FishNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fishNotifierHash() => r'fe0d8a72fe3b521524fc1f39c4e7346e959fb1f0';

/// Notifier for managing fish operations for a specific tank

final class FishNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FishNotifier,
          AsyncValue<List<FishEntity>>,
          List<FishEntity>,
          FutureOr<List<FishEntity>>,
          int
        > {
  FishNotifierFamily._()
    : super(
        retry: null,
        name: r'fishProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing fish operations for a specific tank

  FishNotifierProvider call(int tankId) =>
      FishNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'fishProvider';
}

/// Notifier for managing fish operations for a specific tank

abstract class _$FishNotifier extends $AsyncNotifier<List<FishEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<FishEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FishEntity>>, List<FishEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FishEntity>>, List<FishEntity>>,
              AsyncValue<List<FishEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
