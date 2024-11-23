import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/home/profile_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late XFile? _imgFile;
  late bool _isChecked;
  late String _name;
  late String _comment;
  late String _species;
  late String _date;
  late String _ddate;

  bool isNull(String? str) => str == null || str.isEmpty;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imgFile = image;
      });
    }
  }

  Future<void> addPetProfile(String name, String species, String comment, String birth, String dday) async {
    await _firestore.collection('PetProfiles').add({
      'name': name,
      'species' : species,
      'comment' : comment,
      'birth' : birth,
      'dday' : dday,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getData() {
    return _firestore.collection('PetProfiles').orderBy('timestamp').snapshots();
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

  Widget buildProfileField({
    required String label,
    required String hint,
    required String value,
    required VoidCallback onTap,
    bool enabled = true,
    Color? color,
  }) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color ?? Colors.black),
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              isNull(value) ? hint : value,
              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
              title: const Text('반려동물 프로필 수정', style: TextStyle(fontWeight: FontWeight.w700)),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    addPetProfile(_name, _species, _comment, _date, _ddate);
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
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: _imgFile != null
                    ? Image.file(File(_imgFile!.path), fit: BoxFit.cover)
                    : Image.asset('asset/img/basic_profile_img.jpg', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  buildProfileField(
                    label: '이   름',
                    hint: 'ex)고영희',
                    value: _name,
                    onTap: () async {
                      _name = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileForm(label: '이름', hint: 'ex)고영희', text: _name)),
                      );
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '품   종',
                    hint: 'ex)렉돌',
                    value: _species,
                    onTap: () async {
                      _species = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileForm(label: '품종', hint: 'ex)렉돌', text: _species)),
                      );
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '한마디',
                    hint: 'ex)귀여운 고양이',
                    value: _comment,
                    onTap: () async {
                      _comment = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileForm(label: '한마디', hint: 'ex)귀여운 고양이', text: _comment)),
                      );
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '생   일',
                    hint: 'ex)YYYY.MM.DD',
                    value: _date,
                    onTap: () async {
                      _date = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileForm(label: '생일', hint: 'ex)YYYY.MM.DD', text: _date)),
                      );
                      setState(() {});
                    },
                  ),
                  Container(
                    height: 70,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 13),
                        Text(
                          '기   일',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: _isChecked ? Colors.black : Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (_isChecked) {
                                _ddate = await Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => ProfileForm(label: '기일', hint: 'ex)YYYY.MM.DD', text: _ddate)),
                                );
                                setState(() {});
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                enabled: _isChecked,
                                decoration: InputDecoration(
                                  hintText: isNull(_ddate) ? 'ex)YYYY.MM.DD' : _ddate,
                                  hintStyle: TextStyle(color: _isChecked ? Colors.black : Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}
