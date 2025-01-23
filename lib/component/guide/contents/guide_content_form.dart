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
  late List<bool> checkStates; // 상태를 저장할 리스트
  bool isSaved = false; // 북마크 상태

  @override
  void initState() {
    super.initState();
    isSaved = widget.isSaved == 1; // 초기 북마크 상태 설정
    fetchContents();
  }

  void fetchContents() {
    contentsFuture = dbHelper.getContents(widget.code);
    contentsFuture.then((contents) {
      setState(() {
        checkStates = List.generate(contents.length, (index) => contents[index]['IsChecked'] == 1);
      });
    });
  }

  void savedGuide() async {
    if (isSaved) {
      await DatabaseHelper().updateGuideIsSaved(widget.code, 1);
      var guides = await DatabaseHelper().getSavedGuides();
      print(guides);
    } else {
      await DatabaseHelper().updateGuideIsSaved(widget.code, 0);
    }
  }

  void updateGuideIsChecked() async {
    for (int i = 0; i < checkStates.length; i++) {
      await DatabaseHelper().updateContentIsChecked(widget.code, i + 1, checkStates[i] ? 1 : 0);
    }
  }

  void updateGuidePercent() async {
    int trueCount = checkStates.where((state) => state).length;
    await DatabaseHelper().updateGuidePercent(widget.code, trueCount / checkStates.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            updateGuideIsChecked();
            updateGuidePercent();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            icon: isSaved
                ? const Icon(Icons.bookmark_rounded, color: Colors.black)
                : const Icon(Icons.bookmark_border_outlined),
            iconSize: 30,
            padding: const EdgeInsets.only(right: 30),
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
                savedGuide();
              });
            },
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
                  side: BorderSide(
                    color: Color(0xFFCAC7C4),
                    width: 1.5,
                  ),
                  activeColor: Color(0xFFFFC873),
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
