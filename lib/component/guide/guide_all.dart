import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/guide/category/All_1.dart';
import 'package:login_with_pet/component/guide/category/All_2.dart';
import 'package:login_with_pet/component/guide/category/All_3.dart';
import 'package:login_with_pet/component/guide/category/All_4.dart';

class GuideAllScreen extends StatefulWidget {
  const GuideAllScreen({Key? key}) : super(key: key);

  @override
  State<GuideAllScreen> createState() => _GuideAllScreenState();
}

class _GuideAllScreenState extends State<GuideAllScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      animationDuration: Duration.zero,
    );
    _tabController.addListener(
            () => setState(() => _selectedIndex = _tabController.index)
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: TabBar(
              padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
              overlayColor: WidgetStateProperty.all<Color>(Colors.white),
              dividerColor: Colors.transparent,
              controller: _tabController,
              tabs: List.generate(4, (index) => _buildTab(index)),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: SUB_COLOR2,
                border: Border.all(width: 1, color: PRIMARY_COLOR),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                All1(),
                All2(),
                All3(),
                All4(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(int index) {
    final titles = ['전체', '임종', '건강', '음식'];
    return Expanded(
      child: Container(
        height: 45,
        width: 65,
        decoration: _selectedIndex != index ? BoxDecoration(
          color: const Color(0xfff9f6f3),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(width: 1, color: const Color(0xfff1eDe6)),
        ) : null,
        child: Center(
          child: Text(titles[index], style: const TextStyle(fontSize: 17)),
        ),
      ),
    );
  }
}
