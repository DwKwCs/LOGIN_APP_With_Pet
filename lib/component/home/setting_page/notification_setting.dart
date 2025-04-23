import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_withpet/component/home/notice/notice_share_preferences.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:login_withpet/component/home/notice/notification_service.dart';
import 'package:login_withpet/component/home/notice/notification_local.dart'; // 🔹 알림 조건 확인 로직

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> noticeChecked = [true, true];

  @override
  void initState() {
    super.initState();
    _initializeNotificationSettings();
  }

  Future<void> _initializeNotificationSettings() async {
    await NotificationService.initNotifications(); // 알림 시스템 초기화
    final saved = await NoticeSharePreferences().loadNotificationSettings();
    setState(() {
      noticeChecked = saved;
    });
  }

  Future<void> _onSwitchChanged(int index, bool value) async {
    setState(() {
      noticeChecked[index] = value;
    });

    await NoticeSharePreferences().saveNotificationSettings(noticeChecked);

    // 알림 조건 재검사 후 예약/취소 수행
    await reloadDailyNotificationFromMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
            onChanged: (bool value) async {
              await _onSwitchChanged(index, value);
            },
          ),
        ],
      ),
    );
  }
}
