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
  late TabController _tabController;
  late Future<List<Map<String, dynamic>>> guidesFuture;

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration.zero,
    )..addListener(_onTabChanged);

    guidesFuture = dbHelper.getAllGuides();
  }

  void _onTabChanged() {
    setState(() {
      if (_tabController.index == 0) {
        guidesFuture = dbHelper.getAllGuides();
      } else {
        guidesFuture = dbHelper.getSavedGuides();
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
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
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          _tabBar(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: guidesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("데이터를 불러오는 중 오류 발생"));
                }

                /*
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("가이드 데이터가 없습니다."));
                }
                */

                return _tabBarView(snapshot.data!);
              },
            ),
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
        Tab(text: '모든 가이드'),
        Tab(text: '저장한 가이드'),
      ],
    );
  }

  Widget _tabBarView(List<Map<String, dynamic>> guides) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        GuideAllScreen(guidesFuture: Future.value(guides)),
        SavedGuideScreen(guidesFuture: Future.value(guides.where((guide) => guide['IsSaved'] == 1).toList())),
      ],
    );
  }
}
