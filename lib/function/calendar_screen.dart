import 'package:flutter/material.dart';
import 'package:login_with_pet/component/calendar/main_calendar.dart';
import 'package:login_with_pet/component/calendar/today_banner.dart';
import 'package:login_with_pet/component/calendar/schedule_card.dart';
import 'package:login_with_pet/component/calendar/schedule_bottom_sheet.dart';
import 'package:login_with_pet/const/colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}