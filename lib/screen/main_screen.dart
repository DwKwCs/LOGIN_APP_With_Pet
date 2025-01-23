import 'package:flutter/material.dart';
import 'package:login_withpet/function/home_screen.dart';
import 'package:login_withpet/function/letter_screen.dart';
import 'package:login_withpet/function/calendar_screen.dart';
import 'package:login_withpet/function/guide_screen.dart';
import 'package:login_withpet/function/info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const LetterScreen(),
    const CalendarScreen(),
    const GuideScreen(),
    const InfoScreen(),
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // 현재 선택된 인덱스만 표시
        children: _pages, // 모든 페이지를 유지
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF4F453C),
            unselectedItemColor: const Color(0xFFCAC7C4),
            showUnselectedLabels: true,
            onTap: _onTapped,
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 0
                      ? Image.asset('asset/icons/paw_dark.png')
                      : Image.asset('asset/icons/paw_light.png'),
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 1
                      ? Image.asset('asset/icons/envelope_dark.png')
                      : Image.asset('asset/icons/envelope_light.png'),
                ),
                label: '편지',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 2
                      ? Image.asset('asset/icons/calendar_dark.png')
                      : Image.asset('asset/icons/calendar_light.png'),
                ),
                label: '캘린더',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: _selectedIndex == 3
                      ? Image.asset('asset/icons/assept-document_dark.png')
                      : Image.asset('asset/icons/assept-document_light.png'),
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
