import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:login_withpet/component/guide/contents/guide_content_form.dart';

class GuideCard extends StatefulWidget {
  final int code;
  final String title;
  final String tag;
  final double percent;
  final int isSaved;

  const GuideCard({
    super.key,
    required this.code,
    required this.title,
    required this.tag,
    required this.percent,
    required this.isSaved,
  });

  @override
  GuideCardState createState() => GuideCardState();
}

class GuideCardState extends State<GuideCard> {
  late bool isSaved;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    isSaved = widget.isSaved == 1;
  }

  void savedGuide() async {
    if (isSaved) {
      await DatabaseHelper().updateGuideIsSaved(widget.code, 1);
      var guides = await DatabaseHelper().getSavedGuides();
      print(guides);
    } else {
      await DatabaseHelper().updateGuideIsSaved(widget.code, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1EDE6), width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GuideContentForm(
                    code: widget.code,
                    title: widget.title,
                    isSaved: widget.isSaved,
                  )),
                );
              },
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -10),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    '#${widget.tag}',
                    style: TextStyle(
                      fontSize: 16,
                      color: isSaved ? const Color(0xffb69c81) : const Color(0xffcac7c4),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.bookmark_outline_rounded),
                    iconSize: 30,
                    isSelected: isSaved,
                    selectedIcon: Icon(Icons.bookmark_rounded, color: Colors.black),
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        isSaved = !isSaved;
                        savedGuide();
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
                    progressColor: Color(0xFFFFC873),
                  ),
                  Text('${(widget.percent * 100).toStringAsFixed(2)}%'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}