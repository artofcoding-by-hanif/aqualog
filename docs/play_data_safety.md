# Play Console: Privacy Policy & Data Safety

Privacy policy: `hosting/public/privacy.html`, served at
**https://aqualog-app-b8331.web.app/privacy**

## Publishing the policy

1. The contact email is `kkssoftwaresolutions@gmail.com`; if it changes,
   update `hosting/public/privacy.html` and redeploy hosting. Confirm the
   publisher name (Growdiom).
2. The policy says AquaLog uses the **free tier** of the Gemini API (Google
   may use request content to improve its products). **When you switch to
   the paid tier** (billing enabled on the key's Google Cloud project),
   remove that paragraph from the policy's "AI assistant and health check"
   section and its short-version / provider-table mentions, change the
   Data safety "Shared" answer below back to **No**, update the effective
   date and redeploy hosting.
3. Turn on automatic deletion of AI usage counters: Firebase console →
   Firestore → **Time-to-live** → Create policy: collection group `days`,
   timestamp field `expireAt`. (The policy promises 30-day deletion.)
4. Deploy: `firebase deploy --only hosting`
5. Paste the URL into Play Console → **Policy → App content → Privacy policy**.

Update the "Effective" date in the policy whenever its content changes.

## Data safety form answers

Answers reflect the app as built (no analytics, ads or crash reporting;
tank data stays on device except for AI requests).

**Does your app collect or share any of the required user data types?** Yes

**Is all of the user data collected by your app encrypted in transit?** Yes

**Do you provide a way for users to request that their data is deleted?**
Yes: email with the Support ID (Settings → About); server records also
auto-delete after 30 days.

**Account creation:** the app has no user-created accounts (anonymous
Firebase sign-in only), so choose "My app does not allow users to create an
account".

### Data types

| Category → type | Collected | Shared | Ephemeral | Required? | Purposes |
|---|---|---|---|---|---|
| App activity → Other user-generated content (AI chat messages and the tank summary sent with them) | Yes | **Yes**† | Yes | Optional (only when using AI) | App functionality (collected); shared with Google for its product improvement |
| Device or other IDs (anonymous Firebase ID, App Check / Play Integrity) | Yes | No* | No | Required for AI and purchases | App functionality, Fraud prevention / security |
| Financial info → Purchase history (subscriptions via RevenueCat) | Yes | No* | No | Optional (only when buying) | App functionality, Account management |
| App info and performance → Diagnostics (server logs: timing, errors) | Yes | No* | No | Required for AI | App functionality |

\* Google (Firebase) and RevenueCat process this data **on our behalf** as
service providers, which Play does not count as "sharing".

† While AquaLog uses the **free** Gemini API tier, Google may use AI request
content for its own product improvement, so Play counts it as shared. Under
the **paid** tier Google acts as a service provider and this becomes **No**.

**Not collected:** name, email, phone, address, location, contacts, photos
(stay on device), audio, health/fitness, messages (SMS/email), web history,
installed apps, calendar, files (backups go only where the user saves them).

## Other App content declarations

- **Ads:** No ads.
- **Target audience:** 13+ (not designed for children).
- **Government / financial / health app:** No.
- **AI-generated content:** declare that the app includes generative AI
  (the assistant) if asked; responses are shown with a "can make mistakes"
  notice.
