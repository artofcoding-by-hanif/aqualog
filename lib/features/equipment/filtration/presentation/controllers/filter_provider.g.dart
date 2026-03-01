// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for FilterRepository

@ProviderFor(filterRepository)
final filterRepositoryProvider = FilterRepositoryProvider._();

/// Provider for FilterRepository

final class FilterRepositoryProvider
    extends
        $FunctionalProvider<
          FilterRepository,
          FilterRepository,
          FilterRepository
        >
    with $Provider<FilterRepository> {
  /// Provider for FilterRepository
  FilterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterRepositoryHash();

  @$internal
  @override
  $ProviderElement<FilterRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FilterRepository create(Ref ref) {
    return filterRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilterRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FilterRepository>(value),
    );
  }
}

String _$filterRepositoryHash() => r'0cc7d2292fc62af692d484ef0936fad9cfa90a6c';

/// Provider to watch all filters for a tank

@ProviderFor(filtersForTankStream)
final filtersForTankStreamProvider = FiltersForTankStreamFamily._();

/// Provider to watch all filters for a tank

final class FiltersForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FilterEntity>>,
          List<FilterEntity>,
          Stream<List<FilterEntity>>
        >
    with
        $FutureModifier<List<FilterEntity>>,
        $StreamProvider<List<FilterEntity>> {
  /// Provider to watch all filters for a tank
  FiltersForTankStreamProvider._({
    required FiltersForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'filtersForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filtersForTankStreamHash();

  @override
  String toString() {
    return r'filtersForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<FilterEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FilterEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return filtersForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FiltersForTankStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filtersForTankStreamHash() =>
    r'd27bd7e9649f471f3acb27535f72b6928b282e09';

/// Provider to watch all filters for a tank

final class FiltersForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<FilterEntity>>, int> {
  FiltersForTankStreamFamily._()
    : super(
        retry: null,
        name: r'filtersForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all filters for a tank

  FiltersForTankStreamProvider call(int tankId) =>
      FiltersForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'filtersForTankStreamProvider';
}

/// Provider to get a filter by ID

@ProviderFor(filterById)
final filterByIdProvider = FilterByIdFamily._();

/// Provider to get a filter by ID

final class FilterByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<FilterEntity?>,
          FilterEntity?,
          FutureOr<FilterEntity?>
        >
    with $FutureModifier<FilterEntity?>, $FutureProvider<FilterEntity?> {
  /// Provider to get a filter by ID
  FilterByIdProvider._({
    required FilterByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'filterByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filterByIdHash();

  @override
  String toString() {
    return r'filterByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FilterEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FilterEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return filterById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FilterByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filterByIdHash() => r'b888873669b5a84a4ed9c4ab14dd890e45e42e73';

/// Provider to get a filter by ID

final class FilterByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FilterEntity?>, int> {
  FilterByIdFamily._()
    : super(
        retry: null,
        name: r'filterByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get a filter by ID

  FilterByIdProvider call(int id) =>
      FilterByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'filterByIdProvider';
}

/// Notifier for managing filter operations for a specific tank

@ProviderFor(FilterNotifier)
final filterProvider = FilterNotifierFamily._();

/// Notifier for managing filter operations for a specific tank
final class FilterNotifierProvider
    extends $AsyncNotifierProvider<FilterNotifier, List<FilterEntity>> {
  /// Notifier for managing filter operations for a specific tank
  FilterNotifierProvider._({
    required FilterNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'filterProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filterNotifierHash();

  @override
  String toString() {
    return r'filterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FilterNotifier create() => FilterNotifier();

  @override
  bool operator ==(Object other) {
    return other is FilterNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filterNotifierHash() => r'cff4f363c3b60b5e9c1f903b0ca2098173408a92';

/// Notifier for managing filter operations for a specific tank

final class FilterNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FilterNotifier,
          AsyncValue<List<FilterEntity>>,
          List<FilterEntity>,
          FutureOr<List<FilterEntity>>,
          int
        > {
  FilterNotifierFamily._()
    : super(
        retry: null,
        name: r'filterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing filter operations for a specific tank

  FilterNotifierProvider call(int tankId) =>
      FilterNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'filterProvider';
}

/// Notifier for managing filter operations for a specific tank

abstract class _$FilterNotifier extends $AsyncNotifier<List<FilterEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<FilterEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FilterEntity>>, List<FilterEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FilterEntity>>, List<FilterEntity>>,
              AsyncValue<List<FilterEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
