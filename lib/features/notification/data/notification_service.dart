import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:habitroot/features/habit/domain/habit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // 1) load tz database
    tz.initializeTimeZones();

    // 2) set local timezone from the device (IMPORTANT)
    try {
      final TimezoneInfo timeZoneInfo =
          await FlutterTimezone.getLocalTimezone();

      String identifier = timeZoneInfo.identifier;

// FIX: Normalize older alias
      if (identifier == "Asia/Calcutta") {
        identifier = "Asia/Kolkata";
      }

      if (timeZoneInfo.localizedName != null) {
        log("time zone info : ${timeZoneInfo.localizedName} ${identifier} ");
        tz.setLocalLocation(tz.getLocation(identifier));
      } else {
        tz.setLocalLocation(tz.getLocation('UTC'));
        debugPrint("Error in notificaion init : TimeZoneInfo is NULL");
      }
    } catch (e) {
      // fallback: use local (may be UTC on some devices/emulators)
      tz.setLocalLocation(tz.getLocation('UTC'));
      print(
          'NotificationService: failed to get device timezone, fallback to UTC. Error: $e');
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings =
        InitializationSettings(android: androidSettings, iOS: null);

    await _notifications.initialize(settings);
  }

  // static Future<void> init() async {
  //   tz.initializeTimeZones();

  //   const androidSettings =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const settings =
  //       InitializationSettings(android: androidSettings, iOS: null);

  //   await _notifications.initialize(settings);
  // }

  static Future<bool> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Android 13+ requires POST_NOTIFICATIONS permission
      if (await Permission.notification.isGranted) return true;
      final status = await Permission.notification.request();
      return status.isGranted;
    }

    return false;
  }

  static Future<void> showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Test Notifications',
      channelDescription: 'Channel for testing notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.show(
      0, // Notification ID
      'Test Notification',
      'This is a local push notification',
      const NotificationDetails(android: androidDetails, iOS: null),
    );
  }

  // Quick test: schedule a single notification 2 minutes from now (local tz)
  static Future<void> scheduleQuickTest() async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = now.add(const Duration(minutes: 2));

    log('Now (tz.local): $now');
    log('Scheduling quick test for (tz.local): $scheduled');

    const androidDetails = AndroidNotificationDetails(
      'quick_test_channel',
      'Quick Test',
      channelDescription: 'Channel for quick scheduling tests',
      importance: Importance.max,
      priority: Priority.max,
    );

    await _notifications.zonedSchedule(
      999999, // test id (unique for quick tests)
      'Quick test notification',
      'This should fire 2 minutes after scheduling',
      scheduled,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );

    log('zonedSchedule called for id=999999');
  }

  // Optional: schedule next weekday occurrence (useful for weekly test)
  static tz.TZDateTime _nextInstanceOfWeekdayTimeLocal(
      int hour, int minute, int weekday) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    int daysToAdd = (weekday - scheduled.weekday) % 7;
    if (daysToAdd < 0) daysToAdd += 7;
    if (daysToAdd == 0 && scheduled.isBefore(now)) daysToAdd = 7;
    if (daysToAdd > 0) scheduled = scheduled.add(Duration(days: daysToAdd));
    return scheduled;
  }

  Future<void> scheduleWeekdayReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required List<int> weekdays, // expects 1 = Monday ... 7 = Sunday
  }) async {
    for (var weekday in weekdays) {
      final scheduleDate = _nextInstanceOfWeekdayTime(hour, minute, weekday);

      // log for debugging
      log('Scheduling id=${_generateWeekdayId(id, weekday)}'
          ' weekday=$weekday -> $scheduleDate');

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'habit_channel_id',
        'Habit Reminders',
        channelDescription: 'Reminder notifications for habits',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        enableVibration: true,
        category: AndroidNotificationCategory.reminder,
        visibility: NotificationVisibility.public,
        channelShowBadge: true,
        enableLights: true,
        ledColor: Color(0xFFFFFFFF),
        ledOnMs: 700,
        ledOffMs: 400,
      );

      await _notifications.zonedSchedule(
        _generateWeekdayId(id, weekday),
        title,
        body,
        scheduleDate,
        const NotificationDetails(
          android: androidDetails,
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    }
  }

  // Future<void> scheduleWeekdayReminder({
  //   required int id,
  //   required String title,
  //   required String body,
  //   required int hour,
  //   required int minute,
  //   required List<int> weekdays,
  // }) async {
  //   for (var weekday in weekdays) {
  //     await _notifications.zonedSchedule(
  //       _generateWeekdayId(id, weekday),
  //       title,
  //       body,
  //       _nextInstanceOfWeekdayTime(hour, minute, weekday),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'habit_channel_id',
  //           'Habit Reminders',
  //           channelDescription: 'Reminders for habits',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           enableVibration: true,
  //           playSound: true,
  //         ),
  //         iOS: DarwinNotificationDetails(),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  //     );
  //   }
  // }

  Future<void> updateHabitReminder({
    required Habit habit,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required List<int> weekdays,
  }) async {
    for (int weekday in habit.reminder?.weekdays ?? []) {
      await _notifications.cancel(
        _generateWeekdayId(habit.reminder?.id ?? 0, weekday),
      );
    }

    await scheduleWeekdayReminder(
      id: habit.reminder?.id ?? 0,
      title: habit.name,
      body: body,
      hour: hour,
      minute: minute,
      weekdays: weekdays,
    );
  }

  Future<void> cancelHabitReminders(Habit habit) async {
    if (habit.reminder == null) return;

    for (int weekday in habit.reminder!.weekdays) {
      await _notifications.cancel(
        _generateWeekdayId(habit.reminder!.id, weekday),
      );
    }
  }

  int _generateWeekdayId(int notificationId, int weekday) {
    // make a unique id per habit + weekday (avoid simple sums)
    return notificationId * 10 + weekday; // safe if weekday 1..7
  }

  tz.TZDateTime _nextInstanceOfWeekdayTime(int hour, int minute, int weekday) {
    final now = tz.TZDateTime.now(tz.local);

    // create candidate for today at given hour/minute in local tz
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // compute days to add to get requested weekday (1..7)
    int daysToAdd = (weekday - scheduled.weekday) % 7;
    if (daysToAdd < 0) {
      daysToAdd += 7; // safety (Dart % already non-negative but keep explicit)
    }
    // if the time is in the past for today, and weekday is the same, schedule next week
    if (daysToAdd == 0 && scheduled.isBefore(now)) {
      daysToAdd = 7;
    }

    if (daysToAdd > 0) {
      scheduled = scheduled.add(Duration(days: daysToAdd));
    }

    return scheduled;
  }

  static Future<void> cancelReminder(int id) async {
    await _notifications.cancel(id);
  }
}
