import 'package:flutter/material.dart';
import 'package:login_with_pet/component/map_info/map_hospital.dart';
import 'package:login_with_pet/component/map_info/map_funeral_hall.dart';

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
        ),
      ),
      body: SizedBox(
        height: 50,
        child: _tabBar(),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      overlayColor: MaterialStateProperty.all<Color>(Colors.white),
      indicatorColor: Colors.black,
      indicatorWeight: 5,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: Colors.grey[400],
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
}