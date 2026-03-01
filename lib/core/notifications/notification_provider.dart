import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_notification_service.dart';

part 'notification_provider.g.dart';

/// Provider for the LocalNotificationService singleton
@Riverpod(keepAlive: true)
LocalNotificationService notificationService(Ref ref) {
  return LocalNotificationService.instance;
}

/// Provider to check if notifications are initialized
@riverpod
Future<bool> notificationsInitialized(Ref ref) async {
  final service = ref.watch(notificationServiceProvider);
  if (!service.isInitialized) {
    await service.initialize();
  }
  return service.isInitialized;
}

/// Provider to check notification permissions
@riverpod
Future<bool> notificationPermissions(Ref ref) async {
  final service = ref.watch(notificationServiceProvider);
  return await service.arePermissionsGranted();
}

/// Provider to get pending notifications
@riverpod
Future<List<PendingNotificationRequest>> pendingNotifications(Ref ref) async {
  final service = ref.watch(notificationServiceProvider);
  return await service.getPendingNotifications();
}
