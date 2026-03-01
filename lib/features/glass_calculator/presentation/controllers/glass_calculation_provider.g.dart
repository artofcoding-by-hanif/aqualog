// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glass_calculation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for GlassCalculationRepository

@ProviderFor(glassCalculationRepository)
final glassCalculationRepositoryProvider =
    GlassCalculationRepositoryProvider._();

/// Provider for GlassCalculationRepository

final class GlassCalculationRepositoryProvider
    extends
        $FunctionalProvider<
          GlassCalculationRepository,
          GlassCalculationRepository,
          GlassCalculationRepository
        >
    with $Provider<GlassCalculationRepository> {
  /// Provider for GlassCalculationRepository
  GlassCalculationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'glassCalculationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$glassCalculationRepositoryHash();

  @$internal
  @override
  $ProviderElement<GlassCalculationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GlassCalculationRepository create(Ref ref) {
    return glassCalculationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlassCalculationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlassCalculationRepository>(value),
    );
  }
}

String _$glassCalculationRepositoryHash() =>
    r'7a00ef8fd37c85f1751ec0ca32d6c1c4a48d8fa7';

/// Provider to watch all saved calculations

@ProviderFor(glassCalculationsStream)
final glassCalculationsStreamProvider = GlassCalculationsStreamProvider._();

/// Provider to watch all saved calculations

final class GlassCalculationsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GlassCalculationEntity>>,
          List<GlassCalculationEntity>,
          Stream<List<GlassCalculationEntity>>
        >
    with
        $FutureModifier<List<GlassCalculationEntity>>,
        $StreamProvider<List<GlassCalculationEntity>> {
  /// Provider to watch all saved calculations
  GlassCalculationsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'glassCalculationsStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$glassCalculationsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<GlassCalculationEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<GlassCalculationEntity>> create(Ref ref) {
    return glassCalculationsStream(ref);
  }
}

String _$glassCalculationsStreamHash() =>
    r'da18c9a0edb99678c34162c9d9e687492c271e64';

/// Provider to get a calculation by ID

@ProviderFor(glassCalculationById)
final glassCalculationByIdProvider = GlassCalculationByIdFamily._();

/// Provider to get a calculation by ID

final class GlassCalculationByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<GlassCalculationEntity?>,
          GlassCalculationEntity?,
          FutureOr<GlassCalculationEntity?>
        >
    with
        $FutureModifier<GlassCalculationEntity?>,
        $FutureProvider<GlassCalculationEntity?> {
  /// Provider to get a calculation by ID
  GlassCalculationByIdProvider._({
    required GlassCalculationByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'glassCalculationByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$glassCalculationByIdHash();

  @override
  String toString() {
    return r'glassCalculationByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<GlassCalculationEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GlassCalculationEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return glassCalculationById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GlassCalculationByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$glassCalculationByIdHash() =>
    r'0047c4c30a36e2db6a66c02eb8097b97d1e9b8b6';

/// Provider to get a calculation by ID

final class GlassCalculationByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<GlassCalculationEntity?>, int> {
  GlassCalculationByIdFamily._()
    : super(
        retry: null,
        name: r'glassCalculationByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to get a calculation by ID

  GlassCalculationByIdProvider call(int id) =>
      GlassCalculationByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'glassCalculationByIdProvider';
}
