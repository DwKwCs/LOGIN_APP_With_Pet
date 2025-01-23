import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:login_withpet/const/colors.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({super.key, 
    required this.onDaySelected,
    required this.selectedDate,
  });

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr',
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) =>
        date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day,
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2100, 1, 1),
      focusedDay: DateTime.now(),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      daysOfWeekHeight: 40,
      calendarStyle: CalendarStyle(
        tablePadding: EdgeInsets.only(left: 5, right: 5),
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
          color: isWeekend(selectedDate) ? Colors.grey : Colors.black,
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
    );
  }
}