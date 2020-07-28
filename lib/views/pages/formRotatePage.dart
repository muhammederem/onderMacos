import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/DbHelper.dart';
import 'package:onder2020/models/forms_model.dart';
import 'package:onder2020/models/stable_pages_model.dart';

import 'package:onder2020/views/pages/formPage.dart';

class FormRotatePage extends StatefulWidget {
  @override
  _RotateState createState() => _RotateState();
}

class _RotateState extends State<FormRotatePage> {
  DbHelper db = new DbHelper();
  List<StablePages> stablePages;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    void goFormPage(Forms forms) async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormPage(forms)));
    }

    return FutureBuilder(
        future: fetchForms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? (GridView.count(
                  padding: EdgeInsets.only(top: 5),
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this would produce 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 Widgets that display their index in the List
                  children: List.generate(snapshot.data.length, (position) {
                    return new Card(
                      color: Colors.black12,
                      margin: new EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(top: 60),
                        onTap: () {
                          goFormPage(snapshot.data[position]);
                        },
                        title: Text(
                          snapshot.data[position].title,
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
                ))
              : Center(child: CircularProgressIndicator());
        });
  }
}
