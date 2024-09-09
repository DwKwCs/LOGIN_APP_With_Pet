import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: SUB_COLOR2, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -10),
            child: Container(
              height: 30,
              child: Row(
                children: [
                  SizedBox(width: 10),
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -10),
            child: Container(
              child: Row(
                children: [
                  LinearPercentIndicator(
                    width: 180.0,
                    lineHeight: 8.0,
                    percent: widget.percent,
                    barRadius: Radius.circular(10),
                    backgroundColor: Colors.grey[300],
                    progressColor: Colors.orange,
                  ),
                  Text((widget.percent * 100).toString() + '%'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}