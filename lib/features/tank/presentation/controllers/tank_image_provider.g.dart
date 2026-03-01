// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank_image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for TankImageRepository

@ProviderFor(tankImageRepository)
final tankImageRepositoryProvider = TankImageRepositoryProvider._();

/// Provider for TankImageRepository

final class TankImageRepositoryProvider
    extends
        $FunctionalProvider<
          TankImageRepository,
          TankImageRepository,
          TankImageRepository
        >
    with $Provider<TankImageRepository> {
  /// Provider for TankImageRepository
  TankImageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tankImageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tankImageRepositoryHash();

  @$internal
  @override
  $ProviderElement<TankImageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TankImageRepository create(Ref ref) {
    return tankImageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TankImageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TankImageRepository>(value),
    );
  }
}

String _$tankImageRepositoryHash() =>
    r'0beb160f27d571972f44445b113754a561c94078';

/// Provider to watch all images for a tank

@ProviderFor(tankImagesStream)
final tankImagesStreamProvider = TankImagesStreamFamily._();

/// Provider to watch all images for a tank

final class TankImagesStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TankImageEntity>>,
          List<TankImageEntity>,
          Stream<List<TankImageEntity>>
        >
    with
        $FutureModifier<List<TankImageEntity>>,
        $StreamProvider<List<TankImageEntity>> {
  /// Provider to watch all images for a tank
  TankImagesStreamProvider._({
    required TankImagesStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tankImagesStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tankImagesStreamHash();

  @override
  String toString() {
    return r'tankImagesStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TankImageEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TankImageEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return tankImagesStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TankImagesStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tankImagesStreamHash() => r'bc65c902b3d8178aea892edbc94ec5dd3b33e03f';

/// Provider to watch all images for a tank

final class TankImagesStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TankImageEntity>>, int> {
  TankImagesStreamFamily._()
    : super(
        retry: null,
        name: r'tankImagesStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Provider to watch all images for a tank

  TankImagesStreamProvider call(int tankId) =>
      TankImagesStreamProvider._(argument: tankId, from: this);

  @override
  String toString() => r'tankImagesStreamProvider';
}

/// Provider to get the cover image for a tank

@ProviderFor(tankCoverImage)
final tankCoverImageProvider = TankCoverImageFamily._();

/// Provider to get the cover image for a tank

final class TankCoverImageProvider
    extends
        $FunctionalProvider<
          AsyncValue<TankImageEntity?>,
          TankImageEntity?,
          FutureOr<TankImageEntity?>
        >
    with $FutureModifier<TankImageEntity?>, $FutureProvider<TankImageEntity?> {
  /// Provider to get the cover image for a tank
  TankCoverImageProvider._({
    required TankCoverImageFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tankCoverImageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tankCoverImageHash();

  @override
  String toString() {
    return r'tankCoverImageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TankImageEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TankImageEntity?> create(Ref ref) {
    final argument = this.argument as int;
    return tankCoverImage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TankCoverImageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tankCoverImageHash() => r'd228d8791f352dd2bbc51fae4640ecf919428dd9';

/// Provider to get the cover image for a tank

final class TankCoverImageFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TankImageEntity?>, int> {
  TankCoverImageFamily._()
    : super(
        retry: null,
        name: r'tankCoverImageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to get the cover image for a tank

  TankCoverImageProvider call(int tankId) =>
      TankCoverImageProvider._(argument: tankId, from: this);

  @override
  String toString() => r'tankCoverImageProvider';
}

/// Provider to get image count for a tank

@ProviderFor(tankImageCount)
final tankImageCountProvider = TankImageCountFamily._();

/// Provider to get image count for a tank

final class TankImageCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provider to get image count for a tank
  TankImageCountProvider._({
    required TankImageCountFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tankImageCountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tankImageCountHash();

  @override
  String toString() {
    return r'tankImageCountProvider'
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
    return tankImageCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TankImageCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tankImageCountHash() => r'daa107dc8ac4f7d6bded4f6a1542339118d2fe5b';

/// Provider to get image count for a tank

final class TankImageCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, int> {
  TankImageCountFamily._()
    : super(
        retry: null,
        name: r'tankImageCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to get image count for a tank

  TankImageCountProvider call(int tankId) =>
      TankImageCountProvider._(argument: tankId, from: this);

  @override
  String toString() => r'tankImageCountProvider';
}

/// Notifier for managing tank image operations

@ProviderFor(TankImageNotifier)
final tankImageProvider = TankImageNotifierFamily._();

/// Notifier for managing tank image operations
final class TankImageNotifierProvider
    extends $AsyncNotifierProvider<TankImageNotifier, List<TankImageEntity>> {
  /// Notifier for managing tank image operations
  TankImageNotifierProvider._({
    required TankImageNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tankImageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tankImageNotifierHash();

  @override
  String toString() {
    return r'tankImageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TankImageNotifier create() => TankImageNotifier();

  @override
  bool operator ==(Object other) {
    return other is TankImageNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tankImageNotifierHash() => r'7b3c7b2560058e77603a95705d9eb5f3190a5081';

/// Notifier for managing tank image operations

final class TankImageNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TankImageNotifier,
          AsyncValue<List<TankImageEntity>>,
          List<TankImageEntity>,
          FutureOr<List<TankImageEntity>>,
          int
        > {
  TankImageNotifierFamily._()
    : super(
        retry: null,
        name: r'tankImageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier for managing tank image operations

  TankImageNotifierProvider call(int tankId) =>
      TankImageNotifierProvider._(argument: tankId, from: this);

  @override
  String toString() => r'tankImageProvider';
}

/// Notifier for managing tank image operations

abstract class _$TankImageNotifier
    extends $AsyncNotifier<List<TankImageEntity>> {
  late final _$args = ref.$arg as int;
  int get tankId => _$args;

  FutureOr<List<TankImageEntity>> build(int tankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TankImageEntity>>, List<TankImageEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TankImageEntity>>,
                List<TankImageEntity>
              >,
              AsyncValue<List<TankImageEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
