import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/DbHelper.dart';
import 'package:onder2020/models/swiper_model.dart';
import 'package:onder2020/views/pages/swipperReadPage.dart';

import '../../urlLauncher.dart';

class CarouselDeneme extends StatefulWidget {
  @override
  _CarouselDenemeState createState() => _CarouselDenemeState();
}

class _CarouselDenemeState extends State<CarouselDeneme> {
  DbHelper db = new DbHelper();
  List<SwiperModel> swiperModel;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    void goSwiperPages(List<SwiperModel> swipper, int position) async {
      if (swipper[position].link.substring(0) == "/") {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SwipperReadPage(swipper[position])));
      } else {
        await urlLaunch(swiperModel[position].link);
      }
    }

    return FutureBuilder(
        future: fetchSwiper(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? (CarouselSlider.builder(
                  autoPlay: true,
                  viewportFraction: 0.90,
                  height: MediaQuery.of(context).size.height * 0.30,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      child: ListTile(
                          onTap: () {
                            goSwiperPages(swiperModel, position);
                          },
                          title: Stack(children: <Widget>[
                            (Image.network("https://onder.org.tr/img/" +
                                snapshot.data[position].pic)),
                            Builder(builder: (
                              context,
                            ) {
                              if (snapshot.data[position].title == null) {
                                return Center();
                              } else {
                                return Positioned(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Center(
                                        child:
                                            Text(snapshot.data[position].title),
                                      ),
                                      color: Colors.grey[300].withOpacity(0.4),
                                    ));
                              }
                            }),
                          ])),
                    );
                  }))
              : Center(child: CircularProgressIndicator());
        });
  }

  void getData() {
    db.initilizeDb().then((result) {
      var pagesFuture = db.getAllFunction("Swiper");
      pagesFuture.then((data) {
        List<SwiperModel> pages = new List<SwiperModel>();
        count = data.length;
        for (int i = 0; i < count; i++) {
          pages.add(SwiperModel.fromObject(data[i]));
        }
        setState(() {
          swiperModel = pages;
          count = count;
        });
      });
    });
  }
}
