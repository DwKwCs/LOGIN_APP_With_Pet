import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
              title: Text(
                '반려동물 프로필 수정',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.check),
                ),
              ],
            ),
            SizedBox(height: 60),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Colors.green,
                size: 130,
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
              ),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
              ),
              child: Row(
                children: [
                  Text(
                    '이름',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: '김멍멍'),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
              ),
              child: Row(
                children: [
                  Text(
                    '한마디',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: '강아지'),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
              ),
              child: Row(
                children: [
                  Text(
                    '종',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 56),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: '골든 리트리버'),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
              ),
              child: Row(
                children: [
                  Text(
                    '생일',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 36),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: '2020.11.05'),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}