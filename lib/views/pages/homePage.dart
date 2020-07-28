import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/apiSettings.dart';
import 'package:onder2020/views/widgets/carousel_Widget.dart';
import 'package:onder2020/views/widgets/newsWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double a = MediaQuery.of(context).size.width * 0.95;
    return ListView(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: CarouselDeneme()),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
          child: Row(children: <Widget>[
            Expanded(
                child: Divider(
              thickness: 2,
              color: Colors.black26,
            )),
            Text(
              "HABER",
              style: TextStyle(fontSize: 30),
            ),
            Expanded(child: Divider(thickness: 2, color: Colors.black26)),
          ]),
        ),
        NewsWidget(newsApi)
      ],
    );
  }
}
