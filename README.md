# TankMind

A Flutter application for aquarium management and logging.

## Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK
- Android Studio / Xcode

### Installation

```bash
flutter pub get
```

## Flavors

This project supports two build flavors: **Dev** and **Prod**.

### Running the App

#### Development Flavor

```bash
# Debug mode
flutter run --flavor dev -t lib/main_dev.dart

# Release mode
flutter run --flavor dev -t lib/main_dev.dart --release
```

#### Production Flavor

```bash
# Debug mode
flutter run --flavor prod -t lib/main_prod.dart

# Release mode
flutter run --flavor prod -t lib/main_prod.dart --release
```

### Building the App

#### Android

```bash
# Dev APK
flutter build apk --flavor dev -t lib/main_dev.dart

# Prod APK
flutter build apk --flavor prod -t lib/main_prod.dart

# Dev App Bundle
flutter build appbundle --flavor dev -t lib/main_dev.dart

# Prod App Bundle
flutter build appbundle --flavor prod -t lib/main_prod.dart
```

#### iOS

```bash
# Dev
flutter build ios --flavor dev -t lib/main_dev.dart

# Prod
flutter build ios --flavor prod -t lib/main_prod.dart
```

### Flavor Configuration

| Setting | Dev | Prod |
|---------|-----|------|
| App Name | TankMind Dev | TankMind |
| Bundle ID | com.growdiom.aqualog.dev | com.growdiom.aqualog |
| Logging | Enabled | Disabled |
| Crashlytics | Disabled | Enabled |

### VS Code

Launch configurations are available in `.vscode/launch.json`. Use the Run and Debug panel to select:
- Dev (Debug)
- Dev (Profile)
- Dev (Release)
- Prod (Debug)
- Prod (Profile)
- Prod (Release)

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
