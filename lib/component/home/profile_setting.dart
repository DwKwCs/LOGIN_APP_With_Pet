import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login_withpet/const/colors.dart';
import 'package:login_withpet/component/home/profile_form.dart';
import 'package:login_withpet/database/db_helper.dart';
import 'dart:typed_data';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final formKey = GlobalKey<FormState>();

  Uint8List? _imgFile;
  bool isChecked = false;
  String name = '';
  String comment = '';
  String species = '';
  String date = '';
  String ddate = '';

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imgFile = File(image.path).readAsBytesSync();
      });
    }
  }

  Future<void> fetchAllProfiles() async {
    final profiles = await DatabaseHelper().getAllProfiles();

    if (profiles.isNotEmpty) {
      final profile = profiles.first;

      if (mounted) {
        setState(() {
          _imgFile = profile['Img'];
          isChecked = (profile['IsChecked'] ?? 0) == 1;
          name = profile['Name'] ?? '';
          comment = profile['Comment'] ?? '';
          species = profile['Species'] ?? '';
          date = profile['Data'] ?? '';
          ddate = profile['Ddate'] ?? '';
        });
      }
    } else {
      print('No profiles found.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllProfiles();
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
                    final Map<String, dynamic> updatedProfile = {
                      'Img': _imgFile, // 이미지 BLOB
                      'IsChecked': isChecked ? 1 : 0,
                      'Name': name, // 이름
                      'Comment': comment, // 한마디
                      'Species': species, // 품종
                      'Data': date, // 생일
                      'Ddate': ddate, // 기일
                    };

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
                    child: ClipOval(
                      child: _imgFile != null
                          ? Image.memory(
                        _imgFile!,
                        fit: BoxFit.cover,
                        width: 140,
                        height: 140,
                      )
                          : const Image(
                        image: AssetImage('asset/img/basic_profile_img.jpg'),
                        fit: BoxFit.cover,
                        width: 140,
                        height: 140,
                      ),
                    ),
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
            const SizedBox(height: 20),
            const Text(
              '프로필 사진 수정하기',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFFEA539), fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  buildProfileField(
                    label: '이   름',
                    hint: 'ex)고영희',
                    value: name,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '이름', hint: 'ex)고영희', text: name),
                        ),
                      );
                      if (result != null) name = result;
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '한마디',
                    hint: 'ex)귀여운 고양이',
                    value: comment,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '한마디', hint: 'ex)귀여운 고양이', text: comment),
                        ),
                      );
                      if (result != null) comment = result;
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '품   종',
                    hint: 'ex)렉돌',
                    value: species,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '품종', hint: 'ex)렉돌', text: species),
                        ),
                      );
                      if (result != null) species = result;
                      setState(() {});
                    },
                  ),
                  buildProfileField(
                    label: '생   일',
                    hint: 'ex)YYYY.MM.DD',
                    value: date,
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileForm(label: '생일', hint: 'ex)YYYY.MM.DD', text: date),
                        ),
                      );
                      if (result != null) date = result;
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
                            color: isChecked ? Colors.black : Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (isChecked) {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileForm(label: '기일', hint: 'ex)YYYY.MM.DD', text: ddate),
                                  ),
                                );
                                if (result != null) ddate = result;
                                setState(() {});
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                enabled: isChecked,
                                decoration: InputDecoration(
                                  hintText: ddate.isEmpty ? 'ex)YYYY.MM.DD' : ddate,
                                  hintStyle: TextStyle(
                                    color: isChecked ? Colors.black : Colors.transparent,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CupertinoSwitch(
                          activeTrackColor: PRIMARY_COLOR,
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = value;
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
