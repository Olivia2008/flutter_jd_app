import 'package:flutter/material.dart';
// import 'package:netease_news/views/provides/cart/cart.dart';
// import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/stickBar/sliverSearchAppBar.dart';

class CartPage extends StatelessWidget {
  String icons = "";
  @override
  Widget build(BuildContext context) {
    icons += "&#xE618";
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: Stack(
          children: [
            CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Color(0xfff5f5f5),
                leading: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    color: Color(0xff333333),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                actions: [
                  Row(
                    children: [
                      InkWell(
                    onTap: () {},
                    child: Text('编辑',
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 14)),
                  ),
                  IconButton(
                      color: Color(0xff333333),
                      icon: Icon(
                        Icons.more_horiz,
                      ),
                      onPressed: null)
                    ]
                  )
                ],
                title: InkWell(
                            onTap: () {},
                            child: Container(
                                child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('购物车',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff333333))),
                                          Container(
                                            margin: EdgeInsets.only(left: 4.0),
                                            width: 16,
                                            height: 16,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0))),
                                            child: Icon(Icons.location_on,
                                                color: Colors.black87,
                                                size: 12),
                                            // child: Text(icons, style: TextStyle(color: Colors.black54)),
                                          )
                                        ])),
                                Text('配送至:北京市海淀区生命科学园路38号北京市海淀区生命科学园路38号',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 10))
                              ],
                            )))),
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverPersistentHeaderDelegate(
                max: 50,
                min: 50,
                child: Container(
                  color: Colors.blue,
                  width: ScreenUtil().setWidth(750),
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('全问', style: TextStyle(color: Color(0xff333333)),),
                      Text('全问', style: TextStyle(color: Color(0xff333333)),),
                      Text('全问', style: TextStyle(color: Color(0xff333333)),),
                      Text('全问', style: TextStyle(color: Color(0xff333333)),),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(80),
            color: Colors.white,
            child: Text('bottom'),
          )
        )
          ],
        ));
  }
}
