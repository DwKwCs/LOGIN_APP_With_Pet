import 'package:flutter/material.dart';
import 'package:login_withpet/component/guide/category/guide_all_catergory.dart';
import 'package:login_withpet/component/guide/category/guide_rainbow_bridget.dart';
import 'package:login_withpet/component/guide/category/guide_health.dart';
import 'package:login_withpet/component/guide/category/guide_diet.dart';
import 'package:login_withpet/database/db_helper.dart';

class GuideAllScreen extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> guidesFuture;

  const GuideAllScreen({super.key, required this.guidesFuture});

  @override
  State<GuideAllScreen> createState() => _GuideAllScreenState();
}

class _GuideAllScreenState extends State<GuideAllScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List<bool> isSelected = [true, false, false, false];
  final List<String> categories = ['전체', '임종', '건강', '음식'];
  final TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  final BorderRadius borderRadius = BorderRadius.circular(80);
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>>? guidesFuture;
  late Future<List<Map<String, dynamic>>> rbGuides;
  late Future<List<Map<String, dynamic>>> healthGuides;
  late Future<List<Map<String, dynamic>>> dietGuides;

  @override
  void initState() {
    super.initState();
    _loadGuides();
  }

  /// ✅ 전체 가이드 로드
  void _loadGuides() {
    setState(() {
      guidesFuture = widget.guidesFuture;
      rbGuides = _filterGuidesByCategory('임종');
      healthGuides = _filterGuidesByCategory('건강');
      dietGuides = _filterGuidesByCategory('음식');
    });
  }

  /// ✅ 특정 카테고리별 가이드 필터링
  Future<List<Map<String, dynamic>>> _filterGuidesByCategory(String category) async {
    final guides = await widget.guidesFuture;
    return guides.where((guide) => guide['Tag'] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 37,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 15, bottom: 10),
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
                GuideAllCatergory(guidesFuture: widget.guidesFuture),
                GuideRainbowBridget(guidesFuture: rbGuides),
                GuideHealth(guidesFuture: healthGuides),
                GuideDiet(guidesFuture: dietGuides),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ 토글 버튼 UI
  Widget _buildToggleButton(int index) {
    return Container(
      width: 83,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected[index] ? Color(0xFFFFF1D4) : Color(0xFFF9F6F3),
        borderRadius: borderRadius,
        border: isSelected[index]
            ? Border.all(width: 1, color: const Color(0xFFFFDFA9))
            : Border.all(width: 1, color: const Color(0xFFF1EDE6)),
      ),
      child: Center(
        child: Text(
          categories[index],
          style: textStyle,
        ),
      ),
    );
  }

  /// ✅ 토글 버튼 변경 시 호출
  void _onTogglePressed(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
      _pageController.jumpToPage(index);
    });
  }

  /// ✅ 페이지 변경 시 호출
  void _onPageChanged(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
    });
  }
}
