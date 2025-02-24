import 'package:flutter/material.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:intl/intl.dart';

class ViewLetterScreen extends StatefulWidget {
  final Map<String, dynamic> letter;

  const ViewLetterScreen({
    super.key,
    required this.letter,
  });

  @override
  State<ViewLetterScreen> createState() => _ViewLetterScreenState();
}

class _ViewLetterScreenState extends State<ViewLetterScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = _formatDate(widget.letter['Date']);
  }

  /// ✅ 날짜 변환 함수 (올바른 형식으로 변환)
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "날짜 없음";

    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('yyyy년 MM월 dd일').format(date);
    } catch (e) {
      debugPrint("❌ 날짜 변환 오류: $e"); // 로그 출력
      return "잘못된 날짜";
    }
  }

  /// ✅ 삭제 함수
  Future<void> _deleteLetter() async {
    String? date = widget.letter['Date']; // 기본 키(PK)인 `Date` 사용
    if (date == null || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("삭제할 데이터를 찾을 수 없습니다.")),
      );
      return;
    }

    await dbHelper.deleteLetter(date);

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: IconButton(
          icon: Image.asset('asset/icons/delete_forever.png', width: 24, height: 24),
          onPressed: _deleteLetter,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, size: 35, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Image.asset('asset/icons/pencil.png', width: 24, height: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("편지 수정 기능은 아직 구현되지 않았습니다.")),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.height / 2,
                height: MediaQuery.of(context).size.height / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9ED),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  widget.letter['Contents'] ?? '내용 없음',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5E0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    textAlign: TextAlign.end,
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
