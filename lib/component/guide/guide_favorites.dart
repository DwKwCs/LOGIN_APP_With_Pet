import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:login_with_pet/const/colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavortiesScreenState();
}

class _FavortiesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
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
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: ButtonsTabBar(
            buttonMargin: EdgeInsets.only(top : 20, left: 40),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            splashColor: Colors.transparent,
            backgroundColor: SUB_COLOR2,
            borderWidth: 1,
            borderColor: PRIMARY_COLOR,
            unselectedBorderColor: SUB_COLOR2,
            unselectedBackgroundColor: SUB_COLOR1,
            unselectedLabelStyle: TextStyle(color: Colors.black),
            labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            radius: 80,
            tabs: const [
              Tab(text: 'Text1'),
              Tab(text: 'Text2'),
              Tab(text: 'Text3'),
              Tab(text: 'Text4'),
            ],
          ),
        ),
      ),
    );
  }
}

