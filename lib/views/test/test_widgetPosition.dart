import 'package:flutter/material.dart';

class TestPosition extends StatefulWidget {
  @override
  _TestPositionState createState() => _TestPositionState();
}

class _TestPositionState extends State<TestPosition> {
  @override
  void initState() {
    //监听Widget是否绘制完毕
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _afterLayout(_) {
    _getPositions();
  }

  _getPositions() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final positionsRed = renderBoxRed.localToGlobal(Offset(0, 0));
    print("positions of red:$positionsRed");
    final RenderBox renderBoxBlue = _keyBlue.currentContext.findRenderObject();
    final positionsBlue = renderBoxBlue.localToGlobal(Offset(0, 0));
    print("positions of Blue:$positionsBlue");
    final RenderBox renderBoxAmber =
    _keyAmber.currentContext.findRenderObject();
    final positionsAmber = renderBoxAmber.localToGlobal(Offset(0, 0));
    print("positions of Amber:$positionsAmber");
  }

  GlobalKey _keyRed = GlobalKey();
  GlobalKey _keyBlue = GlobalKey();
  GlobalKey _keyAmber = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          key: _keyRed,
          flex: 1,
          child: Container(
            color: Colors.red,
          ),
        ),
        Flexible(
          key: _keyBlue,
          child: Container(
            color: Colors.blue,
          ),
          flex: 2,
        ),
        //该Widget是居中显示的
        Container(
          key: _keyAmber,
          width: 300,
          height: 200,
          color: Colors.amber,
        ),
      ],
    );
  }
}