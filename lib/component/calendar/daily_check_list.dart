import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_withpet/component/calendar/daily_memo.dart';
import 'package:login_withpet/database/db_helper.dart';

class DailyCheckList extends StatefulWidget {
  final DateTime selectedDate;

  const DailyCheckList({
    required this.selectedDate,
    super.key,
  });

  @override
  State<DailyCheckList> createState() => _DailyCheckListState();
}

class _DailyCheckListState extends State<DailyCheckList> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  Future<Map<String, dynamic>?>? diaryFuture;

  final List<Map<String, dynamic>> checkItems = [
    {'title': '산책', 'color': Color(0xFFFFDFA9), 'key': 'Walk'},
    {'title': '배변', 'color': Color(0xFFFFDFA9), 'key': 'Health'},
    {'title': '약', 'color': Color(0xFFFFDFA9), 'key': 'Medicine'},
  ];

  final List<Map<String, dynamic>> navigationItems = [
    {'title': '수면 중 호흡수', 'color': Color(0xFFFEA539)},
    {'title': '증상', 'color': Color(0xFFED6D09)},
    {'title': '일기', 'color': Color(0xFFED6D09)},
  ];

  @override
  void initState() {
    super.initState();
    fetchDiary();
  }

  Future<void> fetchDiary() async {
    String formattedDate = DateFormat('yyyy.MM.dd').format(widget.selectedDate);
    setState(() {
      diaryFuture = dbHelper.getDiaryByDate(formattedDate);
    });
  }

  Future<void> saveDiary(String date, String key, int value) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> existing = await db.query(
      'Diary',
      where: 'Date = ?',
      whereArgs: [date],
    );

    if (existing.isEmpty) {
      await db.insert('Diary', {
        'Date': date,
        'Walk': 0,
        'Health': 0,
        'Medicine': 0,
        'Sleep': 0,
        'Symptom': '',
        'Memo_title': '',
        'Memo_content': '',
        key: value,
      });
    } else {
      await db.update(
        'Diary',
        {key: value},
        where: 'Date = ?',
        whereArgs: [date],
      );
    }
    fetchDiary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: diaryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final diary = snapshot.data ?? {};

        return Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              ...checkItems.map((item) => buildCheckTile(item, diary)).toList(),
              ...navigationItems.map((item) => buildNavigationTile(item)).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget buildCheckTile(Map<String, dynamic> item, Map<String, dynamic> diary) {
    String key = item['key'];
    bool isChecked = (diary[key] ?? 0) == 1;

    return ListTile(
      leading: Icon(Icons.circle, size: 17, color: item['color']),
      title: Text(item['title']),
      trailing: Checkbox(
        checkColor: Colors.white,
        activeColor: Color(0xFFFFC873),
        value: isChecked,
        onChanged: (bool? value) async {
          if (value == null) return;
          String formattedDate = DateFormat('yyyy.MM.dd').format(widget.selectedDate);
          await saveDiary(formattedDate, key, value ? 1 : 0);

          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }

  Widget buildNavigationTile(Map<String, dynamic> item) {
    return ListTile(
      leading: Icon(Icons.circle, size: 17, color: item['color']),
      title: Text(item['title']),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right_rounded),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DailyMemo(
                selectedDate: widget.selectedDate,
                title: item['title'],
              ),
            ),
          ).then((_) => fetchDiary());
        },
      ),
    );
  }
}
