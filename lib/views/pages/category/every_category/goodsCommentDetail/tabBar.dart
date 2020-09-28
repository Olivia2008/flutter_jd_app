import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';

class TabBarWidget extends StatelessWidget {
  // TabBarWidget(this.showBar);
  // bool showBar;
  List titleList = [
    {'id': '', 'title': '商品'},
    {'id': '', 'title': '评价'},
    {'id': '', 'title': '详情'},
    {'id': '', 'title': '推荐'}
  ];
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsCommentDetailProvide>(
      builder: (BuildContext context, Widget child, data) {
        List<Widget> list = titleList.map<Widget>((item) {
          var idx = titleList.indexOf(item);
          if (data.tabIndex ==
              idx) {
            data
                .changeTabActive(true);
          } else {
            data
                .changeTabActive(false);
          }
          return InkWell(
              onTap: () {
                data
                    .changeTabIndex(idx);
              },
              child: Container(
                decoration:
                    data.tabActive
                        ? BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 5)))
                        : null,
                child: Text(item['title'],
                    style: TextStyle(
                        color: data
                                .tabActive
                            ? Theme.of(context).primaryColor
                            : Color(0xff333333))),
              ));
        }).toList();
        return Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: list));
      },
    );
  }
}
