// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for PlantRepository

@ProviderFor(plantRepository)
final plantRepositoryProvider = PlantRepositoryProvider._();

/// Provider for PlantRepository

final class PlantRepositoryProvider
    extends
        $FunctionalProvider<PlantRepository, PlantRepository, PlantRepository>
    with $Provider<PlantRepository> {
  /// Provider for PlantRepository
  PlantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plantRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plantRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlantRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlantRepository create(Ref ref) {
    return plantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlantRepository>(value),
    );
  }
}

String _$plantRepositoryHash() => r'1f157fea80007e8c13e0ac71aabbccd03cbf10f3';

/// Provider to watch all plants for a tank

@ProviderFor(plantsForTankStream)
final plantsForTankStreamProvider = PlantsForTankStreamFamily._();

/// Provider to watch all plants for a tank

final class PlantsForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PlantEntity>>,
          List<PlantEntity>,
          Stream<List<PlantEntity>>
        >
    with
        $FutureModifier<List<PlantEntity>>,
        $StreamProvider<List<PlantEntity>> {
  /// Provider to watch all plants for a tank
  PlantsForTankStreamProvider._({
    required PlantsForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'plantsForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$plantsForTankStreamHash();

  @override
  String toString() {
    return r'plantsForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<PlantEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<PlantEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return plantsForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlantsForTankStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$plantsForTankStreamHash() =>
    r'67066926570a3e48f60be5dd04780a1e21a15b90';

/// Provider to watch all plants for a tank

final class PlantsForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<PlantEntity>>, int> {
  PlantsForTankStreamFamily._()
    : super(
        retry: null,
        name: r'plantsForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all plants for a tank

  PlantsForTankStreamProvider call(int tankId) =>
      PlantsForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'plantsForTankStreamProvider';
}

/// Provider to get a plant by ID

@ProviderFor(plantById)
final plantByIdProvider = PlantByIdFamily._();

/// Provider to get a plant by ID

final class PlantByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlantEntity?>,
          PlantEntity?,
          FutureOr<PlantEntity?>
        >
    with $FutureModifier<PlantEntity?>, $FutureProvider<PlantEntity?> {
  /// Provider to get a plant by ID
  PlantByIdProvider._({
    required PlantByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'plantByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$plantByIdHash();

  @override
  String toString() {
    return r'plantByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PlantEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlantEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return plantById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlantByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$plantByIdHash() => r'97e4eae0d392166ccf0ff82fe798fde60613e114';

/// Provider to get a plant by ID

final class PlantByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PlantEntity?>, int> {
  PlantByIdFamily._()
    : super(
        retry: null,
        name: r'plantByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a plant by ID

  PlantByIdProvider call(int id) =>
      PlantByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'plantByIdProvider';
}

/// Provider to get active plant count for a tank

@ProviderFor(activePlantCount)
final activePlantCountProvider = ActivePlantCountFamily._();

/// Provider to get active plant count for a tank

final class ActivePlantCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provider to get active plant count for a tank
  ActivePlantCountProvider._({
    required ActivePlantCountFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'activePlantCountProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activePlantCountHash();

  @override
  String toString() {
    return r'activePlantCountProvider'
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
    return activePlantCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivePlantCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activePlantCountHash() => r'259636ac0f37b564fe26a282abac8af2d45c11b9';

/// Provider to get active plant count for a tank

final class ActivePlantCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, int> {
  ActivePlantCountFamily._()
    : super(
        retry: null,
        name: r'activePlantCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get active plant count for a tank

  ActivePlantCountProvider call(int tankId) =>
      ActivePlantCountProvider._(argument: tankId, from: this);

  @override
  String toString() => r'activePlantCountProvider';
}

/// Notifier for managing plant operations for a specific tank

@ProviderFor(PlantNotifier)
final plantProvider = PlantNotifierFamily._();

/// Notifier for managing plant operations for a specific tank
final class PlantNotifierProvider
    extends $AsyncNotifierProvider<PlantNotifier, List<PlantEntity>> {
  /// Notifier for managing plant operations for a specific tank
  PlantNotifierProvider._({
    required PlantNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'plantProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$plantNotifierHash();

  @override
  String toString() {
    return r'plantProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PlantNotifier create() => PlantNotifier();

  @override
  bool operator ==(Object other) {
    return other is PlantNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$plantNotifierHash() => r'8d39f63042892a434086bf13be1e7de6f314d324';

/// Notifier for managing plant operations for a specific tank

final class PlantNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PlantNotifier,
          AsyncValue<List<PlantEntity>>,
          List<PlantEntity>,
          FutureOr<List<PlantEntity>>,
          int
        > {
  PlantNotifierFamily._()
    : super(
        retry: null,
        name: r'plantProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing plant operations for a specific tank

  PlantNotifierProvider call(int tankId) =>
      PlantNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'plantProvider';
}

/// Notifier for managing plant operations for a specific tank

abstract class _$PlantNotifier extends $AsyncNotifier<List<PlantEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<PlantEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PlantEntity>>, List<PlantEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PlantEntity>>, List<PlantEntity>>,
              AsyncValue<List<PlantEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
