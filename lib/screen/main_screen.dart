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
            selectedItemColor: Color(0xFF4F453C),
            unselectedItemColor: Color(0xFFCAC7C4),
            showUnselectedLabels: true,
            onTap: _onTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 0 ? Image.asset('asset/icons/paw_dark.png') : Image.asset('asset/icons/paw_light.png'),
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 1 ? Image.asset('asset/icons/envelope_dark.png') : Image.asset('asset/icons/envelope_light.png'),
                ),
                label: '편지',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 2 ? Image.asset('asset/icons/calendar_dark.png') : Image.asset('asset/icons/calendar_light.png'),
                ),
                label: '캘린더',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 3 ? Image.asset('asset/icons/assept-document_dark.png') : Image.asset('asset/icons/assept-document_light.png'),
                ),
                label: '가이드',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('asset/icons/search.png'),
                label: '지도',
              ),
            ],
          ),
        ),
      ),
    );
  }
}