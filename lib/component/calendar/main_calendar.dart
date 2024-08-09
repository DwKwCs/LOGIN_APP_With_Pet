import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:login_app_test/const/colors.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  MainCalendar({
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr',
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) =>
        date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day,
      firstDay: DateTime(1800, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      focusedDay: DateTime.now(),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      daysOfWeekHeight: 40,
      calendarStyle: const CalendarStyle(
        tableBorder: TableBorder(
          bottom: BorderSide(
            color: Color(0xfff1ede6),
          ),
          horizontalInside: BorderSide(
            color: Color(0xfff1ede6),
          ),
          verticalInside: BorderSide(
            color: Color(0xfff1ede6),
          ),
        ),
        isTodayHighlighted: false,
        selectedTextStyle: TextStyle(
          color: Colors.black,
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xffffc897),
          shape: BoxShape.circle,
        ),
        cellAlignment: Alignment.topLeft,
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        decoration: BoxDecoration(
          color: Color(0xfff8e9d9),
        ),
      ),
    );
  }
}