import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/apiSettings.dart';
import 'package:onder2020/views/widgets/newsWidget.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NewsWidget(announcementApi),
    );
  }
}
