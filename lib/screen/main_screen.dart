import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/function/home_screen.dart';
import 'package:login_with_pet/function/letter_screen.dart';
import 'package:login_with_pet/function/calendar_screen.dart';
import 'package:login_with_pet/function/guide_screen.dart';
import 'package:login_with_pet/function/info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() =>_MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tapIndex = [
    HomeScreen(), LetterScreen(), CalendarScreen(), GuideScreen(), InfoScreen()
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tapIndex.elementAt(_selectedIndex),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffe9ecef),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[400],
            showUnselectedLabels: true,
            onTap: _onTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline),
                label: '편지',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_calendar_rounded),
                label: '캘린더',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: '가이드',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.maps_home_work_outlined),
                label: '지도',
              ),
            ],
          ),
        ),
      ),
    );
  }
}