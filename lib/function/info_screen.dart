import 'package:flutter/material.dart';
import 'package:login_app_test/component/map_info/map_hospital.dart';
import 'package:login_app_test/component/map_info/map_funeral_hall.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this,
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
          '지도',
        ),
      ),
      body: SizedBox(
        height: 50,
        child: _tabBar(),
      ),
    );
  }

  Widget _tabBar() {
    TabBarView(
      children: [

      ],
    );
    return TabBar(
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
          text: '병원',
        ),
        Tab(
          text: '장례식장',
        ),
      ],
    );
  }
}