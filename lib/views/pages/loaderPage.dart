import 'package:flutter/material.dart';
import 'dart:async';

import 'package:onder2020/views/shared/layoutPage.dart';

class LoaderView extends StatefulWidget {
  _LoaderViewState createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, Bouncy(widget: LayoutPage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }
}

class Bouncy extends PageRouteBuilder {
  final Widget widget;

  Bouncy({this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.easeInOutQuart);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
