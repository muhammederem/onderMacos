import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onder2020/models/forms_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FormPage extends StatefulWidget {
  Forms form;
  FormPage(this.form);
  @override
  _FormPageState createState() => _FormPageState(form);
}

class _FormPageState extends State<FormPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  Forms form;
  _FormPageState(this.form);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController wvController) {
        _controller.complete(wvController);
      },
      initialUrl: form.src,
    ));
  }
}
