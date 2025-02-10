import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/app_bar.dart';

class CreateLetterScreen extends StatelessWidget {
  const CreateLetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, currentScreen: 'write'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16.0)
          ),
          autofocus: true,
          maxLength: 500,
          minLines: 10,
          maxLines: null,
        ),
      ),
    );
  }
}