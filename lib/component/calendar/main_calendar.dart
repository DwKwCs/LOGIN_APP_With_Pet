import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:login_withpet/const/colors.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  String get formattedDate {
    return DateFormat('M월 d일 EEEE', 'ko_KR').format(_selectedDate);
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
      builder: (context) {
        return DailyDiary(selectedDate: _selectedDate);
      },
    );
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
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
          daysOfWeekHeight: 40,
          calendarStyle: CalendarStyle(
            tablePadding: EdgeInsets.symmetric(horizontal: 5),
            tableBorder: TableBorder(
              bottom: BorderSide(color: Color(0xfff1ede6)),
              horizontalInside: BorderSide(color: Color(0xfff1ede6)),
              verticalInside: BorderSide(color: Color(0xfff1ede6)),
            ),
            isTodayHighlighted: false,
            selectedTextStyle: TextStyle(
              color: isWeekend(_selectedDate) ? Colors.grey : Colors.black,
            ),
            selectedDecoration: BoxDecoration(
              color: PRIMARY_COLOR,
              shape: BoxShape.circle,
            ),
            weekendTextStyle: TextStyle(color: Colors.grey),
            cellAlignment: Alignment.topLeft,
            outsideDaysVisible: false,
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            decoration: BoxDecoration(
              color: Color(0xfff8e9d9),
            ),
          ),
        ),
      ],
    );
  }
}