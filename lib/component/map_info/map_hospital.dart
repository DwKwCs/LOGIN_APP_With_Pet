import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHospital extends StatelessWidget {
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://www.vethonors.com/hospitals/'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  WebViewHospital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}