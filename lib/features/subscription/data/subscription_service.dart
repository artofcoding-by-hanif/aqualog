import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/config/subscription_config.dart';
import '../../../core/firebase/firebase_bootstrap.dart';

/// User-facing purchase failure; [message] is safe to show as-is
class PurchaseFailure implements Exception {
  const PurchaseFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Wraps RevenueCat. The RevenueCat app user id is the Firebase uid, so the
/// AI Cloud Functions can look up the same customer's entitlements.
class SubscriptionService {
  SubscriptionService._();

  static final SubscriptionService instance = SubscriptionService._();

  bool _configured = false;
  final _premium = StreamController<bool>.broadcast();
  bool _lastPremium = false;

  String get _apiKey => Platform.isIOS
      ? SubscriptionConfig.iosApiKey
      : SubscriptionConfig.androidApiKey;

  /// Whether this build can sell subscriptions at all
  bool get isAvailable => _configured;

  bool get isPremium => _lastPremium;

  Stream<bool> get premiumChanges => _premium.stream;

  Future<void> initialize() async {
    if (_configured || _apiKey.isEmpty) return;
    try {
      final configuration = PurchasesConfiguration(_apiKey);
      // Reuse the Firebase identity when it already exists on this device
      if (FirebaseBootstrap.isReady) {
        configuration.appUserID = FirebaseAuth.instance.currentUser?.uid;
      }
      await Purchases.configure(configuration);
      _configured = true;
      Purchases.addCustomerInfoUpdateListener(_onCustomerInfo);
      _onCustomerInfo(await Purchases.getCustomerInfo());
    } catch (error) {
      debugPrint('Subscriptions unavailable: $error');
    }
  }

  /// Ties purchases to the Firebase user, so the server sees them
  Future<void> identify() async {
    if (!_configured || !FirebaseBootstrap.isReady) return;
    final auth = FirebaseAuth.instance;
    final uid =
        (auth.currentUser ?? (await auth.signInAnonymously()).user)?.uid;
    if (uid == null || await Purchases.appUserID == uid) return;
    final result = await Purchases.logIn(uid);
    _onCustomerInfo(result.customerInfo);
  }

  Future<Offering?> currentOffering() async {
    if (!_configured) return null;
    final offerings = await Purchases.getOfferings();
    return offerings.current;
  }

  /// Returns true if the purchase unlocked Premium; false if cancelled
  Future<bool> purchase(Package package) async {
    try {
      await identify();
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _onCustomerInfo(result.customerInfo);
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) return false;
      throw PurchaseFailure(_messageFor(code, e));
    }
  }

  /// Returns true if an active Premium purchase was found
  Future<bool> restore() async {
    try {
      await identify();
      return _onCustomerInfo(await Purchases.restorePurchases());
    } on PlatformException catch (e) {
      throw PurchaseFailure(
        _messageFor(PurchasesErrorHelper.getErrorCode(e), e),
      );
    }
  }

  /// Store page where the user can cancel or change their plan
  Future<String?> managementUrl() async {
    if (!_configured) return null;
    return (await Purchases.getCustomerInfo()).managementURL;
  }

  bool _onCustomerInfo(CustomerInfo info) {
    final active = info.entitlements.active.containsKey(
      SubscriptionConfig.entitlementId,
    );
    if (active != _lastPremium) {
      _lastPremium = active;
      _premium.add(active);
    }
    return active;
  }

  String _messageFor(PurchasesErrorCode code, PlatformException e) {
    switch (code) {
      case PurchasesErrorCode.networkError:
        return 'No connection to the store. Check your internet and try again.';
      case PurchasesErrorCode.purchaseNotAllowedError:
        return 'Purchases are not allowed on this device or account.';
      case PurchasesErrorCode.productAlreadyPurchasedError:
        return 'You already own this. Tap "Restore purchases".';
      case PurchasesErrorCode.paymentPendingError:
        return 'Your payment is pending. Premium unlocks once it completes.';
      case PurchasesErrorCode.storeProblemError:
        return 'The store had a problem. Please try again in a moment.';
      default:
        return e.message ?? 'The purchase could not be completed.';
    }
  }
}
