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
                border: Border(bottom: BorderSide(color: PRIMARY_COLOR, width: 3)),
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

class GuideCard extends StatefulWidget {
  final String title;
  final String tag;
  final double percent;

  const GuideCard({
    Key? key,
    required this.title,
    required this.tag,
    required this.percent,
  }) : super(key: key);

  @override
  GuideCardState createState() => GuideCardState();
}

class GuideCardState extends State<GuideCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
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
          Expanded(
            child: Transform.translate(
              offset: Offset(0, -25),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: LinearPercentIndicator(
                  width: 180.0,
                  lineHeight: 8.0,
                  percent: widget.percent,
                  barRadius: Radius.circular(10),
                  backgroundColor: Colors.grey[300],
                  progressColor: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}