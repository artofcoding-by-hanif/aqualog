# AI Assistant Setup

The AI features (chat assistant and tank health check) run through Firebase
Cloud Functions, which hold the Gemini API key. The app never sees the key.

```
App ──(anonymous sign-in + App Check)──▶ aiChat / analyzeTank ──▶ Gemini
                                              │
                                              └─ Firestore: daily usage counters
```

Until steps 1–5 are done, the app still runs normally; the AI screens show
"not set up in this build yet".

## 1. One-time machine fixes

Some config folders in your home directory are owned by root (from an old
`sudo npm install`), which breaks the Firebase and npm CLIs:

```bash
sudo chown -R "$(whoami)" ~/.config ~/.npm
```

## 2. Create the Firebase project

1. Sign in: `firebase login`
2. Go to <https://console.firebase.google.com> and create a project
   (for example `aqualog-app`).
3. **Upgrade to the Blaze plan** (Cloud Functions need it; the free tier
   still covers light usage). Set a budget alert under Billing.
4. **Authentication** → Get started → Sign-in method → enable **Anonymous**.
5. **Firestore Database** → Create database → production mode → pick a region.

## 3. Connect the app

From the repo root:

```bash
# Use Flutter's own Dart (an old Homebrew Dart on PATH installs an
# outdated CLI that crashes on build.gradle.kts)
flutter pub global activate flutterfire_cli
firebase login --reauth       # if the CLI says credentials expired (401)
firebase use --add            # pick the project, alias "default"

# Dev flavor (the build you run with --flavor dev in debug)
flutterfire configure --yes --project=<project-id> \
  --platforms=android,ios \
  --android-package-name=com.growdiom.aqualog.dev.debug \
  --ios-bundle-id=com.growdiom.aqualog.dev \
  --out=lib/firebase_options_dev.dart

# Prod flavor (release builds)
flutterfire configure --yes --project=<project-id> \
  --platforms=android,ios \
  --android-package-name=com.growdiom.aqualog \
  --ios-bundle-id=com.growdiom.aqualog \
  --out=lib/firebase_options_prod.dart
```

These overwrite the placeholder `lib/firebase_options_*.dart` files. They
contain public client identifiers (not secrets) and are safe to commit.

> If flutterfire asks to add the Google Services Gradle plugin, decline: the
> app initializes Firebase from the Dart options files. Any
> `google-services.json`, `GoogleService-Info.plist` or
> `firebase_app_id_file.json` it writes are git-ignored and can be deleted.

## 4. App Check

App Check makes sure only your app can call the functions.

1. Console → **App Check** → Apps → register each Android app with
   **Play Integrity**. Add your signing certificate SHA-256 under
   Project settings → Your apps → Add fingerprint:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -storepass android | grep SHA256
   ```
2. **Debug builds** use the debug provider. Run the app once, then find the
   token in the logs:
   ```bash
   adb logcat | grep -i "DebugAppCheckProvider"
   ```
   Add it under App Check → Apps → (dev app) → ⋮ → **Manage debug tokens**.
   To keep the same token across reinstalls, pass it explicitly:
   `flutter run ... --dart-define=APP_CHECK_DEBUG_TOKEN=<token>`

## 5. Set the Gemini key and deploy

Get a key at <https://aistudio.google.com/apikey>, then:

```bash
firebase functions:secrets:set GEMINI_API_KEY     # paste the key when prompted
firebase deploy --only functions,firestore:rules
```

The key is stored in Google Secret Manager; it never goes in the repo or the
app.

## Configuration

Set at deploy time. The CLI prompts on first deploy and saves the answers in
`functions/.env.<project-id>` (no secrets; safe to commit). Edit that file and
redeploy to change them:

| Param               | Default               | Purpose                                   |
|---------------------|-----------------------|-------------------------------------------|
| `GEMINI_MODEL`      | `gemini-flash-latest` | Gemini model id                           |
| `GEMINI_FALLBACK_MODEL` | `gemini-flash-lite-latest` | Used when the main model is overloaded (503/429) |
| `AI_DAILY_LIMIT`    | `30`                  | Requests per user per day                 |

## Developing the functions

```bash
cd functions
npm install
npm test          # builds and runs the validation tests
npm run serve     # local emulator
firebase functions:log
```

## Costs

Each chat message or health check is one Gemini Flash request with about
3–5 KB of tank context. At Flash pricing that is a fraction of a cent per
request; `AI_DAILY_LIMIT` caps how much any one user can spend.
