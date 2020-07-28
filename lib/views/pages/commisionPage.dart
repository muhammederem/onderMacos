import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/DbHelper.dart';
import 'package:onder2020/models/commisions_model.dart';
import 'package:onder2020/views/pages/commisionReadPage.dart';

class CommissionPage extends StatefulWidget {
  @override
  _CommissionPageState createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  @override
  DbHelper db = new DbHelper();
  List<CommisionsModel> commisionPages;
  int count = 0;
  CommisionsModel cm;

  Widget build(BuildContext context) {
    // a****************************************************//
    void goCommisionPages(CommisionsModel commision) async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CommisionReadPage(commision)));
    }
    /******************************************* */

    if (commisionPages == null) {
      commisionPages = new List<CommisionsModel>();
      getData();
    }
    /****************************************************** */

    return FutureBuilder(
        future: fetchCommisions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? (Scaffold(
                  // appBar: AppBar(title:Text("Komisyonlar")),

                  body: GridView.count(
                  padding: EdgeInsets.only(top: 5),
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this would produce 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 Widgets that display their index in the List
                  children: List.generate(snapshot.data.length, (position) {
                    String picture = snapshot.data[position].pic;

                    return new Card(
                      color: Colors.grey[400],
                      margin: new EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ListTile(
                          contentPadding: EdgeInsets.only(top: 60),
                          onTap: () {
                            goCommisionPages(snapshot.data[position]);
                          },
                          title: Image.network(picture)),
                    );
                  }),
                )))
              : Center(child: CircularProgressIndicator());
        });
  }

  void getData() {
    var database = db.initilizeDb();
    database.then((result) {
      var pagesFuture = db.getAllFunction("Commissions");
      pagesFuture.then((data) {
        List<CommisionsModel> pages = new List<CommisionsModel>();
        count = data.length;
        for (int i = 0; i < count; i++) {
          pages.add(CommisionsModel.fromObject(data[i]));
        }
        setState(() {
          commisionPages = pages;
          count = count;
        });
      });
    });
  }
}
