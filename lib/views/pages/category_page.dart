import 'package:flutter/material.dart';
import 'category/left_nav.dart';
import 'category/right_part.dart';
class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类页'),
      ),
      body: Container(
        child: Row(
          textDirection: TextDirection.ltr,
          children: <Widget>[LeftNav(), RightPart()],
        ),
      ),
    );
  }
}
