import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:login_withpet/component/calendar/daily_diary.dart';
import 'package:intl/intl.dart';
import 'package:login_withpet/database/db_helper.dart';

class MainCalendar extends StatefulWidget {
  const MainCalendar({super.key});

  @override
  State<MainCalendar> createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  late DateTime _selectedDate;
  final DatabaseHelper dbHelper = DatabaseHelper();
  Map<DateTime, List<int>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadDiaryEvents();
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  Future<void> _loadDiaryEvents() async {
    final diaryData = await dbHelper.getAllDiary();
    Map<DateTime, List<int>> eventMap = {};

    for (var diary in diaryData) {
      DateTime date = DateFormat('yyyy.MM.dd').parse(diary['Date']);
      date = DateTime.utc(date.year, date.month, date.day);

      List<int> tempEvents = [0, 0, 0, 0];

      if (diary['Walk'] == 1 && diary['Health'] == 1 && diary['Medicine'] == 1) {
        tempEvents[0] = 1;
      }
      if (diary['Sleep'] != null && diary['Sleep'] != '0') {
        tempEvents[1] = 1;
      }
      if (diary['Symptom'] != null && diary['Symptom'].toString().isNotEmpty) {
        tempEvents[2] = 1;
      }
      if (diary['Memo_title'] != null && diary['Memo_title'].toString().isNotEmpty) {
        tempEvents[3] = 1;
      }

      eventMap[date] = tempEvents;
    }

    setState(() {
      _events = eventMap;
    });
  }

  void _onDayTap(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: false,
      builder: (context) {
        return DailyDiary(selectedDate: _selectedDate);
      },
    ).then((value) async {
      await _loadDiaryEvents(); // ✅ 저장 후 캘린더 데이터 갱신

      if (value == true) {
        // ✅ "저장되었습니다!" 알림 표시 (3초 후 자동 사라짐)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("저장되었습니다!", style: TextStyle(fontSize: 16)),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: 'ko_KR',
          onDaySelected: _onDayTap,
          selectedDayPredicate: (date) =>
          date.year == _selectedDate.year &&
              date.month == _selectedDate.month &&
              date.day == _selectedDate.day,
          firstDay: DateTime(1900, 1, 1),
          lastDay: DateTime(2200, 1, 1),
          focusedDay: _selectedDate,
          eventLoader: (day) => _events[DateTime.utc(day.year, day.month, day.day)] ?? [],
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
          daysOfWeekHeight: 40,
          calendarStyle: CalendarStyle(
            tablePadding: const EdgeInsets.symmetric(horizontal: 5),
            tableBorder: const TableBorder(
              bottom: BorderSide(color: Color(0xfff1ede6)),
              horizontalInside: BorderSide(color: Color(0xfff1ede6)),
              verticalInside: BorderSide(color: Color(0xfff1ede6)),
            ),
            isTodayHighlighted: false,
            selectedTextStyle: TextStyle(
              color: isWeekend(_selectedDate) ? Colors.grey : Colors.black,
            ),
            selectedDecoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/img/orange_circle.png'),
                fit: BoxFit.cover,
              ),
            ),
            weekendTextStyle: const TextStyle(color: Colors.grey),
            cellAlignment: Alignment.topLeft,
            outsideDaysVisible: false,
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            decoration: BoxDecoration(
              color: Color(0xfff8e9d9),
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              List<int> eventList = _events[DateTime.utc(date.year, date.month, date.day)] ?? [0, 0, 0, 0];

              if (eventList.contains(1)) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, size: 9, color: eventList[0] == 1 ? Color(0xFFFFDFA9) : Colors.transparent),
                        const SizedBox(width: 2),
                        Icon(Icons.circle, size: 9, color: eventList[1] == 1 ? Color(0xFFFEA539) : Colors.transparent),
                        const SizedBox(width: 2),
                        Icon(Icons.circle, size: 9, color: eventList[2] == 1 ? Color(0xFFED6D09) : Colors.transparent),
                        const SizedBox(width: 2),
                        Icon(Icons.circle, size: 9, color: eventList[3] == 1 ? Color(0xFFED6D09) : Colors.transparent),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
