import 'dart:convert';
import 'dart:typed_data';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onder2020/core.dart';
import 'package:onder2020/models/news_model.dart';
import 'package:onder2020/models/swiper_model.dart';
import 'package:share/share.dart';

class SwipperReadPage extends StatefulWidget {
  SwiperModel swiper;
  SwipperReadPage(this.swiper);
  @override
  _SwipperReadPageState createState() => _SwipperReadPageState(swiper);
}

class _SwipperReadPageState extends State<SwipperReadPage> {
  SwiperModel swiper;
  _SwipperReadPageState(this.swiper);
  @override
  Widget build(BuildContext context) {
    String picture = swiper.pic;

    Uint8List image1;
    image1 = Base64Decoder().convert(picture);
    String text = swiper.detail;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String decoded = stringToBase64.decode(text);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png"),
        actions: <Widget>[
          Spacer(flex: 19),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                Share.share(swiper.link,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              }),
          Spacer(flex: 1),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 20)),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                swiper.title,
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Image.memory(image1),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
                child: Html(data: decoded))
          ],
        ),
      ),
    );
  }
}
