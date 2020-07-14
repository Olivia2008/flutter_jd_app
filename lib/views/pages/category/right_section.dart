import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/provides/child_category.dart';
import 'package:provide/provide.dart';

class RightSection extends StatefulWidget {
  @override
  _RightSectionState createState() => _RightSectionState();
}

class _RightSectionState extends State<RightSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(580),
        //height: ScreenUtil().setHeight(600),
        decoration: BoxDecoration(color: Colors.white),
        child: Provide<ChildCategory>(
          builder: (context, child, category) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    titleBar(
                        context, index, category.hotCategoryList[index].title),
                   //  _wrapList(category.hotCategoryList[index].listData)
                  ],
                );
              },
              itemCount: category.hotCategoryList.length,
            );
          },
        ));
  }

  Widget titleBar(context, index, title) {
    return Container(
      // width: ScreenUtil().setWidth(580),
      height: ScreenUtil().setHeight(92),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.topLeft,
      child: index == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${title}',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: ScreenUtil().setSp(26),
                        fontWeight: FontWeight.w600)),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Image.asset(
                          'assets/images/rank.png',
                          width: ScreenUtil().setWidth(24),
                          height: ScreenUtil().setHeight(24),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Text(
                          '排行榜',
                          style: TextStyle(
                              color: Color(0xFF848689),
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                      ),
                      Image.asset(
                        'assets/images/right_arrow_grey.png',
                        width: ScreenUtil().setWidth(24),
                        height: ScreenUtil().setHeight(24),
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                )
              ],
            )
          : Text('${title}',
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: ScreenUtil().setSp(26),
                  fontWeight: FontWeight.w600)),
    );
  }

  Widget _wrapList(listData) {
    if (listData.length != 0) {
      List<Widget> listWidget = listData.map<Widget>((item) {
        return InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: ScreenUtil().setWidth(180),
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Image.network(
                  item.img,
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setHeight(140),
                  fit: BoxFit.fill,
                ),
                Text(item.title, style: TextStyle(color: Color(0xFF333333), fontSize: ScreenUtil().setSp(22)),)
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 3, // 水平方向间距
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }
}
