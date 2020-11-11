import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/icons/tipIcon.dart';

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
    var _data = Provide.value<GoodsCommentDetailProvide>(context);
    var _goodsInfo = _data.goodsInfo;
    if(_goodsInfo != null) {
      return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(titleList.length, (index) {
              if (_data.tabIndex == index) {
                _data.changeTabActive(true);
              } else {
                _data.changeTabActive(false);
              }
              return InkWell(
                  onTap: () {
                    _data.changeTabIndex(index);
                    if (_data.tabIndex == 1) {
                      scrollController.animateTo(ScreenUtil().setHeight(1666),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    } else if (_data.tabIndex == 2) {
                      scrollController.animateTo(ScreenUtil().setHeight(4900),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    } else if (_data.tabIndex == 3) {
                      scrollController.animateTo(ScreenUtil().setHeight(18100),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    } else {
                      scrollController.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Text(titleList[index]['title'],
                            style: TextStyle(
                                fontSize: _data.tabActive ? 16 : 14,
                                color: _data.tabActive
                                    ? Theme.of(context).primaryColor
                                    : Color(0xff333333))),
                        _data.tabActive
                            ? TipIcon(
                                width: ScreenUtil().setWidth(60),
                                height: 3,
                                colorList: [
                                  Color(0xfff5503a),
                                  Color(0xfffad1cb)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : Container()
                      ],
                    ),
                  ));
            })));
    } else {
      return Container();
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Provide<GoodsCommentDetailProvide>(
  //     builder: (BuildContext context, Widget child, data) {
  //       // print('tab bar provide data: $data...............................');
  //       var _data = Provide.value<GoodsCommentDetailProvide>(context);
  //       if(_data.tabIndex != null) {
  //         List<Widget> list = titleList.map<Widget>((item) {
  //         var idx = titleList.indexOf(item);
  //         if (_data.tabIndex == idx) {
  //           _data.changeTabActive(true);
  //         } else {
  //           _data.changeTabActive(false);
  //         }
  //         return InkWell(
  //             onTap: () {
  //               _data.changeTabIndex(idx);
  //               if (_data.tabIndex == 1) {
  //                 scrollController.animateTo(ScreenUtil().setHeight(1666),
  //                     duration: Duration(milliseconds: 500),
  //                     curve: Curves.ease);
  //               } else if (_data.tabIndex == 2) {
  //                 scrollController.animateTo(ScreenUtil().setHeight(4900),
  //                     duration: Duration(milliseconds: 500),
  //                     curve: Curves.ease);
  //               } else {
  //                 scrollController.animateTo(0,
  //                     duration: Duration(milliseconds: 500),
  //                     curve: Curves.ease);
  //               }
  //             },
  //             child: Container(
  //               child: Column(
  //                 children: [
  //                   Text(item['title'],
  //                       style: TextStyle(
  //                         fontSize: _data.tabActive ? 16 : 14,
  //                           color: _data.tabActive
  //                               ? Theme.of(context).primaryColor
  //                               : Color(0xff333333))),
  //                   _data.tabActive
  //                       ? TipIcon(
  //                           width: ScreenUtil().setWidth(60),
  //                           height: 3,
  //                           colorList: [Color(0xfff5503a), Color(0xfffad1cb)],
  //                           begin: Alignment.centerLeft,
  //                           end: Alignment.centerRight,
  //                         )
  //                       : Container()
  //                 ],
  //               ),
  //             ));
  //       }).toList();
  //       return Container(
  //           child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: list));
  //       } else {
  //         return Center(child: Text('暂无数据'));
  //       }

  //     },
  //   );
  // }
}
