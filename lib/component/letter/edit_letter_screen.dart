import 'package:flutter/material.dart';
import 'package:login_withpet/component/letter/app_bar.dart';
import 'package:login_withpet/component/letter/color.dart';

class EditPostScreen extends StatelessWidget {
  final String postData;
  final String postDate;

  const EditPostScreen({super.key, required this.postData, required this.postDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, currentScreen: 'edit'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Container(
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(
                color: colorPrimaryVar,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height * 0.85,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0)),
                initialValue: postData,
                autofocus: true,
                maxLength: 500,
                minLines: 10,
                maxLines: null,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
