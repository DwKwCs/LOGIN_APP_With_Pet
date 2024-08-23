import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class All1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Text(
                '총 5개의 가이드',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GuideCard(title: '가이드1', tag: '#태그'),
                  GuideCard(title: '가이드2', tag: '#태그'),
                  GuideCard(title: '가이드3', tag: '#태그'),
                  GuideCard(title: '가이드4', tag: '#태그'),
                  GuideCard(title: '가이드5', tag: '#태그'),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

class GuideCard extends StatefulWidget {
  final String title;
  final String tag;

  const GuideCard({
    Key? key,
    required this.title,
    required this.tag,
  }) : super(key: key);

  @override
  GuideCardState createState() => GuideCardState();
}

class GuideCardState extends State<GuideCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: SUB_COLOR2, width: 1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0, -20),
            child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  widget.tag,
                  style: TextStyle(fontSize: 16, color: Color(0xffcac7c4)),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.bookmark_outline_rounded),
                  iconSize: 30,
                  isSelected: isSelected,
                  selectedIcon: Icon(Icons.bookmark_rounded, color: Colors.black),
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, -25),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: LinearPercentIndicator(
                width: 180.0,
                lineHeight: 8.0,
                percent: 0.5,
                progressColor: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}