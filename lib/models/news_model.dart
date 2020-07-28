
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class News {
  String title, pic, link, category, text;
  String date, updateDate;

  News.only(
      {this.text,
      this.title,
      this.pic,
      this.link,
      this.category,
      this.date,
      this.updateDate});
  News(this.text, this.title, this.pic, this.link, this.category, this.date,
      this.updateDate);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["pic"] = pic;
    map["link"] = link;
    map["category"] = category;
    map["date"] = date;
    map["updateDate"] = updateDate;
    map["text"] = text;

    return map;
  }

  News.fromObject(dynamic o) {
    this.title = o["title"];
    this.pic = o["pic"];
    this.link = o["link"];
    this.category = o["category"];
    this.date = o["date"];
    this.updateDate = o["updateDate"];
    this.text = o["text"];
  }
  factory News.fromJson(Map<String, dynamic> json) {
    return News.only(
        title: json["Title"] as String,
        pic: json["Photo"] as String,
        link: json["ShortURL"] as String,
        category: json["NewsType"] as String,
        date: json["DatePublish"] as String,
        updateDate: json["DateChange"] as String,
        text: json["Text"] as String);
  }
}
Future<List<News>> fetchNews( String link) async {
  final response = await http.get(
      link);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseNews, response.body);
}

// A function that converts a response body into a List<Photo>.
List<News> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<News>((json) => News.fromJson(json)).toList();
}
