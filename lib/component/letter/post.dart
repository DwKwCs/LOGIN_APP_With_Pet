import 'package:flutter/material.dart';

import 'package:login_withpet/component/letter/edit_letter_screen.dart';
import 'package:login_withpet/component/letter/color.dart';

String formatDate(String input) {
  // 정규표현식으로 날짜와 시간 추출
  final regex = RegExp(r'^(\d{4})-(\d{2})-(\d{2})'); // yyyy-MM-dd 형식 추출
  final match = regex.firstMatch(input);
  if (match != null) {
    final year = int.parse(match.group(1)!); // 연도
    final month = int.parse(match.group(2)!); // 월
    final day = int.parse(match.group(3)!); // 일

    // 원하는 포맷으로 변환 (24년 04월 10일)
    return '${year % 100}년 ${month.toString().padLeft(2, '0')}월 ${day.toString().padLeft(2, '0')}일';
  }

  return 'Invalid date format'; // 형식이 맞지 않을 경우
}

class Post extends StatelessWidget {
  final String postData;
  final DateTime postDate;
  const Post({super.key, required this.postData, required this.postDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { 
        debugPrint('Post tapped');
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => EditPostScreen(
            postData: postData,
            postDate: formatDate(postDate.toString()),
          )
        )
        );
      },
      child: Container(
      width: MediaQuery.of(context).size.width * 0.88,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: colorPrimaryVar),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.88 * 0.05),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.17 * 0.08),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  style: const TextStyle(
                    color: colorSub3,
                  ),
                  postData,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  formatDate(postDate.toString()),
                  style: const TextStyle(
                    color: colorDeselect,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  } 
}
