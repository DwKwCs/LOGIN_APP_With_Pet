import 'package:flutter/material.dart';
import 'package:login_withpet/database/db_helper.dart';

class WriteLetterScreen extends StatefulWidget {
  final Map<String, dynamic>? letter;

  const WriteLetterScreen({
    super.key,
    this.letter,
  });

  @override
  State<WriteLetterScreen> createState() => _WriteLetterScreenState();
}

class _WriteLetterScreenState extends State<WriteLetterScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper();
  late TextEditingController letterController;
  final int maxLength = 240;
  int isTempLetter = 0;

  @override
  void initState() {
    super.initState();
    // ✅ letter 객체가 있을 경우 해당 내용을 불러오고, 없으면 빈 값 설정
    letterController = TextEditingController(
      text: widget.letter != null ? widget.letter!['Contents'] ?? '' : '',
    );
    if(widget.letter != null) {
      isTempLetter = 1;
    }
  }

  @override
  void dispose() {
    letterController.dispose();
    super.dispose();
  }

  /// ✅ 편지 저장 (정식 저장)
  Future<void> _saveLetter() async {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();

    await dbHelper.insertLetter({
      'Date': now,
      'Contents': letterController.text.trim(),
    });

    if(isTempLetter == 1) {
      await dbHelper.deleteTempLetter(widget.letter!['Date']);
    }

    Navigator.of(context).pop(true);
  }

  /// ✅ 임시 저장 기능 추가
  Future<void> _saveTempLetter() async {
    if (letterController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('내용을 입력하세요!')),
      );
      return;
    }

    if(isTempLetter == 1) {
      final now = DateTime.now().toIso8601String();

      await dbHelper.updateTempLetter(widget.letter!['Date'], {
        'Date': now,
        'Contents': letterController.text.trim(),
      });

      Navigator.of(context).pop();
    }
    else if(isTempLetter == 0) {
      final now = DateTime.now().toIso8601String();

      await dbHelper.insertTempLetter({
        'Date': now,
        'Contents': letterController.text.trim(),
      });

      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, size: 35, color: Colors.black),
        ),
        actions: [
          /// ✅ 임시 저장 버튼
          IconButton(
            icon: Image.asset('asset/icons/temp_save.png', fit: BoxFit.cover, width: 25, height: 25),
            onPressed: _saveTempLetter,
          ),

          /// ✅ 정식 저장 버튼
          IconButton(
            icon: const Icon(Icons.check, size: 35, color: Colors.black),
            onPressed: _saveLetter,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                controller: letterController,
                maxLines: 8,
                maxLength: maxLength,
                decoration: InputDecoration(
                  labelText: '기억하고 싶은 내용이 있나요?',
                  hintText: '기억하고 싶은 내용을 입력하세요',
                  filled: true,
                  fillColor: const Color(0xFFFFF9ED),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.all(12),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '내용을 입력하세요.';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
