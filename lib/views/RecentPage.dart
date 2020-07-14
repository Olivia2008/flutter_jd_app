import 'package:flutter/material.dart';

class RecentPage extends StatefulWidget {
  @override
  _RecentPageState createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Recent Page'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildContent(
              'assets/images/shopping_alpha.png', '新京报', Colors.blueGrey),
          buildContent(
              'assets/images/shopping2_alpha.png', '每日经济新闻', Colors.blue),
          buildContent(
              'assets/images/shopping3_alpha.png', '中国经济周刊', Colors.red),
          buildContent(
              'assets/images/shopping4_alpha.png', 'IT之家', Colors.deepOrange),
        ],
      ),
    );
  }

  Widget buildContent(String imgUrl, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              child: Image.asset(
                imgUrl,
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              backgroundColor: color,
              radius: 25,
            ),
          ),
          Text(
            desc,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
