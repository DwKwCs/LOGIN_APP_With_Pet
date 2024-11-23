import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_with_pet/component/home/profile_setting.dart';
import 'package:login_with_pet/component/home/home_setting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? imgFile;
  bool isChecked = false;
  String name = '';
  String comment = '';
  String species = '';
  String date = '';
  String ddate = '';

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("DB");

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
              title: const Text(
                '홈',
                style: TextStyle(fontWeight: FontWeight.w800)
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: Image.asset('asset/icons/settings.png'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HomeSetting()));
                },
              ),
              actions: [
                IconButton(
                  icon: Image.asset('asset/icons/pencil.png'),
                  onPressed: () async {
                    final result = await Navigator.of(context)
                        .push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileSetting(
                                  imgFile: imgFile,
                                  isChecked: isChecked,
                                  name: name,
                                  comment: comment,
                                  species: species,
                                  date: date,
                                  ddate: ddate,
                                )));
                    setState(() {
                      imgFile = result['imgFile'];
                      isChecked = result['isChecked'];
                      name = result['name'];
                      comment = result['comment'];
                      species = result['species'];
                      date = result['date'];
                      ddate = result['ddate'];
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 110,
                backgroundColor: Colors.white,
                child: (imgFile != null)
                    ? Image.file(
                        File(imgFile!.path),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'asset/img/basic_profile_img.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Text(
              style: TextStyle(height: 2, fontSize: 30, fontWeight: FontWeight.w600),
              name + ' (은)는  ' + species,
            ),
            Text(
              style: TextStyle(height: 2, fontSize: 20),
              comment,
            ),
            Text(
              style: TextStyle(height: 2),
              date,
            ),
            Text(
              style: TextStyle(
                height: 2,
                color: isChecked ? Colors.black : Colors.white,
              ),
              ddate,
            ),
          ],
        ),
      ),
    );
  }
}