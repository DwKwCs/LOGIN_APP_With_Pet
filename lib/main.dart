import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login_withpet/screen/main_screen.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:login_withpet/database/guide_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:login_withpet/component/home/notice/notification_local.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await initializeApp();

  runApp(const MyApp()); // ✅ UI 먼저 띄우기
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  tz.initializeTimeZones();
}

Future<void> initializeApp() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  // 데이터 삽입 조건은 최소로 간소화 가능
  if ((await dbHelper.getAllProfiles()).isEmpty) {
    await dbHelper.insertProfile({
      'Id': 1,
      'Img': null,
      'IsChecked': 0,
      'Name': '고영희',
      'Comment': '귀여운 고양이',
      'Species': '렉돌',
      'Data': '2024.12.25',
      'Ddate': null,
    });
  }

  if ((await dbHelper.getAllLetters(true)).isEmpty) {
    await dbHelper.insertLetter({'Date': '2025-02-20T14:30:45', 'Contents': '첫 번째 편지입니다.'});
    await dbHelper.insertLetter({'Date': '2025-02-21T14:30:46', 'Contents': '두 번째 편지입니다.'});
    await dbHelper.insertLetter({'Date': '2025-02-25T14:30:46', 'Contents': '세 번째 편지입니다.'});
    await dbHelper.insertLetter({'Date': '2025-03-03T14:30:46', 'Contents': '네 번째 편지입니다.'});
  }

  if ((await dbHelper.getAllTempLetters(true)).isEmpty) {
    await dbHelper.insertTempLetter({'Date': '2025-02-21T14:30:45', 'Contents': '첫 번째 임시편지입니다.'});
    await dbHelper.insertTempLetter({'Date': '2025-02-23T14:30:46', 'Contents': '두 번째 임시편지입니다.'});
  }

  if ((await dbHelper.getAllGuides()).isEmpty) {
    await initInsertGuideData();
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  await requestNotificationPermission(); // ✅ 알림 권한 요청 추가
  await initializeNotifications();        // 🔹 알림 초기화

  try {
    await reloadDailyNotificationFromMain();
    debugPrint("알림 예약 성공!!!");
  } catch (e) {
    debugPrint("알림 예약 실패: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      locale: const Locale('ko', 'KR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
    );
  }
}
