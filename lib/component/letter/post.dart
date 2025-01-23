import 'package:flutter/material.dart';

import 'package:login_withpet/component/letter/color.dart';

class Post extends StatelessWidget {
  final String postData;
  final DateTime postDate;
  const Post({super.key, required this.postData, required this.postDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.0,
      height: 138.0,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: colorPrimaryVar),
      child: Row(
        children: [
          Text(postData),
          Text(postDate.toString()),
        ],
      ),
    );
  }
}
