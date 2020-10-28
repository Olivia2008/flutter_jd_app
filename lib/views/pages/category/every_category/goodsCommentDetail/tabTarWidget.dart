import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/icons/tipIcon.dart';

class TabBarWidget extends StatelessWidget {
  TabBarWidget({@required this.tabController});
  final TabController tabController;

  List titleList = [
    {'id': '', 'title': '商品'},
    {'id': '', 'title': '评价'},
    {'id': '', 'title': '详情'},
    {'id': '', 'title': '推荐'}
  ];
  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (idx) {print('tab bar $idx');},
        controller: tabController,
        indicatorPadding: EdgeInsets.only(top: 3.0),
        indicatorColor: Color(0xfff5503a),
        // indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3.0,
        labelColor: Color(0xfff5503a),
        unselectedLabelColor: Color(0xff333333),
        // indicator: BoxDecoration(
        //   gradient: LinearGradient(colors: [Color(0xfff5503a), Color(0xfffad1cb)], begin: Alignment.centerLeft, end: Alignment.centerRight)
        // ),
        tabs: [Text('商品'), Text('评价'), Text('详情'), Text('推荐')]);
  }
}
