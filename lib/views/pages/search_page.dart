import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/counter.dart';
import 'package:provide/provide.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text('${counter.count}');
        },
      )
    );
  }
}
