import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(HomeViewApp());
}

class HomeViewApp extends StatelessWidget {
  const HomeViewApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScopeTestRoute(),
    );
  }
}

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  WillPopScopeTestRouteState createState() {
    return WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          var webViewCanGoBack = await _controller.canGoBack();
          if(webViewCanGoBack) {
            _controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: new SafeArea(
          top: true,
          child: new WebView(
            onWebViewCreated: (WebViewController webviewController) {
              _controller = webviewController;
            },
            initialUrl: "https://eduwap.orangemust.com/",
            javascriptMode: JavascriptMode.unrestricted,
            // JS和Flutter通信的渠道
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
        ));
  }
}
