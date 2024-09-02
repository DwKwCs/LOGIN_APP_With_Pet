import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';
import 'package:login_with_pet/component/home/profile_form.dart';

class ProfileSetting extends StatefulWidget {
  final bool isChecked;
  final String name;
  final String comment;
  final String date;
  final String ddate;

  const ProfileSetting({
    required this.isChecked,
    required this.name,
    required this.comment,
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
  late String _date;
  late String _ddate;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
    _name = widget.name;
    _comment = widget.comment;
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
                      'date': _date,
                      'ddate': _ddate,
                    });
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
                _buildProfileRow('이름', _name, 40),
                _buildProfileRow('한마디', _comment, 20),
                _buildProfileRow('종', '리트리버', 56),
                _buildProfileRow('생일', _date, 38),
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
                          color: _isChecked ? Colors.black : Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: 38),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (_isChecked) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileForm(
                                    label: '기일',
                                    hint: _ddate,
                                  ),
                                ),
                              );
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileForm(label: label, hint: hint),
                  ),
                );
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
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
