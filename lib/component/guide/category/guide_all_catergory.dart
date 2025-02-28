import 'package:flutter/material.dart';
import 'package:login_withpet/component/guide/guide_card.dart';
import 'package:login_withpet/database/db_helper.dart';

class GuideAllCatergory extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> guidesFuture;

  const GuideAllCatergory({
    super.key,
    required this.guidesFuture,
  });

  @override
  State<GuideAllCatergory> createState() => _GuideAllCatergoryState();
}

class _GuideAllCatergoryState extends State<GuideAllCatergory> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  Future<List<Map<String, dynamic>>>? guidesFuture;

  @override
  void initState() {
    super.initState();
    _loadGuides();
  }

  void _loadGuides() {
    setState(() {
      guidesFuture = widget.guidesFuture;
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
              return Center(child: Text("데이터를 불러오는 중 오류 발생"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("가이드 데이터가 없습니다."));
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
    );
  }
}
