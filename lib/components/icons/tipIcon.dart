import 'package:flutter/material.dart';

class TipIcon extends StatelessWidget {
  TipIcon({this.width, this.height, this.colorList, this.begin, this.end});
  final double width;
  final double height;
  final List<Color> colorList;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: colorList, begin: begin, end: end)),
    );
  }
}
