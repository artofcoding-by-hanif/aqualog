import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'background_tasks.dart';

part 'background_provider.g.dart';

/// Provider for the BackgroundTaskService singleton
@Riverpod(keepAlive: true)
BackgroundTaskService backgroundTaskService(Ref ref) {
  return BackgroundTaskService.instance;
}

/// Provider to check if background tasks are initialized
@riverpod
Future<bool> backgroundTasksInitialized(Ref ref) async {
  final service = ref.watch(backgroundTaskServiceProvider);
  if (!service.isInitialized) {
    await service.initialize();
  }
  return service.isInitialized;
}

