import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login_withpet/const/colors.dart';
import 'package:login_withpet/component/home/profile_form.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'dart:typed_data';

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
    super.key,
  });

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final formKey = GlobalKey<FormState>();

  File? _imgFile;
  late bool _isChecked;
  late String _name;
  late String _comment;
  late String _species;
  late String _date;
  late String _ddate;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imgFile = File(image.path); // Convert XFile to File
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _imgFile = widget.imgFile != null ? File(widget.imgFile!.path) : null;
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color ?? Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: Text(
              value.isEmpty ? hint : value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
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
              title: const Text(
                '반려동물 프로필 수정',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    Uint8List? imageBytes;

                    if (_imgFile != null) {
                      imageBytes = await _imgFile!.readAsBytes();
                    } else {
                      imageBytes = null; // 또는 적절한 기본값
                    }

                    final Map<String, dynamic> updatedProfile = {
                      'Img': imageBytes, // 이미지 BLOB
                      'IsChecked': _isChecked ? 1 : 0,
                      'Name': _name, // 이름
                      'Comment': _comment, // 한마디
                      'Species': _species, // 품종
                      'Data': _date, // 생일
                      'Ddate': _ddate, // 기일
                    };

                    // Profile 테이블 업데이트 또는 삽입
                    final db = DatabaseHelper();
                    await db.updateProfile(1, updatedProfile);

                    // UI 갱신
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage: _imgFile != null
                        ? FileImage(_imgFile!)
                        : const AssetImage('asset/img/basic_profile_img.jpg')
                    as ImageProvider,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
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
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '이름', hint: 'ex)고영희', text: _name),
                        ),
                      );
                      if (result != null) _name = result;
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '품   종',
                    hint: 'ex)렉돌',
                    value: _species,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '품종', hint: 'ex)렉돌', text: _species),
                        ),
                      );
                      if (result != null) _species = result;
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '한마디',
                    hint: 'ex)귀여운 고양이',
                    value: _comment,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '한마디', hint: 'ex)귀여운 고양이', text: _comment),
                        ),
                      );
                      if (result != null) _comment = result;
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '생   일',
                    hint: 'ex)YYYY.MM.DD',
                    value: _date,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '생일', hint: 'ex)YYYY.MM.DD', text: _date),
                        ),
                      );
                      if (result != null) _date = result;
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
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileForm(label: '기일', hint: 'ex)YYYY.MM.DD', text: _ddate),
                                  ),
                                );
                                if (result != null) _ddate = result;
                                setState(() {});
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                enabled: _isChecked,
                                decoration: InputDecoration(
                                  hintText: _ddate.isEmpty ? 'ex)YYYY.MM.DD' : _ddate,
                                  hintStyle: TextStyle(
                                    color: _isChecked ? Colors.black : Colors.transparent,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CupertinoSwitch(
                          activeTrackColor: PRIMARY_COLOR,
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
