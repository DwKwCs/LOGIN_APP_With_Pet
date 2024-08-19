import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';

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
        title: const Text('설정'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width - 70,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '알림 설정',
                ),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                ),
              ),
              IconButton(
                onPressed: () {
                  /*Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ));*/
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width - 70,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  '공지사항',
                ),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                ),
              ),
              IconButton(
                onPressed: () {
                  /*Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ));*/
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              '개인정보 처리방침',
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              '서비스 이용약관',
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              '로그아웃',
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              '계정 탈퇴',
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
            ),
          ),
        ],
      ),
    );
  }
}