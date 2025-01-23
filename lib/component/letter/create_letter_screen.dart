import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/app_bar.dart';

class CreateLetterScreen extends StatelessWidget {
  const CreateLetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: const SafeArea(
        child: Text("편지 작성 화면")
      ),
    );
  }
}