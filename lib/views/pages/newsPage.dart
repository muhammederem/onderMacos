import 'package:flutter/material.dart';
import 'package:onder2020/DataAcess/apiSettings.dart';
import 'package:onder2020/views/widgets/newsWidget.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: NewsWidget(newsApi));
  }
}
