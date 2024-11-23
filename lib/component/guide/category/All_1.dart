import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/guide/guide_card.dart';

class All1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 25),
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
              ),
              child: Text(
                '총 5개의 가이드',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFCAC7C4),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GuideCard(title: '가이드1', tag: '#태그', percent: 0.6),
                  GuideCard(title: '가이드2', tag: '#태그', percent: 0.2),
                  GuideCard(title: '가이드3', tag: '#태그', percent: 0.8),
                  GuideCard(title: '가이드4', tag: '#태그', percent: 0.4),
                  GuideCard(title: '가이드5', tag: '#태그', percent: 1.0),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}