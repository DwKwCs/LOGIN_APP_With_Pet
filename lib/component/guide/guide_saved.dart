import 'package:flutter/material.dart';
import 'package:login_withpet/component/guide/guide_card.dart';
import 'package:login_withpet/database/db_helper.dart';

class SavedGuideScreen extends StatefulWidget {
  const SavedGuideScreen({
    super.key,
  });

  @override
  State<SavedGuideScreen> createState() => _SavedGuideScreenState();
}

class _SavedGuideScreenState extends State<SavedGuideScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> guidesFuture;

  @override
  void initState() {
    super.initState();
    fetchGuides();  // 초기 데이터 로드
  }

  // 데이터 로드 함수
  void fetchGuides() {
    setState(() {
      guidesFuture = dbHelper.getSavedGuides();  // 'getSavedGuides' 함수 호출
    });
  }

  // 화면 당기기 갱신 함수
  Future<void> _onRefresh() async {
    fetchGuides();  // 갱신시 데이터 다시 로드
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,  // 화면을 당기면 이 함수가 호출됨
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: guidesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('오류 발생: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFCAC7C4),
                        ),
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

              final guides = snapshot.data!;

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
                    ),
                    child: Text(
                      '총 ${guides.length}개의 가이드',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFCAC7C4),
                      ),
                    ),
                  ),
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
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
