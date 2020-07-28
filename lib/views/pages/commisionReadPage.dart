import 'package:flutter/material.dart';

import 'package:onder2020/models/commisions_model.dart';
import 'package:share/share.dart';

class CommisionReadPage extends StatefulWidget {
  CommisionsModel commisions;
  CommisionReadPage(this.commisions);
  @override
  _CommisionReadPageState createState() => _CommisionReadPageState(commisions);
}

class _CommisionReadPageState extends State<CommisionReadPage> {
  CommisionsModel commisions;
  _CommisionReadPageState(this.commisions);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png"),
        actions: <Widget>[
          Spacer(flex: 19),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                Share.share(commisions.link,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              }),
          Spacer(flex: 1),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            ),
            Image.network(commisions.pic),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
                child: Column(
                  children: <Widget>[
                    Title(color: Colors.black, child: Text(commisions.title)),
                    Text(commisions.details)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
