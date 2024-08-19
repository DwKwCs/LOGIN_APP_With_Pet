import 'package:flutter/material.dart';

class LetterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              title: Text('편지'),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.create),
                onPressed: () {},
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