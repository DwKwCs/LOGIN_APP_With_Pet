import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/home/profile_form.dart';

class ProfileSetting extends StatefulWidget {
  final XFile? imgFile;
  final bool isChecked;
  final String name;
  final String comment;
  final String species;
  final String date;
  final String ddate;

  const ProfileSetting({
    required this.imgFile,
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

  late XFile? _imgFile;
  late bool _isChecked;
  late String _name;
  late String _comment;
  late String _species;
  late String _date;
  late String _ddate;

  bool isNull(String? str) {
    return str == '';
  }

  Future<void> _pickImage() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          _imgFile = image;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _imgFile = widget.imgFile;
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
                      'imgFile': _imgFile,
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
                child: (_imgFile != null)
                    ? Image.file(
                        File(_imgFile!.path),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'asset/img/basic_profile_img.jpg', // 선택된 파일이 없을 때 사용할 이미지
                        fit: BoxFit.cover,
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
                                  ProfileForm(label: '이름', hint: 'ex)고영희', text: _name),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          isNull(_name) ? 'ex)고영희' : _name,
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
                              builder: (context) => ProfileForm(label: '품종', hint: 'ex)렉돌', text: _species),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          isNull(_species) ? 'ex)렉돌' : _species,
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
                              builder: (context) => ProfileForm(label: '한마디', hint: 'ex)귀여운 고양이', text: _comment),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          isNull(_comment) ? 'ex)귀여운 고양이' : _comment,
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
                              builder: (context) => ProfileForm(label: '생일', hint: 'ex)YYYY.MM.DD', text: _date),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          isNull(_date) ? 'ex)YYYY.MM.DD' : _date,
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
                      SizedBox(width: 13),
                      Text(
                        '기   일',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _isChecked ? Colors.black : Colors.white,
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        width: 200,
                        child: GestureDetector(
                          onTap: () async {
                            if (_isChecked) {
                              _ddate = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileForm(
                                    label: '기일',
                                    hint: 'ex)YYYY.MM.DD',
                                    text: _ddate
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
                                hintText: isNull(_ddate) ? 'ex)YYYY.MM.DD' : _ddate,
                                hintStyle: TextStyle(color: _isChecked ? Colors.black : Colors.white, fontWeight: FontWeight.w400),
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