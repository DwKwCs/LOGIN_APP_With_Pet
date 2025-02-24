import 'package:flutter/material.dart';
import 'package:login_withpet/component/calendar/daily_memo.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:intl/intl.dart';

class DailyDiary extends StatefulWidget {
  final DateTime selectedDate;

  const DailyDiary({
    super.key,
    required this.selectedDate,
  });

  @override
  State<DailyDiary> createState() => _DailyDiaryState();
}

class _DailyDiaryState extends State<DailyDiary> {
  List<bool> check = [false, false, false];
  String sleep = '0';
  String symptom = '';
  String memoTitle = '';
  String memoContents = '';

  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<Map<String, dynamic>?> diaryFuture;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController sleepController = TextEditingController();

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

        sleep = diary['Sleep'] ?? '0';
        symptom = diary['Symptom'] ?? '';
        memoTitle = diary['Memo_title'] ?? '';
        memoContents = diary['Memo_contents'] ?? '';
      });
    }
  }

  Future<void> saveDiary(String date, List<bool> check) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> existing = await db.query(
      'Diary',
      where: 'Date = ?',
      whereArgs: [date],
    );

    if (existing.isEmpty) {
      await dbHelper.insertDiary({
        'Date': date,
        'Walk': check[0] ? 1 : 0,
        'Health': check[1] ? 1 : 0,
        'Medicine': check[2] ? 1 : 0,
        'Sleep': sleep,
        'Symptom': symptom,
        'Memo_title': memoTitle,
        'Memo_contents': memoContents,
      });
    } else {
      await dbHelper.updateDiary(date, {
        'Date': date,
        'Walk': check[0] ? 1 : 0,
        'Health': check[1] ? 1 : 0,
        'Medicine': check[2] ? 1 : 0,
        'Sleep': sleep,
        'Symptom': symptom,
        'Memo_title': memoTitle,
        'Memo_contents': memoContents,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: diaryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final Map<String, dynamic> diary = {
          'Date': widget.selectedDate.toString(),
          'Walk': 0,
          'Health': 0,
          'Medicine': 0,
          'Sleep': '0',
          'Symptom': '',
          'Memo_title': '',
          'Memo_contents': '',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '취소',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        String formattedDate = DateFormat('yyyy.MM.dd').format(widget.selectedDate);
                        await saveDiary(formattedDate, check);
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        '저장',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildCheckTile(Map<String, dynamic> item) {
    int index = item['index'];

    return ListTile(
      leading: Icon(Icons.circle, size: 17, color: item['color']),
      title: Text(
        item['title'],
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      trailing: Checkbox(
        checkColor: Colors.white,
        activeColor: Color(0xFFFFC873),
        value: check[index],
        onChanged: (bool? value) async {
          setState(() {
            check[index] = value ?? false;
          });
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '수면 중 호흡수',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              '${sleep}회',
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right_rounded),
        onPressed: () => sleepCount(),
      ),
    );
  }

  void sleepCount() {
    if(sleep == '0') {
      sleepController.text = '';
    }
    else {
      sleepController.text = sleep;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('수면 중 호흡수'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: sleepController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '횟수를 입력하세요',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '횟수를 입력하세요.';
                }
                else if(value.trim().isNotEmpty && value.trim()[0] == '0') {
                  return '잘못된 입력 형식입니다.';
                }

                return null;
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        sleep = sleepController.text;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          ],
        );
      },
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
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DailyMemo(
                selectedDate: widget.selectedDate,
                title: '증상',
                symptom: symptom,
              ),
            ),
          );

          if (result != null) symptom = result;

          setState(() {});
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '일기',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              '${memoTitle}',
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right_rounded),
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DailyMemo(
                selectedDate: widget.selectedDate,
                title: '일기',
                memoTitle: memoTitle,
                memoContents: memoContents,
              ),
            ),
          );

          if (result != null) {
            setState(() {
              memoTitle = result['title'];
              memoContents = result['contents'];
            });
          }
        },
      ),
    );
  }
}