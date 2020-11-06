import 'package:flutter/material.dart';
import 'package:netease_news/components/stickBar/sliverSearchAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/router/staticRouter.dart';

class SearchStickyBar extends StatelessWidget {
  SearchStickyBar(this.searchInfo, this.params);
  final Map searchInfo;
  final Map<String, dynamic> params;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false, // 为true不吸顶，false吸顶
      delegate: CustomSliverPersistentHeaderDelegate(
          max: 70,
          min: 70,
          child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
              child: Container(
                height: 70, 
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    StaticRouter.router.navigateTo(context, '/cateGoodsDetail/goodsSearch?goodsId=${params['goodsId'].first}');
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(580),
                    height: 32,
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xfff1f1f1)
                    ),
                    child: Row(
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Color(0xff888888), size: 16),
                        Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Text(searchInfo['selected']['name'],
                    style: TextStyle(color: Color(0xff999999), fontSize: 14),),
                        )
                      ],
                    ),
                  )
                ),
                Text('搜索'),
              ],
            ),
              )
            )),
    );
  }
}