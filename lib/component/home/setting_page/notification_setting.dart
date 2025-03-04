import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_withpet/component/home/notification_service.dart';
import 'package:login_withpet/component/home/notice_share_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  List<bool> noticeChecked = [true, true];

  @override
  void initState() {
    super.initState();
    _loadSettings(); // 앱 시작 시 알림 설정 불러오기
  }

  // 알림 설정 불러오기
  Future<void> _loadSettings() async {
    NoticeSharePreferences settings = NoticeSharePreferences();
    List<bool> savedSettings = await settings.loadNotificationSettings();
    setState(() {
      noticeChecked = savedSettings;
    });
  }

  // 알림 설정 저장
  Future<void> _saveSettings() async {
    NoticeSharePreferences settings = NoticeSharePreferences();
    await settings.saveNotificationSettings(noticeChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          '알림 설정',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          noticeCard('편지 알림 설정', 0),
          noticeCard('캘린더 알림 설정', 1),
        ],
      ),
    );
  }

  Widget noticeCard(String title, int index) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xfff1ede6), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  index == 0
                      ? '오늘의 편지를 작성하지 않으면 알림을 보냅니다.'
                      : '오늘의 캘린더를 작성하지 않으면 알림을 보냅니다.',
                  style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            activeColor: const Color(0xffffc873),
            value: noticeChecked[index],
            onChanged: (bool value) {
              setState(() {
                noticeChecked[index] = value;
                _updateNotification(index, value); // 알림 활성화/비활성화
                _saveSettings(); // 설정 변경 시 저장
              });
            },
          ),
        ],
      ),
    );
  }

  /// 알림 설정 업데이트
  void _updateNotification(int index, bool isEnabled) {
    if (isEnabled) {
      String title = index == 0 ? "편지 작성 알림" : "캘린더 작성 알림";
      String body = index == 0
          ? "오늘의 편지를 아직 작성하지 않았어요! 작성해 보세요."
          : "오늘의 캘린더를 아직 작성하지 않았어요! 작성해 보세요.";
      NotificationService.showNotification(title, body);
    }
  }
}