import 'package:shared_preferences/shared_preferences.dart';

class NoticeSharePreferences {
  // 알림 상태 저장
  Future<void> saveNotificationSettings(List<bool> noticeChecked) async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < noticeChecked.length; i++) {
      prefs.setBool('noticeChecked_$i', noticeChecked[i]); // 알림 상태를 저장
    }
  }

  // 알림 상태 불러오기
  Future<List<bool>> loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    List<bool> noticeChecked = [];
    for (int i = 0; i < 2; i++) { // 알림 설정의 개수를 2개로 설정 (편지, 캘린더)
      noticeChecked.add(prefs.getBool('noticeChecked_$i') ?? true); // 저장된 상태가 없다면 기본값(true) 사용
    }
    return noticeChecked;
  }
}
