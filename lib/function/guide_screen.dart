import 'package:flutter/material.dart';
import 'package:login_with_pet/component/guide/guide_all.dart';
import 'package:login_with_pet/component/guide/guide_favorites.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({Key? key}) : super(key: key);

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
    _tabController!.addListener(
            () => setState(() =>  _selectedIndex = _tabController!.index)
    );
  }

  @override
  void dispose() {
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
        FavoritesScreen(),
      ],
    );
  }
}