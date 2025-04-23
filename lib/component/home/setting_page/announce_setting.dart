import 'package:flutter/material.dart';

class AnnounceScreen extends StatefulWidget {
  const AnnounceScreen({super.key});

  @override
  State<AnnounceScreen> createState() => _AnnounceScreenState();
}

class _AnnounceScreenState extends State<AnnounceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          '공지사항',
          style: TextStyle(fontWeight: FontWeight.w800)
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '공지사항이 없습니다!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}