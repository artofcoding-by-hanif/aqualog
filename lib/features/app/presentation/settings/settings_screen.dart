import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/backup/backup_provider.dart';
import '../../../../core/backup/backup_service.dart';
import '../../../../core/config/legal_links.dart';
import '../../../../core/firebase/firebase_bootstrap.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/settings/app_settings.dart';
import '../../../../core/settings/settings_provider.dart';
import '../../../reminders/presentation/controllers/reminder_provider.dart';
import '../../../subscription/presentation/premium_settings_card.dart';
import '../../../../router/app_router.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (settings) => _buildSettingsList(context, ref, settings),
      ),
    );
  }

  Widget _buildSettingsList(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    return ListView(
      children: [
        const PremiumSettingsCard(),
        _buildSection(
          context,
          title: 'Appearance',
          children: [
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Theme'),
              subtitle: Text(settings.themeMode.displayName),
              onTap: () => _showThemeDialog(context, ref, settings.themeMode),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.vibration),
              title: const Text('Haptic Feedback'),
              value: settings.hapticFeedback,
              onChanged: (value) {
                ref.read(appSettingsProvider.notifier).setHapticFeedback(value);
              },
            ),
          ],
        ),
        _buildSection(
          context,
          title: 'Units',
          children: [
            ListTile(
              leading: const Icon(Icons.straighten),
              title: const Text('Volume Unit'),
              subtitle: Text(settings.volumeUnit.displayName),
              onTap: () =>
                  _showVolumeUnitDialog(context, ref, settings.volumeUnit),
            ),
            ListTile(
              leading: const Icon(Icons.thermostat),
              title: const Text('Temperature Unit'),
              subtitle: Text(settings.temperatureUnit.displayName),
              onTap: () => _showTemperatureUnitDialog(
                context,
                ref,
                settings.temperatureUnit,
              ),
            ),
          ],
        ),
        _buildSection(
          context,
          title: 'Notifications',
          children: [
            SwitchListTile(
              secondary: const Icon(Icons.notifications),
              title: const Text('Reminders'),
              subtitle: const Text('Enable maintenance reminders'),
              value: settings.remindersEnabled,
              onChanged: (value) {
                ref
                    .read(appSettingsProvider.notifier)
                    .setRemindersEnabled(value);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Default Reminder Time'),
              subtitle: Text(
                _formatTime(
                  settings.defaultReminderHour,
                  settings.defaultReminderMinute,
                ),
              ),
              enabled: settings.remindersEnabled,
              onTap: settings.remindersEnabled
                  ? () => _showTimePickerDialog(context, ref, settings)
                  : null,
            ),
          ],
        ),
        _buildSection(
          context,
          title: 'Display',
          children: [
            SwitchListTile(
              secondary: const Icon(Icons.trending_up),
              title: const Text('Show Parameter Trends'),
              subtitle: const Text('Display trend indicators on dashboard'),
              value: settings.showParameterTrends,
              onChanged: (value) {
                ref
                    .read(appSettingsProvider.notifier)
                    .setShowParameterTrends(value);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Default Trend Period'),
              subtitle: Text('${settings.defaultTrendDays} days'),
              enabled: settings.showParameterTrends,
              onTap: settings.showParameterTrends
                  ? () => _showTrendDaysDialog(context, ref, settings)
                  : null,
            ),
          ],
        ),
        _buildSection(
          context,
          title: 'Tools',
          children: [
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Glass Calculator'),
              subtitle: const Text('Calculate glass dimensions for DIY tanks'),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.glassCalculator);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_alt),
              title: const Text('Filter Calculator'),
              subtitle: const Text('Find the right filter for your tank'),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.filterCalculator);
              },
            ),
          ],
        ),
        _buildSection(
          context,
          title: 'Data',
          children: [
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Backup Data'),
              subtitle: const Text('Save tanks, logs and photos to a file'),
              onTap: () => _backupData(context, ref),
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Restore Data'),
              subtitle: const Text('Replace all data from a backup file'),
              onTap: () => _confirmRestore(context, ref),
            ),
            ListTile(
              leading: Icon(
                Icons.restart_alt,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Reset Settings',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () => _showResetDialog(context, ref),
            ),
          ],
        ),
        _buildSection(
          context,
          title: 'About',
          children: [
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final version = snapshot.data?.version ?? '...';
                final buildNumber = snapshot.data?.buildNumber ?? '';
                return ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Version'),
                  subtitle: Text('$version ($buildNumber)'),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
              onTap: () => launchUrl(
                Uri.parse(LegalLinks.privacyPolicy),
                mode: LaunchMode.externalApplication,
              ),
            ),
            _buildSupportIdTile(context),
          ],
        ),
      ],
    );
  }

  /// Anonymous Firebase id; users quote it to request deletion of
  /// server-side data (see the privacy policy)
  Widget _buildSupportIdTile(BuildContext context) {
    final uid = FirebaseBootstrap.isReady
        ? FirebaseAuth.instance.currentUser?.uid
        : null;
    return ListTile(
      leading: const Icon(Icons.badge_outlined),
      title: const Text('Support ID'),
      subtitle: Text(uid ?? 'Created when you first use the AI assistant'),
      trailing: uid == null ? null : const Icon(Icons.copy_rounded, size: 18),
      onTap: uid == null
          ? null
          : () {
              Clipboard.setData(ClipboardData(text: uid));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Support ID copied')),
              );
            },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  String _formatTime(int hour, int minute) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final displayMinute = minute.toString().padLeft(2, '0');
    return '$displayHour:$displayMinute $period';
  }

  void _showThemeDialog(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode current,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Theme'),
        children: AppThemeMode.values.map((mode) {
          return RadioListTile<AppThemeMode>(
            title: Text(mode.displayName),
            value: mode,
            groupValue: current,
            onChanged: (value) {
              if (value != null) {
                ref.read(appSettingsProvider.notifier).setThemeMode(value);
                HapticFeedback.selectionClick();
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  void _showVolumeUnitDialog(
    BuildContext context,
    WidgetRef ref,
    VolumeUnit current,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Volume Unit'),
        children: VolumeUnit.values.map((unit) {
          return RadioListTile<VolumeUnit>(
            title: Text(unit.displayName),
            value: unit,
            groupValue: current,
            onChanged: (value) {
              if (value != null) {
                ref.read(appSettingsProvider.notifier).setVolumeUnit(value);
                HapticFeedback.selectionClick();
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  void _showTemperatureUnitDialog(
    BuildContext context,
    WidgetRef ref,
    TemperatureUnit current,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Temperature Unit'),
        children: TemperatureUnit.values.map((unit) {
          return RadioListTile<TemperatureUnit>(
            title: Text(unit.displayName),
            value: unit,
            groupValue: current,
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(appSettingsProvider.notifier)
                    .setTemperatureUnit(value);
                HapticFeedback.selectionClick();
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _showTimePickerDialog(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.defaultReminderHour,
        minute: settings.defaultReminderMinute,
      ),
    );
    if (time != null) {
      ref
          .read(appSettingsProvider.notifier)
          .setDefaultReminderTime(time.hour, time.minute);
    }
  }

  void _showTrendDaysDialog(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final options = [3, 7, 14, 30, 60, 90];
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Trend Period'),
        children: options.map((days) {
          return RadioListTile<int>(
            title: Text('$days days'),
            value: days,
            groupValue: settings.defaultTrendDays,
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(appSettingsProvider.notifier)
                    .setDefaultTrendDays(value);
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to defaults?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(appSettingsProvider.notifier).resetToDefaults();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to defaults')),
              );
            },
            child: Text(
              'Reset',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  /// Run [task] behind a blocking progress dialog
  Future<T> _withProgress<T>(
    BuildContext context,
    String message,
    Future<T> Function() task,
  ) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 24),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
    );
    try {
      return await task();
    } finally {
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> _backupData(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final file = await _withProgress(
        context,
        'Creating backup…',
        () => ref.read(backupServiceProvider).createBackup(),
      );
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'application/zip')],
          subject: 'Aqualog backup',
        ),
      );
    } on BackupException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _confirmRestore(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Restore Data'),
        content: const Text(
          'This replaces all tanks, logs, reminders and photos with the '
          'contents of the backup file. Your current data is saved '
          'automatically first.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _restoreData(context, ref);
            },
            child: Text(
              'Choose File',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _restoreData(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    final path = picked?.files.single.path;
    if (path == null || !context.mounted) return;

    try {
      final summary = await _withProgress(
        context,
        'Restoring data…',
        () => ref.read(backupServiceProvider).restoreBackup(File(path)),
      );

      // Reload everything that read from the old data
      ref.invalidate(appDatabaseProvider);
      ref.invalidate(appSettingsProvider);
      await ref.read(reminderProvider.notifier).rescheduleAllNotifications();

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Restored ${summary.tanks} tanks and ${summary.images} photos',
          ),
        ),
      );
    } on BackupException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
