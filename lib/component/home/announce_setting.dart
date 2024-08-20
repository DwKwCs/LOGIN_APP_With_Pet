import 'package:flutter/material.dart';

class AnnounceScreen extends StatefulWidget {
  const AnnounceScreen({Key? key}) : super(key: key);

  @override
  State<AnnounceScreen> createState() => _NotificationState();
}

class _NotificationState extends State<AnnounceScreen> {
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
    );
  }
}