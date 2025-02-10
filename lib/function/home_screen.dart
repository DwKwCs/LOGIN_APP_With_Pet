import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:login_withpet/component/home/profile_setting.dart';
import 'package:login_withpet/component/home/home_setting.dart';
import 'package:login_withpet/database/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? imgBytes;
  bool isChecked = false;
  String name = '';
  String comment = '';
  String species = '';
  String date = '';
  String ddate = '';

  Future<void> fetchAllProfiles() async {
    final profiles = await DatabaseHelper().getAllProfiles();

    if (profiles.isNotEmpty) {
      final profile = profiles.first;

      if (mounted) {
        setState(() {
          imgBytes = profile['Img'];
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

  @override
  Widget build(BuildContext context) {
    final textStyleName = const TextStyle(
      height: 2,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );

    final textStyleComment = const TextStyle(
      height: 2,
      fontSize: 20,
    );

    final textStyleDate = const TextStyle(height: 2);

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
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: Image.asset('asset/icons/settings.png'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeSetting()),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Image.asset('asset/icons/pencil.png'),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileSetting(),
                      ),
                    );
                    await fetchAllProfiles();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(110),
              child: CircleAvatar(
                radius: 110,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: imgBytes != null
                      ? Image.memory(
                    imgBytes!,
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red, size: 50),
                  )
                      : Image.asset(
                    'asset/img/basic_profile_img.jpg',
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text('$name (은)는 $species', style: textStyleName),
            Text(comment, style: textStyleComment),
            Text(date, style: textStyleDate),
            Text(
              ddate,
              style: TextStyle(
                height: 2,
                color: isChecked ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}