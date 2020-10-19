import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarWidget extends StatelessWidget {
  ScrollController scrollController;
  TabBarWidget(this.scrollController);
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
                if(data.tabIndex == 1) {
                  scrollController.animateTo(ScreenUtil().setHeight(1690), duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else if (data.tabIndex == 0) {
                  scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                }
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
