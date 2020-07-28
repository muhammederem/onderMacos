import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:onder2020/core.dart';
import 'package:onder2020/models/news_model.dart';
import 'package:share/share.dart';

class NewsReadPage extends StatefulWidget {
  News news;
  NewsReadPage(this.news);
  @override
  _NewsReadPageState createState() => _NewsReadPageState(news);
}

class _NewsReadPageState extends State<NewsReadPage> {
  News news;
  _NewsReadPageState(this.news);
  @override
  Widget build(BuildContext context) {
    String picture = news.pic;

    String realDate = returnDate(news.date, false, true);
    String yil = returnDate(news.date, true, true);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png"),
        actions: <Widget>[
          Spacer(flex: 19),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                Share.share(news.link,
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
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 10, 10)),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                news.title,
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 360,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(news.pic),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.grey,
                          child: Text(
                            realDate.substring(0, 2),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.grey[350],
                          child: Text(
                            realDate.substring(3),
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.grey[300],
                          child: Text(
                            yil.substring(yil.length - 4) + "  ",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ),
                      ]),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 25, 10),
                child: Html(data: news.text))
          ],
        ),
      ),
    );
  }
}
