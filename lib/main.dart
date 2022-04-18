import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(WebViewApp());
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebView(
        initialUrl: "https://eduwap.orangemust.com/",
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          print("onPageStarted $url");
        },
        onPageFinished: (String url) {
          print("onPageFinished $url");
        },
        onWebResourceError: (error) {
          print("${error.description}");
        },
      ),
    );
  }
}
