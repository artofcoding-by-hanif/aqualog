import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notification_channels.dart';

/// Callback for handling notification taps when app is in foreground
typedef NotificationTapCallback = void Function(NotificationResponse response);

/// Local notification service using flutter_local_notifications
class LocalNotificationService {
  static LocalNotificationService? _instance;
  static NotificationTapCallback? _onNotificationTap;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  LocalNotificationService._();

  static LocalNotificationService get instance {
    _instance ??= LocalNotificationService._();
    return _instance!;
  }

  /// Set callback for notification taps
  static void setNotificationTapCallback(NotificationTapCallback callback) {
    _onNotificationTap = callback;
  }

  /// Check if notifications are initialized
  bool get isInitialized => _isInitialized;

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone database
    tz.initializeTimeZones();

    // Set local timezone based on device offset
    final now = DateTime.now();
    final localOffset = now.timeZoneOffset;
    final offsetMinutes = localOffset.inMinutes;
    String? tzName;

    // Common timezone mappings (offset in minutes -> timezone name)
    const timezoneMap = {
      330: 'Asia/Kolkata', // UTC+5:30 (India)
      300: 'Asia/Karachi', // UTC+5 (Pakistan)
      345: 'Asia/Kathmandu', // UTC+5:45 (Nepal)
      360: 'Asia/Dhaka', // UTC+6 (Bangladesh)
      390: 'Asia/Yangon', // UTC+6:30 (Myanmar)
      420: 'Asia/Bangkok', // UTC+7
      480: 'Asia/Singapore', // UTC+8
      540: 'Asia/Tokyo', // UTC+9
      570: 'Australia/Adelaide', // UTC+9:30
      600: 'Australia/Sydney', // UTC+10
      -300: 'America/New_York', // UTC-5 (EST)
      -360: 'America/Chicago', // UTC-6 (CST)
      -420: 'America/Denver', // UTC-7 (MST)
      -480: 'America/Los_Angeles', // UTC-8 (PST)
      0: 'UTC',
      60: 'Europe/Paris', // UTC+1
      120: 'Europe/Helsinki', // UTC+2
      180: 'Europe/Moscow', // UTC+3
      240: 'Asia/Dubai', // UTC+4
    };

    tzName = timezoneMap[offsetMinutes];

    if (tzName != null) {
      try {
        tz.setLocalLocation(tz.getLocation(tzName));
      } catch (e) {
        tzName = null;
      }
    }

    // Fallback to Etc/GMT+X if no match found (only supports whole hours)
    if (tzName == null) {
      final offsetHours = localOffset.inHours;
      if (offsetHours == 0) {
        tzName = 'UTC';
      } else if (offsetHours > 0) {
        tzName = 'Etc/GMT-$offsetHours';
      } else {
        tzName = 'Etc/GMT+${-offsetHours}';
      }

      try {
        tz.setLocalLocation(tz.getLocation(tzName));
      } catch (e) {
        tz.setLocalLocation(tz.UTC);
      }
    }

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS/macOS initialization settings
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onBackgroundNotificationResponse,
    );

    // Create Android notification channels
    if (Platform.isAndroid) {
      await _createNotificationChannels();
    }

    _isInitialized = true;
  }

  /// Request notification permissions (iOS/Android 13+)
  Future<bool> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }

    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final result = await androidPlugin?.requestNotificationsPermission();
      return result ?? false;
    }

    return true;
  }

  /// Check if notification permissions are granted
  Future<bool> arePermissionsGranted() async {
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await androidPlugin?.areNotificationsEnabled() ?? false;
    }
    // For iOS, we assume granted if we can schedule
    return true;
  }

  /// Show an immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationChannel channel = NotificationChannel.reminders,
  }) async {
    await _ensureInitialized();

    final details = _getNotificationDetails(channel);
    await _plugin.show(id, title, body, details, payload: payload);
  }

  /// Schedule a notification for a specific date/time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    NotificationChannel channel = NotificationChannel.reminders,

    /// Fire again every day at the same time until cancelled
    bool repeatDaily = false,
  }) async {
    await _ensureInitialized();

    final details = _getNotificationDetails(channel);

    // Create TZDateTime directly from components to preserve local time
    // Don't use tz.TZDateTime.from() as it incorrectly converts local DateTime
    final tzScheduledDate = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
      scheduledDate.second,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledDate,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: repeatDaily ? DateTimeComponents.time : null,
    );
  }

  /// Schedule a daily repeating notification
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
    NotificationChannel channel = NotificationChannel.reminders,
  }) async {
    await _ensureInitialized();

    final details = _getNotificationDetails(channel);
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If time has passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule a weekly repeating notification
  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int weekday, // 1 = Monday, 7 = Sunday
    required int hour,
    required int minute,
    String? payload,
    NotificationChannel channel = NotificationChannel.reminders,
  }) async {
    await _ensureInitialized();

    final details = _getNotificationDetails(channel);
    final scheduledDate = _nextInstanceOfWeekday(weekday, hour, minute);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }

  // ============================================================
  // Private Methods
  // ============================================================

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  Future<void> _createNotificationChannels() async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin == null) return;

    // Reminders channel
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.remindersChannelId,
        NotificationChannels.remindersChannelName,
        description: NotificationChannels.remindersChannelDescription,
        importance: Importance.high,
      ),
    );

    // Alerts channel
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.alertsChannelId,
        NotificationChannels.alertsChannelName,
        description: NotificationChannels.alertsChannelDescription,
        importance: Importance.max,
      ),
    );
  }

  NotificationDetails _getNotificationDetails(NotificationChannel channel) {
    final channelInfo = _getChannelInfo(channel);

    final androidDetails = AndroidNotificationDetails(
      channelInfo.id,
      channelInfo.name,
      channelDescription: channelInfo.description,
      importance: channel == NotificationChannel.alerts
          ? Importance.max
          : Importance.high,
      priority: channel == NotificationChannel.alerts
          ? Priority.max
          : Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  ({String id, String name, String description}) _getChannelInfo(
    NotificationChannel channel,
  ) {
    switch (channel) {
      case NotificationChannel.reminders:
        return (
          id: NotificationChannels.remindersChannelId,
          name: NotificationChannels.remindersChannelName,
          description: NotificationChannels.remindersChannelDescription,
        );
      case NotificationChannel.alerts:
        return (
          id: NotificationChannels.alertsChannelId,
          name: NotificationChannels.alertsChannelName,
          description: NotificationChannels.alertsChannelDescription,
        );
    }
  }

  tz.TZDateTime _nextInstanceOfWeekday(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Find the next occurrence of the weekday
    while (scheduledDate.weekday != weekday || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  // Callback handlers
  static void _onNotificationResponse(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    _onNotificationTap?.call(response);
  }

  @pragma('vm:entry-point')
  static void _onBackgroundNotificationResponse(NotificationResponse response) {
    // Handle background notification tap
    debugPrint('Background notification tapped: ${response.payload}');
  }
}

/// Notification channels
enum NotificationChannel { reminders, alerts }
