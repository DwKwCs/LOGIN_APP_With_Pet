import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FuneralHallMap extends StatelessWidget {
  const FuneralHallMap({super.key});

  final String url = "https://www.naver.com"; // 열고 싶은 URL

  Future<void> openInGoogle(String url) async {
    final googleAppUrl = "googlechrome://navigate?url=$url";

    if (await canLaunchUrl(Uri.parse(googleAppUrl))) {
      await launchUrl(Uri.parse(googleAppUrl));
    } else {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> openInNaver(String url) async {
    final naverAppUrl = "naversearchapp://inappbrowser?url=$url";

    if (await canLaunchUrl(Uri.parse(naverAppUrl))) {
      await launchUrl(Uri.parse(naverAppUrl));
    } else {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("웹 페이지 열기"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => openInGoogle(url),
              child: Text("구글 앱에서 열기"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => openInNaver(url),
              child: Text("네이버 앱에서 열기"),
            ),
          ],
        ),
      ),
    );
  }
}
