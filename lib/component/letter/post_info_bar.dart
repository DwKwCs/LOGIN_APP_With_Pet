import 'package:flutter/material.dart';

class PostInfoBar extends StatefulWidget {
  final int postCount;
  final VoidCallback onSort;
  const PostInfoBar({
    super.key,
    required this.postCount,
    required this.onSort,
  });
  @override
  _PostInfoBarState createState() => _PostInfoBarState();
}

class _PostInfoBarState extends State<PostInfoBar> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}