import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/home/notification_setting.dart';
import 'package:login_with_pet/component/home/announce_setting.dart';

class HomeSetting extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

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
          '설정',
          style: TextStyle(fontWeight: FontWeight.w800)
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '알림 설정',
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => NotificationScreen()));
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
                SizedBox(width: 10,),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '공지사항',
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => AnnounceScreen()));
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
                SizedBox(width: 10,),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '개인정보 처리방침',
                ),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '서비스 이용약관',
                ),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '로그아웃',
                ),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '계정 탈퇴',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}