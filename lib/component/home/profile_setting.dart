import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final formKey = GlobalKey<FormState>();

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
                icon: Icon(Icons.close),
              ),
              title: Text(
                '반려동물 프로필 수정',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.check),
                ),
              ],
            ),
            SizedBox(height: 60),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('asset/img/basic_profile_img.jpg'),
            ),
            _buildProfileRow('이름', '김멍멍', 40),
            _buildProfileRow('한마디', '강아지', 20),
            _buildProfileRow('종', '골든 리트리버', 56),
            _buildProfileRow('생일', '2020.11.05', 38),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(width: labelWidth),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(hintText: hint, border: InputBorder.none),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
