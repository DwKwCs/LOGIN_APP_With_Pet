import 'package:login_withpet/database/db_helper.dart';

Future<void> initInsertGuideData() async {
  final guides = [
    {'Code': 101, 'Title': '임종 가이드1', 'Tag': '임종'},
    {'Code': 102, 'Title': '임종 가이드2', 'Tag': '임종'},
    {'Code': 103, 'Title': '임종 가이드3', 'Tag': '임종'},
    {'Code': 201, 'Title': '건강 가이드1', 'Tag': '건강'},
    {'Code': 202, 'Title': '건강 가이드2', 'Tag': '건강'},
    {'Code': 203, 'Title': '건강 가이드3', 'Tag': '건강'},
    {'Code': 301, 'Title': '음식 가이드1', 'Tag': '음식'},
    {'Code': 302, 'Title': '음식 가이드2', 'Tag': '음식'},
    {'Code': 303, 'Title': '음식 가이드3', 'Tag': '음식'},
  ];

  for (final guide in guides) {
    await DatabaseHelper().insertGuide({
      'Code': guide['Code'],
      'Title': guide['Title'],
      'Tag': guide['Tag'],
      'Percent': 0,
      'IsSaved': 0,
    });

    for (int i = 1; i <= 3; i++) {
      await DatabaseHelper().insertContent({
        'G_code': guide['Code'],
        'Number': i,
        'Content': '내용$i',
      });
    }
  }
}