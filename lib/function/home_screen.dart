import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Color(0xfff8e9d9),
              title: Center(
                child: Text('홈'),
              ),
            ),
            Center(
              child: Text('홈 화면'),
            ),
          ],
        ),
      ),
    );
  }
}