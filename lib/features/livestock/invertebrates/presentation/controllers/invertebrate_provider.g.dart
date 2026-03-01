// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invertebrate_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for InvertebrateRepository

@ProviderFor(invertebrateRepository)
final invertebrateRepositoryProvider = InvertebrateRepositoryProvider._();

/// Provider for InvertebrateRepository

final class InvertebrateRepositoryProvider
    extends
        $FunctionalProvider<
          InvertebrateRepository,
          InvertebrateRepository,
          InvertebrateRepository
        >
    with $Provider<InvertebrateRepository> {
  /// Provider for InvertebrateRepository
  InvertebrateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invertebrateRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invertebrateRepositoryHash();

  @$internal
  @override
  $ProviderElement<InvertebrateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InvertebrateRepository create(Ref ref) {
    return invertebrateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InvertebrateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InvertebrateRepository>(value),
    );
  }
}

String _$invertebrateRepositoryHash() =>
    r'f55ab6ca6861c59724758fafe746d4964b592421';

/// Provider to watch all invertebrates for a tank

@ProviderFor(invertebratesForTankStream)
final invertebratesForTankStreamProvider = InvertebratesForTankStreamFamily._();

/// Provider to watch all invertebrates for a tank

final class InvertebratesForTankStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InvertebrateEntity>>,
          List<InvertebrateEntity>,
          Stream<List<InvertebrateEntity>>
        >
    with
        $FutureModifier<List<InvertebrateEntity>>,
        $StreamProvider<List<InvertebrateEntity>> {
  /// Provider to watch all invertebrates for a tank
  InvertebratesForTankStreamProvider._({
    required InvertebratesForTankStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'invertebratesForTankStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$invertebratesForTankStreamHash();

  @override
  String toString() {
    return r'invertebratesForTankStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<InvertebrateEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<InvertebrateEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return invertebratesForTankStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InvertebratesForTankStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$invertebratesForTankStreamHash() =>
    r'1875931c0adc3a49c99ab7038c02bae10557a44a';

/// Provider to watch all invertebrates for a tank

final class InvertebratesForTankStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<InvertebrateEntity>>, int> {
  InvertebratesForTankStreamFamily._()
    : super(
        retry: null,
        name: r'invertebratesForTankStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all invertebrates for a tank

  InvertebratesForTankStreamProvider call(int tankId) =>
      InvertebratesForTankStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'invertebratesForTankStreamProvider';
}

/// Provider to get an invertebrate by ID

@ProviderFor(invertebrateById)
final invertebrateByIdProvider = InvertebrateByIdFamily._();

/// Provider to get an invertebrate by ID

final class InvertebrateByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<InvertebrateEntity?>,
          InvertebrateEntity?,
          FutureOr<InvertebrateEntity?>
        >
    with
        $FutureModifier<InvertebrateEntity?>,
        $FutureProvider<InvertebrateEntity?> {
  /// Provider to get an invertebrate by ID
  InvertebrateByIdProvider._({
    required InvertebrateByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'invertebrateByIdProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$invertebrateByIdHash();

  @override
  String toString() {
    return r'invertebrateByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<InvertebrateEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<InvertebrateEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return invertebrateById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InvertebrateByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$invertebrateByIdHash() => r'25e3f103d8da9ac06971d71c30e76eef77fbe5a8';

/// Provider to get an invertebrate by ID

final class InvertebrateByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<InvertebrateEntity?>, int> {
  InvertebrateByIdFamily._()
    : super(
        retry: null,
        name: r'invertebrateByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get an invertebrate by ID

  InvertebrateByIdProvider call(int id) =>
      InvertebrateByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'invertebrateByIdProvider';
}

/// Provider to get alive invertebrate count for a tank

@ProviderFor(aliveInvertebrateCount)
final aliveInvertebrateCountProvider = AliveInvertebrateCountFamily._();

/// Provider to get alive invertebrate count for a tank

final class AliveInvertebrateCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provider to get alive invertebrate count for a tank
  AliveInvertebrateCountProvider._({
    required AliveInvertebrateCountFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'aliveInvertebrateCountProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aliveInvertebrateCountHash();

  @override
  String toString() {
    return r'aliveInvertebrateCountProvider'
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
    return aliveInvertebrateCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AliveInvertebrateCountProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aliveInvertebrateCountHash() =>
    r'6113689587e04ed069e72907b778dda854b6bea1';

/// Provider to get alive invertebrate count for a tank

final class AliveInvertebrateCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, int> {
  AliveInvertebrateCountFamily._()
    : super(
        retry: null,
        name: r'aliveInvertebrateCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to get alive invertebrate count for a tank

  AliveInvertebrateCountProvider call(int tankId) =>
      AliveInvertebrateCountProvider._(argument: tankId, from: this);

  @override
  String toString() => r'aliveInvertebrateCountProvider';
}

/// Notifier for managing invertebrate operations for a specific tank

@ProviderFor(InvertebrateNotifier)
final invertebrateProvider = InvertebrateNotifierFamily._();

/// Notifier for managing invertebrate operations for a specific tank
final class InvertebrateNotifierProvider
    extends
        $AsyncNotifierProvider<InvertebrateNotifier, List<InvertebrateEntity>> {
  /// Notifier for managing invertebrate operations for a specific tank
  InvertebrateNotifierProvider._({
    required InvertebrateNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'invertebrateProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$invertebrateNotifierHash();

  @override
  String toString() {
    return r'invertebrateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InvertebrateNotifier create() => InvertebrateNotifier();

  @override
  bool operator ==(Object other) {
    return other is InvertebrateNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$invertebrateNotifierHash() =>
    r'feab573a6be1e55c39b7ecdf60613be65904a0e9';

/// Notifier for managing invertebrate operations for a specific tank

final class InvertebrateNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          InvertebrateNotifier,
          AsyncValue<List<InvertebrateEntity>>,
          List<InvertebrateEntity>,
          FutureOr<List<InvertebrateEntity>>,
          int
        > {
  InvertebrateNotifierFamily._()
    : super(
        retry: null,
        name: r'invertebrateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for managing invertebrate operations for a specific tank

  InvertebrateNotifierProvider call(int tankId) =>
      InvertebrateNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'invertebrateProvider';
}

/// Notifier for managing invertebrate operations for a specific tank

abstract class _$InvertebrateNotifier
    extends $AsyncNotifier<List<InvertebrateEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<InvertebrateEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<InvertebrateEntity>>,
              List<InvertebrateEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<InvertebrateEntity>>,
                List<InvertebrateEntity>
              >,
              AsyncValue<List<InvertebrateEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
