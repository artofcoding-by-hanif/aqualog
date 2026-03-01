// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the BackgroundTaskService singleton

@ProviderFor(backgroundTaskService)
final backgroundTaskServiceProvider = BackgroundTaskServiceProvider._();

/// Provider for the BackgroundTaskService singleton

final class BackgroundTaskServiceProvider
    extends
        $FunctionalProvider<
          BackgroundTaskService,
          BackgroundTaskService,
          BackgroundTaskService
        >
    with $Provider<BackgroundTaskService> {
  /// Provider for the BackgroundTaskService singleton
  BackgroundTaskServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundTaskServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundTaskServiceHash();

  @$internal
  @override
  $ProviderElement<BackgroundTaskService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackgroundTaskService create(Ref ref) {
    return backgroundTaskService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackgroundTaskService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackgroundTaskService>(value),
    );
  }
}

String _$backgroundTaskServiceHash() =>
    r'04af1aec1d6585a5759b1db58dbc4fd77969e9f4';

/// Provider to check if background tasks are initialized

@ProviderFor(backgroundTasksInitialized)
final backgroundTasksInitializedProvider =
    BackgroundTasksInitializedProvider._();

/// Provider to check if background tasks are initialized

final class BackgroundTasksInitializedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider to check if background tasks are initialized
  BackgroundTasksInitializedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundTasksInitializedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundTasksInitializedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return backgroundTasksInitialized(ref);
  }
}

String _$backgroundTasksInitializedHash() =>
    r'076c8a7cd208272b240ded148a9d500f71f907c4';
