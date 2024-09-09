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

class _GuideAllScreenState extends State<GuideAllScreen> {
  List<bool> isSelected = [true, false, false, false];
  final PageController _pageController = PageController(initialPage: 0);

  final List<String> categories = ['전체', '임종', '건강', '음식'];
  final TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  final BorderRadius borderRadius = BorderRadius.circular(80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 15),
            child: ToggleButtons(
              fillColor: Colors.transparent,
              splashColor: Colors.transparent,
              selectedColor: Colors.black,
              renderBorder: false,
              isSelected: isSelected,
              onPressed: _onTogglePressed,
              children: List.generate(categories.length, (index) {
                return _buildToggleButton(index);
              }),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                All1(),
                All2(),
                All3(),
                All4(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(int index) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isSelected[index] ? SUB_COLOR2 : SUB_COLOR1,
        borderRadius: borderRadius,
        border: isSelected[index]
            ? Border.all(width: 1, color: const Color(0xffffdfa9))
            : Border.all(width: 1, color: const Color(0xfff1ede6)),
      ),
      child: Center(
        child: Text(
          categories[index],
          style: textStyle,
        ),
      ),
    );
  }

  void _onTogglePressed(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
    });
  }
}
