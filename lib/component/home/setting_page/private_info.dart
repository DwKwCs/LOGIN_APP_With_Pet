import 'package:flutter/material.dart';

class PrivateInfo extends StatefulWidget {
  const PrivateInfo({super.key});

  @override
  State<PrivateInfo> createState() => _PrivateInfoState();
}

class _PrivateInfoState extends State<PrivateInfo> {
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
            '개인정보 처리방침',
            style: TextStyle(fontWeight: FontWeight.w800)
        ),
        centerTitle: true,
      ),
    );
  }
}