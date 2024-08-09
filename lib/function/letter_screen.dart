import 'package:flutter/material.dart';

class LetterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Color(0xfff8e9d9),
              title: Center(
                child: Text('편지'),
              ),
            ),
            Center(
              child: Text('편지 화면'),
            ),
          ],
        ),
      ),
    );
  }
}