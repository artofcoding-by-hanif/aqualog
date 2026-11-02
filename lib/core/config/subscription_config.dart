/// RevenueCat configuration.
///
/// The SDK keys below are RevenueCat *public* keys (they start with `goog_` /
/// `appl_`); they are designed to ship inside the app and are safe to commit.
/// The secret REST key lives only in Cloud Functions (REVENUECAT_SECRET_KEY).
///
/// Leave a key empty to build without subscriptions: everyone is treated as a
/// free user and the paywall explains that purchases aren't available.
/// Keys can also be supplied at build time:
///   --dart-define=REVENUECAT_ANDROID_KEY=goog_xxx
class SubscriptionConfig {
  SubscriptionConfig._();

  static const String androidApiKey = String.fromEnvironment(
    'REVENUECAT_ANDROID_KEY',
  );

  static const String iosApiKey = String.fromEnvironment('REVENUECAT_IOS_KEY');

  /// Entitlement that unlocks Premium, as named in the RevenueCat dashboard
  static const String entitlementId = 'premium';

  /// Tanks a free user can create
  static const int freeTankLimit = 2;

  /// AI requests per day, shown in the paywall (enforced by Cloud Functions)
  static const int freeAiDailyLimit = 3;
  static const int premiumAiDailyLimit = 100;

  /// Days of water parameter history free accounts can chart
  static const int freeChartDays = 30;
}
