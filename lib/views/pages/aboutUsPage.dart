import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import "package:onder2020/models/stable_pages_model.dart";
import 'dart:convert';

class AboutUsPage extends StatefulWidget {
  StablePages stable;
  AboutUsPage(this.stable);
  @override
  _AboutUsPageState createState() => _AboutUsPageState(stable);
}

class _AboutUsPageState extends State<AboutUsPage> {
  StablePages stable;
  _AboutUsPageState(this.stable);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Center(
              child: Text(
                stable.name,
                style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: Html(data: stable.text),
            )
          ],
        ),
      ),
    );
  }
}
