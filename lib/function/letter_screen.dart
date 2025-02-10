import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/app_bar.dart';
import 'package:login_withpet/component/letter/post.dart';

class LetterScreen extends StatelessWidget {
  const LetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center, // 가로 방향으로 가운데 정렬
              spacing: 8.0, // 자식 위젯 간의 가로 간격
              runSpacing: 8.0, // 자식 위젯 간의 세로 간격
              children: [
                Post(postData: "안녕, 내 아가야! 오늘도 우리 멍멍이가 있어서 즐거운 하루였어. 같이 산책할 때 네가 좋아해서 기쁘더라. 너랑 오래오래 함께 하고 싶어. 내일은 더 오래 산책하자! 늘", postDate: DateTime.now()),
                Post(postData: "오늘은 네가 기운이 없더라. 좋아하는 간식을 줘도 힘이 없는 모습에 속상했어. 힘내자 사랑해. 아래로 내려갈수록 과거 편지입니다.", postDate: DateTime.now()),
                Post(postData: "오늘은 네가 기운이 없더라. 좋아하는 간식을 줘도 힘이 없는 모습에 속상했어. 힘내자 사랑해. 아래로 내려갈수록 과거 편지입니다.", postDate: DateTime.now()),
                Post(postData: "오늘은 네가 기운이 없더라. 좋아하는 간식을 줘도 힘이 없는 모습에 속상했어. 힘내자 사랑해. 아래로 내려갈수록 과거 편지입니다.", postDate: DateTime.now()),
                Post(postData: "오늘은 네가 기운이 없더라. 좋아하는 간식을 줘도 힘이 없는 모습에 속상했어. 힘내자 사랑해. 아래로 내려갈수록 과거 편지입니다.", postDate: DateTime.now()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
