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
  TabController? _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      animationDuration: Duration.zero,
    );
    _tabController!.addListener(
            () => setState(() => _selectedIndex = _tabController!.index)
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
      body: Column(
        children: [
          TabBar(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            overlayColor: WidgetStateProperty.all<Color>(Colors.white),
            dividerColor: Colors.transparent,
            controller: _tabController,
            tabs: [
              Tab(
                child: Container(
                  child: Center(
                      child: Text('전체', style: TextStyle(fontSize: 16))
                  ),
                  decoration: _selectedIndex != 0 ? BoxDecoration(
                    color: Color(0xfff9f6f3),
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(width: 1, color: Color(0xfff1eDe6)),
                  ) : null,
                ),
              ),
              Tab(
                child: Container(
                  child: Center(
                      child: Text('임종', style: TextStyle(fontSize: 16))
                  ),
                  decoration: _selectedIndex != 1 ? BoxDecoration(
                    color: Color(0xfff9f6f3),
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(width: 1, color: Color(0xfff1eDe6)),
                  ) : null,
                ),
              ),
              Tab(
                child: Container(
                  child: Center(
                      child: Text('건강', style: TextStyle(fontSize: 16))
                  ),
                  decoration: _selectedIndex != 2 ? BoxDecoration(
                    color: Color(0xfff9f6f3),
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(width: 1, color: Color(0xfff1eDe6)),
                  ) : null,
                ),
              ),
              Tab(
                child: Container(
                  child: Center(
                      child: Text('음식', style: TextStyle(fontSize: 16))
                  ),
                  decoration: _selectedIndex != 3 ? BoxDecoration(
                    color: Color(0xfff9f6f3),
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(width: 1, color: Color(0xfff1eDe6)),
                  ) : null,
                ),
              ),
            ],
            unselectedLabelColor: Colors.black,
            labelColor: Colors.black,
            indicatorPadding: EdgeInsets.only(left: 5, right: 5),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: SUB_COLOR2,
              border: Border.all(width: 1, color: PRIMARY_COLOR),
            ),
          ),
          Expanded(
            child: _tabBarView(),
          )
        ],
      ),
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        All1(),
        All2(),
        All3(),
        All4(),
      ],
    );
  }
}