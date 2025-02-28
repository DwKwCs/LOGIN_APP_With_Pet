import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/write_letter.dart';
import 'package:login_withpet/database/db_helper.dart';

class TempSaveLetter extends StatefulWidget {
  const TempSaveLetter({super.key});

  @override
  State<TempSaveLetter> createState() => _TempSaveLetterState();
}

class _TempSaveLetterState extends State<TempSaveLetter> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> tempLettersFuture;
  int count = 0;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    tempLettersFuture = fetchTempLetters();
  }

  Future<List<Map<String, dynamic>>> fetchTempLetters() async {
    final tempLetters = await dbHelper.getAllTempLetters();
    setState(() {
      count = tempLetters.length;
    });
    return tempLetters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '임시저장',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, size: 35, color: Colors.black),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 15),
            child: TextButton(
              child: isEditing
                  ? Icon(Icons.check, color: Colors.black, size: 35)
                  : Text(
                '편집',
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  isEditing = !isEditing; // ✅ 편집 모드 토글
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '총 ${count}개',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                const SizedBox(width: 8),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: tempLettersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('데이터를 불러오는 중 오류 발생'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('임시 저장된 편지가 없습니다.'));
                }

                final tempLetters = snapshot.data!;

                return ListView.builder(
                  itemCount: tempLetters.length,
                  itemBuilder: (context, index) {
                    final letter = tempLetters[index];

                    return isEditing
                        ? _buildEditModeItem(letter) // ✅ 편집 모드 UI
                        : _buildNormalModeItem(letter); // ✅ 일반 모드 UI
                  },
                );
              },
            ),
          ),
          if (isEditing) _buildDeleteAllButton(), // ✅ 편집 모드일 때만 전체 삭제 버튼 표시
        ],
      ),
    );
  }

  /// ✅ 일반 모드 UI (임시 저장 편지 목록)
  Widget _buildNormalModeItem(Map<String, dynamic> letter) {
    return Card(
      color: const Color(0xFFFFF9ED),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        title: Text(
          letter['Contents'] ?? '제목 없음',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(letter['Date']),
        trailing: Icon(Icons.arrow_forward_ios, size: 20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WriteLetterScreen(letter: letter),
            ),
          ).then((value) {
            if (value == true) {
              setState(() {
                tempLettersFuture = fetchTempLetters();
              });
            }
          });
        },
      ),
    );
  }

  /// ✅ 편집 모드 UI (삭제 버튼 포함)
  Widget _buildEditModeItem(Map<String, dynamic> letter) {
    return Card(
      color: const Color(0xFFFFF9ED),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        title: Text(
          letter['Contents'] ?? '제목 없음',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(letter['Date']),
        trailing: IconButton(
          icon: Image.asset('asset/icons/delete_forever.png', width: 24, height: 24),
          onPressed: () async {
            await dbHelper.deleteTempLetter(letter['Date']);
            setState(() {
              tempLettersFuture = fetchTempLetters();
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('삭제되었습니다.')),
            );
          },
        ),
      ),
    );
  }

  /// ✅ **전체 삭제 버튼 (화면 맨 아래)**
  Widget _buildDeleteAllButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20), // ✅ 화면 맨 아래에 고정
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFCAC7C4),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: TextButton(
            child: Text(
              '전체 삭제',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            onPressed: () async {
              await dbHelper.deleteAllTempLetter();
              setState(() {
                tempLettersFuture = fetchTempLetters();
                count = 0;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('모든 임시 저장 편지가 삭제되었습니다.')),
              );
            },
          ),
        ),
      ),
    );
  }
}
