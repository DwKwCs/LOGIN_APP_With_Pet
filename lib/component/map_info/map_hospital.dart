import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalMap extends StatelessWidget {
  const HospitalMap({super.key});

  final String url = "https://www.naver.com";

  /// 구글 크롬에서 열기
  Future<void> openInGoogle(String url) async {
    final Uri googleUri = Uri.parse("googlechrome://navigate?url=$url");

    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri);
    } else {
      // 크롬이 없으면 기본 웹 브라우저에서 열기
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  /// 네이버 앱에서 열기
  Future<void> openInNaver(String url) async {
    final Uri naverUri = Uri.parse("intent://$url#Intent;scheme=https;package=com.nhn.android.search;end;");

    if (await canLaunchUrl(naverUri)) {
      await launchUrl(naverUri);
    } else {
      // 네이버 앱이 없으면 기본 브라우저에서 열기
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
