import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class Deneme extends StatefulWidget {
  @override
  _DenemeState createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  final Completer<WebViewController> _controller=
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated:(WebViewController wvController){
            _controller.complete(wvController);
          },
          initialUrl:
        "https://onder.org.tr/tr/Yayin/tohum-165",)
          );
  }
}
