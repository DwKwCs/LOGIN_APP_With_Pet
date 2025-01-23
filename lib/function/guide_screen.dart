import 'package:flutter/material.dart';
import 'package:login_withpet/component/guide/guide_all.dart';
import 'package:login_withpet/component/guide/guide_saved.dart';
import 'package:login_withpet/database/db_helper.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration.zero,
    );
    _tabController!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    setState(() {
      _selectedIndex = _tabController!.index;
    });

    // 탭 변경에 따라 데이터 로드
    if (_selectedIndex == 0) {
      DatabaseHelper().getAllGuides(); // 모든 가이드
    } else if (_selectedIndex == 1) {
      DatabaseHelper().getSavedGuides(); // 저장된 가이드
    }

    setState(() {});
  }

  @override
  void dispose() {
    _tabController!.removeListener(_onTabChanged);
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '가이드',
          style: TextStyle(fontWeight: FontWeight.w800)
        ),
      ),
      body: Column(
        children: [
          _tabBar(),
          Expanded(
            child: _tabBarView(),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      overlayColor: WidgetStateProperty.all<Color>(Colors.white),
      indicatorColor: Colors.black,
      indicatorWeight: 5,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: Color(0xFFCAC7C4),
      controller: _tabController,
      tabs: const [
        Tab(
          text: '모든 가이드',
        ),
        Tab(
          text: '저장한 가이드',
        ),
      ],
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        GuideAllScreen(),
        SavedGuideScreen(),
      ],
    );
  }
}