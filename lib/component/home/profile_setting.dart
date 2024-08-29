import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/home/profile_form.dart';

class ProfileSetting extends StatefulWidget {

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;

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
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('asset/img/basic_profile_img.jpg'),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _buildProfileRow('이름', '김멍멍', 40),
                _buildProfileRow('한마디', '강아지', 20),
                _buildProfileRow('종', '골든 리트리버', 56),
                _buildProfileRow('생일', '2020.11.05', 38),
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
                          color: isChecked ? Colors.black : Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: 38),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if(isChecked == true) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) =>
                                  ProfileForm(label: '기일', hint: '2120',)));
                            }
                          },
                          child: AbsorbPointer(
                            child: Expanded(
                              child: TextFormField(
                                enabled: isChecked ? true : false,
                                decoration: InputDecoration(hintText: '2120', border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        activeColor: PRIMARY_COLOR,
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
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String hint, double labelWidth) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: SUB_COLOR1, width: 1)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(width: labelWidth),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ProfileForm(label: label, hint: hint)));
              },
              child: AbsorbPointer(
                child: Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: hint, border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}