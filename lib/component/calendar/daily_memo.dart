import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_withpet/database/db_helper.dart';

class DailyMemo extends StatefulWidget {
  final DateTime selectedDate;
  final String title;

  const DailyMemo({
    super.key,
    required this.selectedDate,
    required this.title,
  });

  @override
  State<DailyMemo> createState() => _DailyMemoState();
}

class _DailyMemoState extends State<DailyMemo> {
  final DatabaseHelper dbHelper = DatabaseHelper();

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
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    setState(() {});
                    /*
                    switch(widget.title) {
                      case '수면 중 호흡수':
                        dbHelper.updateDiaryPart()
                      case '증상':
                        return;
                      case '일기':
                        return;
                    }
                    */
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Expanded(child: buildScreen(widget.title)),
          ],
        ),
      ),
    );
  }

  Widget buildScreen(String title) {
    switch (title) {
      case '증상':
        return symptom();
      case '일기':
        return memo();
      default:
        return Center(
          child: Text(
            '텍스트 필드를 불러오는데 실패했습니다.\n다시 시도해주세요.',
          )
        );
    }
  }

  Widget symptom() {
    return Container(
      child: TextField(

      ),
    );
  }

  Widget memo() {
    return Container(child: Text('일기 화면'));
  }
}
