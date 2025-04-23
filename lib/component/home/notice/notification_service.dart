import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// 🔹 알림 초기화
  static Future<void> initNotifications() async {
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitSettings =
    DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await notificationsPlugin.initialize(initSettings);

    // iOS 알림 권한 요청 (필수)
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // 시간대 데이터 초기화
    tz.initializeTimeZones();
  }

  /// 🔹 특정 시간에 알림 예약
  static Future<void> scheduleNotification(
      int id, String title, String body, int hour, int minute) async {
    final tz.TZDateTime notificationTime = _nextInstanceOfTime(hour, minute);

    // ✅ Logcat 출력용 디버그 메시지
    debugPrint('🔔 [알림 예약됨] ID: $id | 시간: $notificationTime | 제목: "$title"');

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'daily_notification_channel',
      'Daily Notifications',
      channelDescription: '매일 특정 시간에 울리는 알림',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      notificationTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// 🔹 예약된 알림 취소
  static Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  /// 🔹 다음 알림 시간 계산 (매일 반복)
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
