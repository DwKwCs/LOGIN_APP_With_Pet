import 'package:flutter/material.dart';
import 'package:login_withpet/database/db_helper.dart';

class GuideContentForm extends StatefulWidget {
  final int code;
  final String title;
  final int isSaved;

  const GuideContentForm({
    super.key,
    required this.code,
    required this.title,
    required this.isSaved,
  });

  @override
  GuideContentFormState createState() => GuideContentFormState();
}

class GuideContentFormState extends State<GuideContentForm> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> contentsFuture;
  List<bool> checkStates = []; // 체크 상태 리스트
  bool isSaved = false; // 북마크 상태

  @override
  void initState() {
    super.initState();
    isSaved = widget.isSaved == 1;
    _fetchContents(); // ✅ 가이드 내용 로드
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// ✅ 가이드 내용 가져오기
  Future<void> _fetchContents() async {
    final contents = await dbHelper.getContents(widget.code);
    setState(() {
      contentsFuture = Future.value(contents); // ✅ Future 재할당
      checkStates = List.generate(contents.length, (index) => contents[index]['IsChecked'] == 1);
    });
  }

  /// ✅ 북마크 저장
  Future<void> _saveGuide() async {
    isSaved = !isSaved;
    await dbHelper.updateGuideIsSaved(widget.code, isSaved ? 1 : 0);
    setState(() {}); // ✅ UI 업데이트
  }

  /// ✅ 체크 상태 업데이트
  Future<void> _updateCheckedState() async {
    for (int i = 0; i < checkStates.length; i++) {
      await dbHelper.updateContentIsChecked(widget.code, i + 1, checkStates[i] ? 1 : 0);
    }
  }

  /// ✅ 진행률 업데이트
  Future<void> _updateGuidePercent() async {
    int trueCount = checkStates.where((state) => state).length;
    double newPercent = trueCount / checkStates.length;
    await dbHelper.updateGuidePercent(widget.code, newPercent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await _updateCheckedState();
            await _updateGuidePercent();
            if(isSaved) {
              Navigator.of(context).pop(true);
            }
            else {
              Navigator.of(context).pop(false);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: isSaved
                ? const Icon(Icons.bookmark_rounded, color: Colors.black)
                : const Icon(Icons.bookmark_border_outlined),
            iconSize: 30,
            padding: const EdgeInsets.only(right: 30),
            highlightColor: Colors.transparent,
            onPressed: _saveGuide,
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: contentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('오류 발생: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('저장된 내용이 없습니다.'));
            }

            final contents = snapshot.data!;
            return ListView.builder(
              itemCount: contents.length,
              itemBuilder: (context, index) {
                final content = contents[index];

                return CheckboxListTile(
                  checkboxScaleFactor: 1.2,
                  title: Text(
                    content['Content'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  side: const BorderSide(color: Color(0xFFCAC7C4), width: 1.5),
                  activeColor: const Color(0xFFFFC873),
                  checkColor: Colors.white,
                  value: checkStates[index],
                  onChanged: (bool? value) {
                    setState(() {
                      checkStates[index] = value ?? false;
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
