import 'package:flutter/material.dart';
import 'package:login_with_pet/component/map_info/map_hospital.dart';
import 'package:login_with_pet/component/map_info/map_funeral_hall.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration.zero,
    );
    tabController!.addListener(
        () => setState(() =>  _selectedIndex = tabController!.index)
    );
  }

  @override
  void dispose() {
    tabController!.dispose();
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
      controller: tabController,
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

  Widget _tabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: tabController,
      children: [
        WebViewHospital(),
        WebViewFuneralHall(),
      ],
    );
  }
}