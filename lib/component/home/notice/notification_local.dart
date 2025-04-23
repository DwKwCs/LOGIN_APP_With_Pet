import 'package:login_withpet/database/db_helper.dart';
import 'package:login_withpet/component/home/notice/notice_share_preferences.dart';
import 'package:login_withpet/component/home/notice/notification_service.dart';

/// 오늘의 편지/캘린더 작성 여부를 확인하고
/// 설정값에 따라 로컬 알림을 예약 또는 취소합니다.
/// 앱 시작 시 또는 수동으로 호출할 수 있습니다.
Future<void> reloadDailyNotificationFromMain() async {
  final dbHelper = DatabaseHelper();
  final prefs = NoticeSharePreferences();
  final settings = await prefs.loadNotificationSettings();

  final String today = DateTime.now().toString().split(' ')[0];
  final letter = await dbHelper.getLetterByDate(today);
  final calendar = await dbHelper.getDiaryByDate(today);

  const int hour = 18;
  const int minute = 00;

  // 편지 알림
  if (settings[0] && letter == null) {
    await NotificationService.scheduleNotification(
      0,
      "오늘의 편지를 작성하세요!",
      "오늘의 편지를 작성하지 않으면 내일도 알림이 옵니다.",
      hour,
      minute,
    );
  } else {
    await NotificationService.cancelNotification(0);
  }

  // 캘린더 알림
  if (settings[1] && calendar == null) {
    await NotificationService.scheduleNotification(
      1,
      "오늘의 캘린더를 작성하세요!",
      "오늘의 캘린더를 작성하지 않으면 내일도 알림이 옵니다.",
      hour,
      minute,
    );
  } else {
    await NotificationService.cancelNotification(1);
  }
}
