import 'package:flutter/material.dart';

class DailyMemo extends StatefulWidget {
  final DateTime selectedDate;
  final String title;
  final String symptom;
  final String memoTitle;
  final String memoContents;

  const DailyMemo({
    super.key,
    required this.selectedDate,
    required this.title,
    this.symptom = '',
    this.memoTitle = '',
    this.memoContents = '',
  });

  @override
  State<DailyMemo> createState() => _DailyMemoState();
}

class _DailyMemoState extends State<DailyMemo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController symptomController;
  late TextEditingController titleController;
  late TextEditingController contentsController;

  @override
  void initState() {
    super.initState();
    symptomController = TextEditingController(text: widget.symptom);
    titleController = TextEditingController(text: widget.memoTitle);
    contentsController = TextEditingController(text: widget.memoContents);
  }

  @override
  void dispose() {
    symptomController.dispose();
    titleController.dispose();
    contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.title == '증상') {
                        Navigator.of(context).pop(symptomController.text);
                      } else if (widget.title == '일기') {
                        Navigator.of(context).pop({
                          'title': titleController.text,
                          'contents': contentsController.text
                        });
                      }
                    }
                  },
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildScreen(widget.title),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScreen(String title) {
    switch (title) {
      case '증상':
        return buildSymptomField();
      case '일기':
        return buildMemoFields();
      default:
        return const Center(
          child: Text(
            '텍스트 필드를 불러오는데 실패했습니다.\n다시 시도해주세요.',
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  Widget buildSymptomField() {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Align(
            alignment: Alignment.topCenter,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              controller: symptomController,
              maxLines: 5,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText: '어떤 증상을 보였나요?',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                contentPadding: EdgeInsets.all(12),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '내용을 입력해주세요.';
                }
                return null;
              },
            ),
          ),
        ),
      )
    );
  }

  Widget buildMemoFields() {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '제목',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: titleController,
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: '오늘의 제목은 무엇인가요?',
                  hintText: '오늘의 제목은 무엇인가요?',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFFFF9ED),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.all(12),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '제목을 입력하세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '내용',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: contentsController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: '기억하고 싶은 내용이 있나요?',
                  hintText: '기억하고 싶은 내용이 있나요?',
                  filled: true,
                  fillColor: Color(0xFFFFF9ED),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '내용을 입력하세요.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
