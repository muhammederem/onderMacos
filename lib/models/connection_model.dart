import 'dart:convert';

import 'package:onder2020/DataAcess/apiSettings.dart';
import 'package:onder2020/views/pages/connectionPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Connection_Model {
  String name, adress, email, gsm, location;
  int order;

  Connection_Model(this.adress, this.name, this.email, this.gsm, this.order);

  Connection_Model.only(
      {this.adress,
      this.name,
      this.email,
      this.gsm,
      this.order,
      this.location});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["adress"] = adress;
    map["name"] = name;
    map["email"] = email;
    map["colOrder"] = order;
    map["gsm"] = gsm;
    return map;
  }

  Connection_Model.fromObject(dynamic o) {
    this.adress = o["Adress"];
    this.name = o["Name"];
    this.email = o["Email"];
    this.order = o["Order"];
    this.gsm = o["Phone"];
  }

  factory Connection_Model.fromJson(Map<String, dynamic> json) {
    return Connection_Model.only(
        adress: json["Adress"] as String,
        name: json["Name"] as String,
        email: json["Email"] as String,
        location: json["Location"] as String,
        gsm: json["Phone"] as String,
        order: json["Order"] as int);
  }
}

Future<List<Connection_Model>> fetchConnection() async {
  final response = await http.get(campusesApi);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseConnection, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Connection_Model> parseConnection(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<Connection_Model>((json) => Connection_Model.fromJson(json))
      .toList();
}
