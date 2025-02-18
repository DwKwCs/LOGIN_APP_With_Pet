import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHospital extends StatelessWidget {
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://www.animal.go.kr/front/index.do'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  WebViewHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}