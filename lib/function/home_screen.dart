import 'package:flutter/material.dart';
import 'package:login_with_pet/component/home/profile_setting.dart';
import 'package:login_with_pet/component/home/home_setting.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                '홈',
                style: TextStyle(fontWeight: FontWeight.w800)
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HomeSetting()));
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.create_outlined),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => ProfileSetting()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 110,
              backgroundImage: AssetImage('asset/img/basic_profile_img.jpg'),
            ),
            Text(
              style: TextStyle(
                height: 2,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              '이름',
            ),
            Text(
              style: TextStyle(
                height: 2,
                fontSize: 20,
              ),
              '한마디',
            ),
            Text(
              style: TextStyle(
                height: 2,
              ),
              '날짜',
            ),
          ],
        ),
      ),
    );
  }
}