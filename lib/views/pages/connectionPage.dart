import 'package:onder2020/DataAcess/DbHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onder2020/models/connection_model.dart';
import 'package:onder2020/views/widgets/connectionWidget.dart';
import 'package:sqflite/sqflite.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnetionPageState createState() => _ConnetionPageState();
}

class _ConnetionPageState extends State<ConnectionPage> {
  DbHelper db = new DbHelper();
  List<Connection_Model> cm;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (cm == null) {
      cm = new List<Connection_Model>();
      getData();
    }

    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
        child: Container(child: ConnectionWidget()),
      ),
    ]));
  }

  void getData() {
    db.initilizeDb().then((result) {
      var pagesFuture = db.getAllFunction("Connection");
      pagesFuture.then((data) {
        List<Connection_Model> pages = new List<Connection_Model>();
        count = data.length;
        for (int i = 0; i < count; i++) {
          pages.add(Connection_Model.fromObject(data[i]));
        }
        setState(() {
          cm = pages;
          count = count;
        });
      });
    });
  }
}
