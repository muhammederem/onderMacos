import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:onder2020/DataAcess/apiSettings.dart';

Future<List<CommisionsModel>> fetchCommisions() async {
  final response = await http.get(commisionApi);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCommision, response.body);
}

// A function that converts a response body into a List<Photo>.
List<CommisionsModel> parseCommision(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<CommisionsModel>((json) => CommisionsModel.fromJson(json))
      .toList();
}

class CommisionsModel {
  String pic, title, details, link;
  int order;

  CommisionsModel.only(
      {this.pic, this.title, this.details, this.link, this.order});

  CommisionsModel(this.pic, this.title, this.details, this.link, this.order);
  CommisionsModel.empty();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["pic"] = pic;
    map["title"] = title;
    map["detail"] = details;
    map["link"] = link;
    map["colOrder"] = order;

    return map;
  }

  CommisionsModel.fromObject(dynamic o) {
    this.pic = o["pic"];
    this.title = o["title"];
    this.details = o["detail"];
    this.link = o["link"];
    this.order = o["colOrder"];
  }

  factory CommisionsModel.fromJson(Map<String, dynamic> json) {
    return CommisionsModel.only(
        pic: json["Logo"] as String,
        title: json["Name"] as String,
        link: json["URL"] as String,
        details: json["Descriptoin"] as String,
        order: json["Order"] as int);
  }
}
