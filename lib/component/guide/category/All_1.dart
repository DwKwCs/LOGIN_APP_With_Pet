import 'package:flutter/material.dart';
import 'package:login_with_pet/const/colors.dart';

class All1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: Text(
                '총 5개의 가이드',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GuideCard(title: '가이드1', tag: '#태그'),
                  GuideCard(title: '가이드2', tag: '#태그'),
                  GuideCard(title: '가이드3', tag: '#태그'),
                  GuideCard(title: '가이드4', tag: '#태그'),
                  GuideCard(title: '가이드5', tag: '#태그'),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

class GuideCard extends StatefulWidget {
  final String title;
  final String tag;

  const GuideCard({
    Key? key,
    required this.title,
    required this.tag,
  }) : super(key: key);

  @override
  GuideCardState createState() => GuideCardState();
}

class GuideCardState extends State<GuideCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: SUB_COLOR2, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                widget.tag,
                style: TextStyle(fontSize: 15, color: Color(0xffcac7c4)),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.bookmark_border),
                isSelected: isSelected,
                selectedIcon: Icon(Icons.bookmark, color: Colors.black),
                onPressed: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
              ),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}