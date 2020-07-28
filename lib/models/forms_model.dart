import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:onder2020/DataAcess/apiSettings.dart';

class Forms {
  String title, src;

  Forms.only({this.title, this.src});

  Forms(this.title, this.src);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["src"] = src;
    map["title"] = title;

    return map;
  }

  Forms.fromObject(dynamic o) {
    this.src = o["src"];
    this.title = o["title"];
    ;
  }

  factory Forms.fromJson(Map<String, dynamic> json) {
    return Forms.only(
      title: json["Title"] as String,
      src: json["Src"] as String,
    );
  }
}

Future<List<Forms>> fetchForms() async {
  final response = await http.get(formsApi);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseForms, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Forms> parseForms(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Forms>((json) => Forms.fromJson(json)).toList();
}
