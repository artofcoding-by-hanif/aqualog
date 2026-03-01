// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the LocalNotificationService singleton

@ProviderFor(notificationService)
final notificationServiceProvider = NotificationServiceProvider._();

/// Provider for the LocalNotificationService singleton

final class NotificationServiceProvider
    extends
        $FunctionalProvider<
          LocalNotificationService,
          LocalNotificationService,
          LocalNotificationService
        >
    with $Provider<LocalNotificationService> {
  /// Provider for the LocalNotificationService singleton
  NotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationServiceHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationService create(Ref ref) {
    return notificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationService>(value),
    );
  }
}

String _$notificationServiceHash() =>
    r'2c9ac872deaab0bd2b6b5b2713f901dc1425bb07';

/// Provider to check if notifications are initialized

@ProviderFor(notificationsInitialized)
final notificationsInitializedProvider = NotificationsInitializedProvider._();

/// Provider to check if notifications are initialized

final class NotificationsInitializedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider to check if notifications are initialized
  NotificationsInitializedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsInitializedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsInitializedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return notificationsInitialized(ref);
  }
}

String _$notificationsInitializedHash() =>
    r'5950cb3643953ef505c73539ddd1f953e1889da2';

/// Provider to check notification permissions

@ProviderFor(notificationPermissions)
final notificationPermissionsProvider = NotificationPermissionsProvider._();

/// Provider to check notification permissions

final class NotificationPermissionsProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider to check notification permissions
  NotificationPermissionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPermissionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPermissionsHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return notificationPermissions(ref);
  }
}

String _$notificationPermissionsHash() =>
    r'cedc79aed99193ebeaf4f3841c4bdf6eb6076a48';

/// Provider to get pending notifications

@ProviderFor(pendingNotifications)
final pendingNotificationsProvider = PendingNotificationsProvider._();

/// Provider to get pending notifications

final class PendingNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PendingNotificationRequest>>,
          List<PendingNotificationRequest>,
          FutureOr<List<PendingNotificationRequest>>
        >
    with
        $FutureModifier<List<PendingNotificationRequest>>,
        $FutureProvider<List<PendingNotificationRequest>> {
  /// Provider to get pending notifications
  PendingNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingNotificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<PendingNotificationRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PendingNotificationRequest>> create(Ref ref) {
    return pendingNotifications(ref);
  }
}

String _$pendingNotificationsHash() =>
    r'499bfd06589d3a42ae9ac23039f9994d08bd580a';
