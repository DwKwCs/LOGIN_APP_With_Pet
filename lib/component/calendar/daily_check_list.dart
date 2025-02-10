import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_withpet/component/calendar/daily_memo.dart';
import 'package:login_withpet/database/db_helper.dart';

class DailyCheckList extends StatefulWidget {
  final DateTime selectedDate;

  const DailyCheckList({
    super.key,
    required this.selectedDate,
  });

  @override
  State<DailyCheckList> createState() => _DailyCheckListState();
}

class _DailyCheckListState extends State<DailyCheckList> {
  List<bool> check = [false, false, false];

  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<Map<String, dynamic>?> diaryFuture;

  final List<Map<String, dynamic>> checkItems = [
    {'title': '산책', 'color': Color(0xFFFFDFA9), 'index': 0, 'key': 'Walk'},
    {'title': '배변', 'color': Color(0xFFFFDFA9), 'index': 1, 'key': 'Health'},
    {'title': '약', 'color': Color(0xFFFFDFA9), 'index': 2, 'key': 'Medicine'},
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

  String get formattedDate {
    return DateFormat('M월 d일 EEEE', 'ko_KR').format(widget.selectedDate);
  }

  Future<void> fetchDiary() async {
    String formattedDate = DateFormat('yyyy.MM.dd').format(widget.selectedDate);
    diaryFuture = dbHelper.getDiaryByDate(formattedDate);

    final diary = await diaryFuture;

    if (diary != null) {
      setState(() {
        check[0] = (diary['Walk'] ?? 0) == 1;
        check[1] = (diary['Health'] ?? 0) == 1;
        check[2] = (diary['Medicine'] ?? 0) == 1;
      });
    }
  }

  Future<void> saveDiary(String date, String key, int value) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> existing = await db.query(
      'Diary',
      where: 'Date = ?',
      whereArgs: [date],
    );

    if (existing.isEmpty) {
      // 날짜가 없으면 새로 삽입
      await db.insert('Diary', {
        'Date': date,
        'Walk': 0,
        'Health': 0,
        'Medicine': 0,
        'Sleep': 0,
        'Symptom': '',
        'Memo_title': '',
        'Memo_content': '',
        key: value, // 전달된 키와 값을 반영
      });
    } else {
      // 날짜가 있으면 업데이트
      await db.update(
        'Diary',
        {key: value},
        where: 'Date = ?',
        whereArgs: [date],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: diaryFuture,
      builder: (context, snapshot) {
        final Map<String, dynamic> diary = {
          'Date': widget.selectedDate.toString(),
          'Walk': 0,
          'Health': 0,
          'Medicine': 0,
          'Sleep': 0,
          'Symptom': '',
          'Memo_title': '',
          'Memo_content': '',
          ...(snapshot.data ?? {}), // 기존 데이터가 있으면 덮어쓰기
        };

        return Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 5),
              ...checkItems.map((item) => buildCheckTile(item)).toList(),
              const Divider(color: Color(0xfff9f6f3), thickness: 1.5),
              buildNavigationSleepTile(diary),
              buildNavigationSymptomTile(diary),
              buildNavigationMemoTile(diary),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '저장',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCheckTile(Map<String, dynamic> item) {
    int index = item['index'];
    String key = item['key'];

    return ListTile(
      leading: Icon(Icons.circle, size: 17, color: item['color']),
      title: Text(item['title']),
      trailing: Checkbox(
        checkColor: Colors.white,
        activeColor: Color(0xFFFFC873),
        value: check[index],
        onChanged: (bool? value) async {
          setState(() {
            check[index] = value ?? false;
          });

          String formattedDate = DateFormat('yyyy.MM.dd').format(widget.selectedDate);
          await saveDiary(formattedDate, key, value! ? 1 : 0);
        },
      ),
    );
  }

  Widget buildNavigationSleepTile(Map<String, dynamic>? item) {
    return ListTile(
      shape: const Border(bottom: BorderSide(color: Color(0xfff9f6f3), width: 1.5)),
      leading: Icon(
        Icons.circle,
        size: 17,
        color: const Color(0xFFFEA539),
      ),
      title: Text(
        '수면 중 호흡수',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${item?['Sleep'] ?? 0}회',
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right_rounded),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DailyMemo(
                selectedDate: widget.selectedDate,
                title: (item != null && item.containsKey('title')) ? item['title'] : '수면 중 호흡수',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildNavigationSymptomTile(Map<String, dynamic>? item) {
    return ListTile(
      shape: const Border(bottom: BorderSide(color: Color(0xfff9f6f3), width: 1.5)),
      leading: Icon(
        Icons.circle,
        size: 17,
        color: const Color(0xFFED6D09),
      ),
      title: Text(
        '증상',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right_rounded),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DailyMemo(
                selectedDate: widget.selectedDate,
                title: '증상',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildNavigationMemoTile(Map<String, dynamic>? item) {
    return ListTile(
      shape: const Border(bottom: BorderSide(color: Color(0xfff9f6f3), width: 1.5)),
      leading: Icon(
        Icons.circle,
        size: 17,
        color: const Color(0xFFED6D09),
      ),
      title: Text(
        '일기',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${item?['Memo_title'] ?? ''}',
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right_rounded),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DailyMemo(
                selectedDate: widget.selectedDate,
                title: '일기',
              ),
            ),
          );
        },
      ),
    );
  }
}