import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
// import 'package:netease_news/views/model/GoodsDetailModel.dart';
import 'package:netease_news/views/provides/category_goods_detail.dart';
import 'package:netease_news/views/pages/category/every_category/goods_detail/topArea.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:netease_news/views/model/GoodsDetailModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class GoodsDetail extends StatefulWidget {
  GoodsDetail(this.params);
  final Map<String, dynamic> params;
  @override
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
  Color _topBarBCColor;
  @override
  void initState() {
    // TODO: implement initState
    // _topBarBCColor = Color(0xff000000).withOpacity(0.8);
    _topBarBCColor = Color.fromRGBO(0, 0, 0, 1);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodsDetail oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5F5F5),
      appBar: PreferredSize(
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Color(0xffff0000),
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Stack(
        children: <Widget>[
           _topBar(context),
            Column(
              children: <Widget>[
               Text('hello')
              ]
            )
        ],
      ),
    );
  }

  Widget _topBar (BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(left: 20, right: 20),
      color: Color(0xff000000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _topBarLeading(context),
          _topBarTitle(context)
        ],
      ),
    )
    );
  }
  _topBarLeading(context) {
    return Container(
      width: ScreenUtil().setWidth(50),
      color: Color(0xff000000),
      child: IconButton(
        color: Color(0xffffffff),
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
  _topBarTitle(context) {
    return Container(
      width: ScreenUtil().setWidth(100),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(50),
            child: IconButton(
                alignment: Alignment.topCenter,
                color: Color(0xffffffff),
                icon: Icon(
                  Icons.share,
                  size: 22,
                ),
                onPressed: () {
                  print('share');
                }),
          ),
          Container(
            width: ScreenUtil().setWidth(50),
            child: IconButton(
                alignment: Alignment.topCenter,
                color: Color(0xffffffff),
                icon: Icon(
                  Icons.more_horiz,
                  size: 22,
                ),
                onPressed: () {
                  print('more');
                }),
          )
        ],
      )
    );
  }
}
