import 'package:flutter/material.dart';

class VaribleDecorations extends StatefulWidget {
  VaribleDecorations(
      {Key key,
      this.width,
      this.height,
      @required this.child,
      this.margin,
      this.padding,
      this.fillDefaultColor = const Color(0xffffffff),
      this.fillActiveColor = const Color(0xff409eff),
      this.fillDisabledColor = const Color(0xffc8c9cc),
      this.borderColor = const Color(0xffc8c9cc),
      this.borderRadius,
      this.borderWidth,
      this.boxShadow,
      this.shape,
      this.gradient,
      this.btnEnable = true,
      this.image,
      this.onPress});

  double width;
  double height;
  Widget child;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;
  Color fillDefaultColor; // 默认颜色
  Color fillActiveColor; // 点击时颜色
  Color fillDisabledColor; // 禁色
  Color borderColor; // 边框颜色
  double borderWidth; // 边框宽度
  double borderRadius; // 圆角
  List<BoxShadow> boxShadow; // Container阴影
  BoxShape shape; // 背景形状
  Gradient gradient; // 渐变色
  final VoidCallback onPress; // 点击事件
  bool btnEnable; // 按钮是否禁
  DecorationImage image; // 背景图

  @override
  _VaribleDecorationsState createState() => _VaribleDecorationsState();
}

class _VaribleDecorationsState extends State<VaribleDecorations> {
  Color _curColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.onPress != null && !widget.btnEnable)
      _curColor = widget.fillDisabledColor;
    else
      _curColor = widget.fillDefaultColor;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _curColor = widget.fillDefaultColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.btnEnable && widget.onPress != null) widget.onPress();
        },
        onTapDown: (TapDownDetails details) {
          if (widget.btnEnable && widget.onPress != null) {
            _curColor = widget.fillActiveColor;
            setState(() {});
          }
        },
        onTapUp: (TapUpDetails details) {
          if (widget.btnEnable && widget.onPress != null) {
            _curColor = widget.fillDefaultColor;
            setState(() {});
          }
        },
        onTapCancel: () {
          if (widget.btnEnable && widget.onPress != null) {
            _curColor = widget.fillDefaultColor;
            setState(() {});
          }
        },
        child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin == null ? EdgeInsets.all(0.0) : widget.margin,
            padding: widget.padding == null
                ? EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 10.0)
                : widget.padding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // 背景色
              color: _curColor,
              border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth == null ? 1.0 : widget.borderWidth),
              borderRadius: widget.shape != BoxShape.circle
                  ? BorderRadius.all(Radius.circular(
                      widget.borderRadius == null ? 0.0 : widget.borderRadius))
                  : null,
              // 阴影
              boxShadow: widget.boxShadow,
              gradient: widget.gradient,
              image: widget.image,
              shape: widget.shape == null ? BoxShape.rectangle : widget.shape,
            ),
            child: widget.child));
  }
}
