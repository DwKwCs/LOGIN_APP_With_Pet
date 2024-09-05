import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/home/profile_form.dart';

class ProfileSetting extends StatefulWidget {
  final bool isChecked;
  final String name;
  final String comment;
  final String species;
  final String date;
  final String ddate;

  const ProfileSetting({
    required this.isChecked,
    required this.name,
    required this.comment,
    required this.species,
    required this.date,
    required this.ddate,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final formKey = GlobalKey<FormState>();

  late bool _isChecked;
  late String _name;
  late String _comment;
  late String _species;
  late String _date;
  late String _ddate;

  XFile? file;

  Future<void> _pickImage() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          file = image;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
    _name = widget.name;
    _comment = widget.comment;
    _species = widget.species;
    _date = widget.date;
    _ddate = widget.ddate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
              title: const Text(
                '반려동물 프로필 수정',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      'isChecked': _isChecked,
                      'name': _name,
                      'comment': _comment,
                      'species': _species,
                      'date': _date,
                      'ddate': _ddate,
                    });
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {_pickImage();},
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('asset/img/basic_profile_img.jpg'),
                child: (file != null)
                    ? Image.file(
                  File(file!.path),
                  fit: BoxFit.cover,
                )
                    : const Icon(
                  Icons.image,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        child: const Text(
                          '이   름',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                        ),
                        onPressed: () async {
                          _name = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileForm(label: '이름', hint: _name),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          _name,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        child: const Text(
                          '품   종',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                        ),
                        onPressed: () async {
                         _species = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileForm(label: '품종', hint: _species),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          _species,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        child: const Text(
                          '한마디',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                        ),
                        onPressed: () async {
                          _comment = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileForm(label: '한마디', hint: _comment),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          _comment,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        child: const Text(
                          '생   일',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                        ),
                        onPressed: () async {
                          _date = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileForm(label: '생일', hint: _date),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          _date,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '기일',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _isChecked ? Colors.black : Colors.white,
                        ),
                      ),
                      SizedBox(width: 38),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (_isChecked) {
                              _ddate = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileForm(
                                    label: '기일',
                                    hint: 'ex)YYYY.MM.DD',
                                    text: _ddate,
                                  ),
                                ),
                              );
                              setState(() {});
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              enabled: _isChecked,
                              decoration: InputDecoration(
                                hintText: _ddate,
                                hintStyle: TextStyle(color: _isChecked ? Colors.black : Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        activeColor: PRIMARY_COLOR,
                        value: _isChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _isChecked = value;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}