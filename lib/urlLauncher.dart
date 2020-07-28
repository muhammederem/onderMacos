import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future urlLaunch(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    return AlertDialog(
      title: Text("Bu sayfa açılamıyor"),
      content: Text("Sayfaya ulaşılamadı"),
      actions: [
        FlatButton(
          child: Text("Tamam"),
          onPressed: () {},
        ),
      ],
    );
  }
}
