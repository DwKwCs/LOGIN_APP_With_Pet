import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/view_letter.dart';
import 'package:login_withpet/component/letter/write_letter.dart';
import 'package:login_withpet/component/letter/temp_save_letter.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'package:intl/intl.dart';

class LetterScreen extends StatefulWidget {
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> lettersFuture;
  int count = 0;

  @override
  void initState() {
    super.initState();
    lettersFuture = fetchLetters();
  }

  Future<List<Map<String, dynamic>>> fetchLetters() async {
    final letters = await dbHelper.getAllLetters();

    setState(() {
      count = letters.length;
    });

    return letters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '편지',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Image.asset('asset/icons/temp_save.png', fit: BoxFit.cover, width: 25, height: 25),
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TempSaveLetter()),
              );

              if (result == true) {
                setState(() {
                  lettersFuture = fetchLetters();
                });
              }
            },
          ),
          IconButton(
            icon: Image.asset('asset/icons/pencil.png'),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WriteLetterScreen()),
              ).then((value) {

                if (value == true) {
                  setState(() {
                    lettersFuture = fetchLetters();
                  });

                  // ✅ "저장되었습니다!" 알림 표시 (3초 후 자동 사라짐)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("저장되었습니다!", style: TextStyle(fontSize: 16)),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
                else if(value == false) {
                  // ✅ "임시저장되었습니다!" 알림 표시 (3초 후 자동 사라짐)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("임시저장되었습니다!", style: TextStyle(fontSize: 16)),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              margin: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  const Text('전체', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Text('$count', style: TextStyle(color: Color(0xFFFFC873), fontSize: 20, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: lettersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('저장된 편지가 없습니다.'));
                }

                final letters = snapshot.data!;
                final groupedLetters = _groupByDate(letters);

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: groupedLetters.length,
                  itemBuilder: (context, index) {
                    final date = groupedLetters.keys.elementAt(index);
                    final letterList = groupedLetters[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            date,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...letterList.map((letter) => _buildLetterCard(letter)).toList(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 날짜별로 편지 그룹화
  Map<String, List<Map<String, dynamic>>> _groupByDate(List<Map<String, dynamic>> letters) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var letter in letters) {
      DateTime? parsedDate = DateTime.tryParse(letter['Date'] ?? '');
      if (parsedDate == null) continue;

      String formattedDate = DateFormat('  yyyy년 MM월').format(parsedDate);
      grouped.putIfAbsent(formattedDate, () => []).add(letter);
    }
    return grouped;
  }

  /// 개별 편지 카드 UI
  Widget _buildLetterCard(Map<String, dynamic> letter) {
    DateTime? parsedDate = DateTime.tryParse(letter['Date'] ?? '');
    String formattedDate = parsedDate != null
        ? DateFormat('\nyyyy년 MM월 dd일').format(parsedDate)
        : '날짜 없음';

    return Card(
      color: const Color(0xFFFFF9ED),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(letter['Contents'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(formattedDate, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewLetterScreen(letter: letter)),
          ).then((value) {

            if (value == true) {
              setState(() {
                lettersFuture = fetchLetters();
              });

              // ✅ "삭제되었습니다!" 알림 표시 (3초 후 자동 사라짐)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("삭제되었습니다.", style: TextStyle(fontSize: 16)),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          });
        },
      ),
    );
  }
}
