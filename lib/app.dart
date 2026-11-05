import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/notifications/local_notification_service.dart';
import 'core/settings/settings_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/aqua_widgets.dart';
import 'features/app/presentation/onboarding/onboarding_screen.dart';
import 'features/app/presentation/splash/splash_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/reminders/presentation/controllers/reminder_provider.dart';
import 'router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp(
      title: 'TankMind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      onGenerateRoute: AppRouter.generateRoute,
      home: const AquaBackground(child: _AppStartup()),
    );
  }
}

/// Handles the app startup flow: Splash → Onboarding (if first time) → Dashboard
class _AppStartup extends ConsumerStatefulWidget {
  const _AppStartup();

  @override
  ConsumerState<_AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends ConsumerState<_AppStartup> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    final notificationService = LocalNotificationService.instance;

    // Initialize the notification service
    await notificationService.initialize();

    // Request permissions (required for iOS and Android 13+)
    await notificationService.requestPermissions();

    // Reschedule all reminder notifications
    await ref.read(reminderProvider.notifier).rescheduleAllNotifications();
  }

  void _onSplashComplete() {
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show splash screen first
    if (_showSplash) {
      return SplashScreen(onComplete: _onSplashComplete);
    }

    // After splash, check if onboarding is completed
    final onboardingCompleted = ref.watch(onboardingCompletedProvider);

    // Show onboarding if not completed, otherwise show dashboard
    if (onboardingCompleted) {
      return const DashboardScreen();
    } else {
      return const OnboardingScreen();
    }
  }
}
