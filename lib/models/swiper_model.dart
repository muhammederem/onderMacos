import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:onder2020/DataAcess/apiSettings.dart';

Future<List<SwiperModel>> fetchSwiper() async {
  final response = await http.get(swipperApi);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseSwiper, response.body);
}

// A function that converts a response body into a List<Photo>.
List<SwiperModel> parseSwiper(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<SwiperModel>((json) => SwiperModel.fromJson(json)).toList();
}

class SwiperModel {
  String pic, title, link, detail;
  SwiperModel(this.pic, this.title, this.link, this.detail);
  SwiperModel.only({this.pic, this.title, this.link, this.detail});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["pic"] = pic;
    map["title"] = title;
    map["link"] = link;
    map["detail"] = detail;

    return map;
  }

  SwiperModel.fromObject(dynamic o) {
    this.title = o["title"];
    this.link = o["link"];
    this.pic = o["pic"];
    this.detail = o["detail"];
  }
  factory SwiperModel.fromJson(Map<String, dynamic> json) {
    return SwiperModel.only(
        pic: json["Photo"] as String,
        title: json["Name"] as String,
        link: json["URL"] as String,
        detail: json["Description"] as String);
  }
}
