import 'dart:convert';

import 'package:onder2020/DataAcess/apiSettings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class StablePages {
  String name, link, text, pic;

  StablePages(this.name, this.link, this.text, this.pic);
  StablePages.only({this.name, this.link, this.text, this.pic});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["link"] = link;
    map["text"] = text;
    map["pic"] = pic;

    return map;
  }

  StablePages.fromObject(dynamic o) {
    this.name = o["name"];
    this.link = o["link"];
    this.text = o["text"];
    this.pic = o["pic"];
  }
  factory StablePages.fromJson(Map<String, dynamic> json) {
    return StablePages.only(
        name: json["Title"] as String,
        link: json["URL"] as String,
        text: json["Text"] as String,
        pic: json["Location"] as String);
  }
}

Future<List<StablePages>> fetchStables() async {
  final response = await http.get(pagesApi);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseConnection, response.body);
}

// A function that converts a response body into a List<Photo>.
List<StablePages> parseConnection(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<StablePages>((json) => StablePages.fromJson(json)).toList();
}
