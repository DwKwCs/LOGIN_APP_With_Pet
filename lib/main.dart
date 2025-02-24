import 'package:login_withpet/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:login_withpet/database/guide_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 날짜 형식 초기화 (한국어 포함)
  await initializeDateFormatting();

  // 앱 초기화
  await initializeApp();

  // 앱 실행
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  // SQLite 초기화 및 테이블 생성
  await DatabaseHelper().database;

  // 프로필 테이블에서 데이터를 가져옵니다.
  final profiles = await DatabaseHelper().getAllProfiles();

  // 프로필 데이터가 없으면 삽입
  if (profiles.isEmpty) {
    await DatabaseHelper().insertProfile({
      'Id': 1,
      'Img': null,
      'IsChecked': 0,
      'Name': '고영희',
      'Comment': '귀여운 고양이',
      'Species': '렉돌',
      'Data': '2024.12.25',
      'Ddate': null,
    });
  } else {
    print('프로필 데이터가 이미 존재합니다.');
  }

  // 편지 테이블에서 데이터를 가져옵니다.
  final letters = await DatabaseHelper().getAllLetters();

  // 테스트 편지 데이터
  if (letters.isEmpty) {
    await DatabaseHelper().insertLetter({
      'Date': '2025-02-20T14:30:45',
      'Contents': '첫 번째 편지입니다.'
    });

    await DatabaseHelper().insertLetter({
      'Date': '2025-02-21T14:30:46',
      'Contents': '두 번째 편지입니다.'
    });

    await DatabaseHelper().insertLetter({
      'Date': '2025-02-25T14:30:46',
      'Contents': '세 번째 편지입니다.'
    });

    await DatabaseHelper().insertLetter({
      'Date': '2025-03-03T14:30:46',
      'Contents': '네 번째 편지입니다.'
    });
  } else {
    print('테스트 데이터가 이미 존재합니다.');
  }

  // 임시저장 테이블에서 데이터를 가져옵니다.
  final tempLetters = await DatabaseHelper().getAllTempLetters();

  // 테스트 편지 데이터
  if (tempLetters.isEmpty) {
    await DatabaseHelper().insertTempLetter({
      'Date': '2025-02-21T14:30:45',
      'Contents': '첫 번째 임시편지입니다.'
    });

    await DatabaseHelper().insertTempLetter({
      'Date': '2025-02-23T14:30:46',
      'Contents': '두 번째 임시편지입니다.'
    });
  } else {
    print('테스트 데이터가 이미 존재합니다.');
  }

  // 가이드 테이블에서 데이터를 가져옵니다.
  final guides = await DatabaseHelper().getAllGuides();

  // 초기 가이드 데이터 삽입
  if (guides.isEmpty) {
    await initInsertGuideData();
  } else {
    print('가이드 데이터가 이미 존재합니다.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      locale: const Locale('ko', 'KR'), // 한국어로 기본 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // 한국어 지원
        Locale('en', 'US'), // 영어 지원
      ],
    );
  }
}
