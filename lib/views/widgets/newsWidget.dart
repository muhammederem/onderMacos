import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/DbHelper.dart';
import 'package:onder2020/models/news_model.dart';
import 'package:onder2020/views/pages/newsReadPage.dart';

import '../../core.dart';

class NewsWidget extends StatefulWidget {
  String category;
  NewsWidget(this.category);
  @override
  _NewsWidgetState createState() => _NewsWidgetState(category);
}

class _NewsWidgetState extends State<NewsWidget> {
  String category;
  _NewsWidgetState(this.category);
  DbHelper dbHelper = new DbHelper();
  List<News> news;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    void goNews(News newss) async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewsReadPage(newss)));
    }

    if (news == null) {
      news = new List<News>();
      getData(category);
    }

    return FutureBuilder(
        future: fetchNews(category),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? (ListView.builder(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int position) {
                    String realDate = returnDate(snapshot.data[position].date);
                    return Card(
                        shadowColor: Colors.grey[50],
                        shape: Border(
                            bottom: BorderSide(color: Colors.red, width: 3)),
                        margin: EdgeInsets.only(top: 15),
                        color: Colors.white,
                        elevation: 16.0,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    goNews(snapshot.data[position]);
                                  },
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 360,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  snapshot.data[position].pic),
                                            ),
                                          ),
                                        )
                                      ])
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 25,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          color: Colors.grey,
                                          child: Text(
                                            realDate.substring(0, 2),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          color: Colors.grey[350],
                                          child: Text(
                                            realDate.substring(3),
                                            style: TextStyle(
                                                color: Colors.grey[800]),
                                          ),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      height: 50,
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data[position].title,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            // Divider(color: Colors.red,thickness: 1.5,)
                          ],
                        ));
                  },
                ))
              : Center(child: CircularProgressIndicator());
        });
  }

  void getData(String category) {
    var database = dbHelper.initilizeDb();
    database.then((result) {
      var newsFuture = dbHelper.getFromNewsTable(category);
      newsFuture.then((data) {
        List<News> allNews = new List<News>();
        count = data.length;
        for (int i = 0; i < count; i++) {
          allNews.add(News.fromObject(data[i]));
        }
        setState(() {
          news = allNews;
          count = count;
        });
      });
    });
  }
}
