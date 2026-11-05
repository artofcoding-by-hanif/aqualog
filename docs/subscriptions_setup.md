# Subscriptions Setup (RevenueCat)

AquaLog sells one **Premium** entitlement through RevenueCat, with a monthly
and a yearly plan (yearly with a 7-day free trial).

| | Free | Premium |
|---|---|---|
| Tanks | 2 (existing extra tanks are kept) | Unlimited |
| AI chat + health checks | 3 per day | 100 per day (fair use) |
| Backup & restore | ✓ | ✓ |
| Water-parameter charts | Last 30 days | Full history, overlays, CSV export |

```
App ──purchase──▶ Google Play / App Store ──▶ RevenueCat ◀──REST── aiChat / analyzeTank
 │                                                ▲
 └── Purchases.logIn(firebase uid) ──────────────┘
```

The app identifies to RevenueCat with the Firebase anonymous uid, so the AI
functions can check the same customer's entitlement server-side.

Until the steps below are done, the app runs as "free" for everyone and the
paywall says subscriptions aren't available. In debug builds, Settings has a
**Simulate Premium (debug)** switch for testing the app-side gates.

## 1. Release signing (required for Play billing)

Play Billing only works for an app uploaded to Play and signed with your
release key. Create one (keep it safe, losing it means you can't update the
app):

```bash
keytool -genkey -v -keystore ~/aqualog-release.jks -keyalg RSA -keysize 2048 \
  -validity 10000 -alias aqualog
```

Then wire it into `android/app/build.gradle.kts` (`signingConfigs.release`)
via an untracked `android/key.properties`. Ask Claude to do this part.

## 2. Google Play Console

1. Create the app with package **com.growdiom.aqualog**.
2. Upload a release build (`flutter build appbundle --flavor prod -t lib/main_prod.dart`)
   to **Internal testing** and add yourself as a tester.
3. **Monetize → Subscriptions**: create
   - `premium_monthly`: base plan `monthly`, auto-renewing, 1 month
   - `premium_yearly`: base plan `yearly`, auto-renewing, 1 year, with an
     offer: **free trial, 7 days**, for new customers
4. Set prices for your countries and activate both.
5. Create a **service account** for RevenueCat (Setup → API access, follow
   RevenueCat's "Google Play service credentials" guide) and download its
   JSON key.

## 3. RevenueCat dashboard

1. Create a project, then add an **Android app**: package
   `com.growdiom.aqualog`, upload the service-account JSON.
2. **Products**: import `premium_monthly` and `premium_yearly`.
3. **Entitlements**: create `premium` and attach both products.
4. **Offerings**: in the `default` offering add packages
   **$rc_monthly** → `premium_monthly` and **$rc_annual** → `premium_yearly`.
   Make it the current offering.
5. **API keys**:
   - Copy the Android **public** key (`goog_…`) into
     `lib/core/config/subscription_config.dart`
     (or pass `--dart-define=REVENUECAT_ANDROID_KEY=goog_…`). Public keys are
     safe to commit.
   - Create a **secret** key (`sk_…`, v1/REST) for the server.

## 4. Cloud Functions

```bash
firebase functions:secrets:set REVENUECAT_SECRET_KEY   # paste sk_… (or "none" for now)
firebase deploy --only functions
```

The deploy needs this secret to exist. Before RevenueCat is ready, set it to
`none`: everyone then gets the free AI limit.

Limits are in `functions/.env.aqualog-app-b8331`:

| Param | Default |
|---|---|
| `AI_FREE_DAILY_LIMIT` | `3` |
| `AI_PREMIUM_DAILY_LIMIT` | `100` |

## Testing

- **App gates** (tank limit, paywall, Premium UI): debug build + Settings →
  Simulate Premium.
- **Server limit as Premium**: in RevenueCat → Customers → find your
  Firebase uid → **Grant promotional entitlement** `premium`. Works with debug
  builds, no purchase needed.
- **Real purchases**: install the internal-testing build from Play with a
  license-tester account (Play Console → Setup → License testing); test
  purchases renew every few minutes and are never charged.
