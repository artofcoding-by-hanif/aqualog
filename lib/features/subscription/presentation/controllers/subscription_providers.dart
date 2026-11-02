import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/settings/settings_provider.dart';
import '../../data/subscription_service.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>(
  (ref) => SubscriptionService.instance,
);

/// Whether the store reports an active Premium entitlement
final storePremiumProvider = StreamProvider<bool>((ref) async* {
  final service = ref.watch(subscriptionServiceProvider);
  yield service.isPremium;
  yield* service.premiumChanges;
});

/// Debug builds only: pretend to be Premium to test gated features without
/// a store purchase (dev builds can't buy through Google Play)
class DebugPremiumOverride extends Notifier<bool> {
  static const _key = 'debug_premium_override';

  @override
  bool build() {
    if (!kDebugMode) return false;
    final storage = ref.read(localStorageProvider);
    storage.initialize().then((_) {
      final saved = storage.getBool(_key) ?? false;
      if (saved != state) state = saved;
    });
    return false;
  }

  Future<void> set(bool value) async {
    if (!kDebugMode) return;
    state = value;
    final storage = ref.read(localStorageProvider);
    await storage.initialize();
    await storage.setBool(_key, value);
  }
}

final debugPremiumOverrideProvider =
    NotifierProvider<DebugPremiumOverride, bool>(DebugPremiumOverride.new);

/// The single source of truth for "is this user Premium?" in the UI
final isPremiumProvider = Provider<bool>((ref) {
  if (ref.watch(debugPremiumOverrideProvider)) return true;
  return ref.watch(storePremiumProvider).value ?? false;
});

/// Current RevenueCat offering (null when subscriptions aren't configured)
final currentOfferingProvider = FutureProvider.autoDispose<Offering?>((ref) {
  return ref.watch(subscriptionServiceProvider).currentOffering();
});
