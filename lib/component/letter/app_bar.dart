import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/color.dart';
import 'package:login_withpet/component/letter/create_letter_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    title: const Text(
      '편지',
      style: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w700, color: colorText),
    ),
    centerTitle: true,
    elevation: 0.0,
    actions: [
      IconButton(
        icon: const Icon(Icons.create_outlined, color: colorSub3),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateLetterScreen())
          );
        },
      )
    ],
  );
}
