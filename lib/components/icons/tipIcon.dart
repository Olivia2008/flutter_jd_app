import 'package:flutter/material.dart';

class TipIcon extends StatelessWidget {
  TipIcon(
      {this.width,
      this.height,
      this.colorList,
      this.begin,
      this.end,
      this.child,
      this.stops,
      this.alignment,
      this.padding,
      this.margin,
      this.borderRadius});
  final double width;
  final double height;
  final List<Color> colorList;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Widget child;
  final List<double> stops;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width == null ? 3.0 : width,
      // height: height == null ? 20.0 : height,
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
          gradient: LinearGradient(
              stops: stops,
              colors: colorList == null
                  ? [Color(0xfff5503a), Color(0xfffad1cb)]
                  : colorList,
              begin: begin == null ? Alignment.topCenter : begin,
              end: end == null ? Alignment.bottomCenter : end)),
      child: child,
    );
  }
}
