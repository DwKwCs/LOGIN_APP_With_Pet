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
  final VoidCallback? onUnsave;

  const GuideCard({
    super.key,
    required this.code,
    required this.title,
    required this.tag,
    required this.percent,
    required this.isSaved,
    this.onUnsave,
  });

  @override
  GuideCardState createState() => GuideCardState();
}

class GuideCardState extends State<GuideCard> {
  late int code;
  late String title;
  late String tag;
  late double percent;
  late bool isSaved;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    code = widget.code;
    title = widget.title;
    tag = widget.tag;
    percent = widget.percent;
    isSaved = widget.isSaved == 1;
  }

  /// ✅ 저장 상태 업데이트
  Future<void> toggleSavedGuide() async {
    setState(() {
      isSaved = !isSaved;
    });

    await dbHelper.updateGuideIsSaved(widget.code, isSaved ? 1 : 0);

    // ✅ 북마크 해제 시 `onUnsave` 콜백 호출하여 `SavedGuideScreen` 갱신
    if (!isSaved && widget.onUnsave != null) {
      widget.onUnsave!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1EDE6), width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GuideContentForm(
                      code: code,
                      title: title,
                      isSaved: isSaved ? 1 : 0,
                    ),
                  ),
                );

                if (result == true) {
                  final updatedGuide = await dbHelper.getGuidesByCode(widget.code);
                  if (updatedGuide != null) {
                    setState(() {
                      percent = updatedGuide['Percent'];
                      isSaved = updatedGuide['IsSaved'] == 1;
                    });
                  }
                }
                else {
                  setState(() {
                    widget.onUnsave!();
                  });
                }
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
                    icon: Icon(
                      isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                      color: isSaved ? Colors.black : Colors.grey,
                    ),
                    iconSize: 30,
                    onPressed: toggleSavedGuide,
                  ),
                ],
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(0, -10),
            child: Row(
              children: [
                LinearPercentIndicator(
                  width: 180.0,
                  lineHeight: 8.0,
                  percent: percent,
                  barRadius: Radius.circular(10),
                  backgroundColor: Colors.grey[300],
                  progressColor: Color(0xFFFFC873),
                ),
                SizedBox(width: 10),
                Text('${(percent * 100).toStringAsFixed(2)}%'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
