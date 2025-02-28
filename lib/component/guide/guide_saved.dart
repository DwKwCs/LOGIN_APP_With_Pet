import 'package:flutter/material.dart';
import 'package:login_withpet/component/guide/guide_card.dart';
import 'package:login_withpet/database/db_helper.dart';

class SavedGuideScreen extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> guidesFuture;

  const SavedGuideScreen({super.key, required this.guidesFuture});

  @override
  State<SavedGuideScreen> createState() => _SavedGuideScreenState();
}

class _SavedGuideScreenState extends State<SavedGuideScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> guidesFuture;

  @override
  void initState() {
    super.initState();
    guidesFuture = widget.guidesFuture; // 초기 데이터 설정
  }

  /// ✅ 저장된 가이드 다시 불러오기
  Future<void> _loadSavedGuides() async {
    setState(() {
      guidesFuture = dbHelper.getSavedGuides();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: guidesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('오류 발생: ${snapshot.error}'));
            }

            final guides = snapshot.data ?? [];

            return guides.isEmpty
                ? _buildEmptyView()
                : Column(
              children: [
                _buildHeader(guides.length),
                Expanded(
                  child: ListView.builder(
                    itemCount: guides.length,
                    itemBuilder: (context, index) {
                      final guide = guides[index];

                      return GuideCard(
                        code: guide['Code'],
                        title: guide['Title'],
                        tag: guide['Tag'],
                        percent: guide['Percent'],
                        isSaved: guide['IsSaved'],
                        onUnsave: _loadSavedGuides, // ✅ 북마크 해제 시 리스트 새로고침
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// ✅ 가이드 개수 표시 헤더
  Widget _buildHeader(int count) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
      ),
      child: Text(
        '총 $count개의 가이드',
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFCAC7C4),
        ),
      ),
    );
  }

  /// ✅ 가이드가 없을 때 빈 화면 UI
  Widget _buildEmptyView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8, left: 25),
          height: 30,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
          ),
          child: const Text(
            '총 0개의 가이드',
            style: TextStyle(fontSize: 16, color: Color(0xFFCAC7C4)),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '저장된 가이드가 없습니다.\n가이드를 추가해보세요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
