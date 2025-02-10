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
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),

            // 🛠️ 여기에 `buildScreen` 호출
            Expanded(child: buildScreen(widget.title)),
          ],
        ),
      ),
    );
  }

  Widget buildScreen(String title) {
    switch (title) {
      case '수면 중 호흡수':
        return walk();
      case '증상':
        return health();
      case '일기':
        return medicine();
      default:
        return Container(); // 기본값
    }
  }

  Widget walk() {
    return Center(child: Text('수면 중 호흡수 화면'));
  }

  Widget health() {
    return Center(child: Text('증상 화면'));
  }

  Widget medicine() {
    return Center(child: Text('일기 화면'));
  }
}
