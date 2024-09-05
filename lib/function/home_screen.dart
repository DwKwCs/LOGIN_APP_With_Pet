import 'package:flutter/material.dart';
import 'package:login_with_pet/component/home/profile_setting.dart';
import 'package:login_with_pet/component/home/home_setting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;
  String name = '고영희';
  String comment = '귀여운 고양이';
  String species = '렉돌';
  String date = '2020.02.02';
  String ddate = '2222.02.02';

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
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HomeSetting()));
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.create_outlined),
                  onPressed: () async {
                    final result = await Navigator.of(context)
                        .push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileSetting(
                                  isChecked: isChecked,
                                  name: name,
                                  comment: comment,
                                  species: species,
                                  date: date,
                                  ddate: ddate,
                                )));
                    setState(() {
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
                backgroundImage: AssetImage('asset/img/basic_profile_img.jpg'),
              ),
            ),
            Text(
              style: TextStyle(height: 2, fontSize: 30, fontWeight: FontWeight.w600),
              name + '(은)는  ' + species,
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