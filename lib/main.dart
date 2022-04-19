import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

void main() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(HomeViewApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
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
          if (webViewCanGoBack) {
            _controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        // 解决密码框弹出白屏问题，算了。先放一放
        // 方案一
        // child: new SafeArea(
        //       top: true,
        //       child:
        // 方案二
    //     child: Padding(
    //     padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
    //     child: new WebView(
        child: Padding(
              padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
              child: new WebView(
                onWebViewCreated: (WebViewController webviewController) {
                  _controller = webviewController;
                },
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
            ));
  }
}
