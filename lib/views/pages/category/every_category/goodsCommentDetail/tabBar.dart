import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';

class TabBarWidget extends StatelessWidget {
  // TabBarWidget(this.showBar);
  // bool showBar;
  List titleList = [{'id': '', 'title': '商品'}, {'id': '', 'title': '评价'}, {'id': '', 'title': '详情'}, {'id': '', 'title': '推荐'}];
  bool active = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = titleList.map<Widget>((item) {
      var idx = titleList.indexOf(item);
      if (Provide.value<GoodsCommentDetailProvide>(context).tabIndex == idx) {
        Provide.value<GoodsCommentDetailProvide>(context).changeTabActive(true);
        print('equal active:${Provide.value<GoodsCommentDetailProvide>(context).tabActive}');
      } else {
        Provide.value<GoodsCommentDetailProvide>(context).changeTabActive(false);
        print('not equal:${Provide.value<GoodsCommentDetailProvide>(context).tabActive}');
      }
      return InkWell(
      onTap: () {
        Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(idx);
        print(Provide.value<GoodsCommentDetailProvide>(context).tabIndex);
        print(Provide.value<GoodsCommentDetailProvide>(context).tabActive);
        // print(Provide.value<GoodsCommentDetailProvide>(context).tabIndex);
        // print('tab bar active:${Provide.value<GoodsCommentDetailProvide>(context).tabActive}');
      },
      child: Container(
        decoration: Provide.value<GoodsCommentDetailProvide>(context).tabActive ? BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).primaryColor, width: 5)
          )
        ) : null,
        child: Text(item['title'],
          style: TextStyle(
              color: Provide.value<GoodsCommentDetailProvide>(context).tabActive ? Theme.of(context).primaryColor : Color(0xff333333))),
      )
    );
      
    }).toList();
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: list));
  }

}
