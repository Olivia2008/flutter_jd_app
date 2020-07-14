import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/counter.dart';
import 'package:provide/provide.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MyNumber(),
          MyButton()
        ],
      ),
    );
  }
}


class MyNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text('${counter.count}');
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => Provide.value<Counter>(context).increment(),
      child: Text('Increase'),
    );
  }
}
