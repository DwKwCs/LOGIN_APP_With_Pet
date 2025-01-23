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
                Post(postData: "Helloworld", postDate: DateTime.now()),
                Post(postData: "Helloworld", postDate: DateTime.now()),
                Post(postData: "Helloworld", postDate: DateTime.now()),
                Post(postData: "Helloworld", postDate: DateTime.now()),
                Post(postData: "Helloworld", postDate: DateTime.now()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
