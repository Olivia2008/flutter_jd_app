import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/model/goods_range.dart';
import 'package:netease_news/views/model/goods_rec.dart';
import 'package:netease_news/views/model/goods_search.dart';

class RecommendWidget extends StatelessWidget {
  RecommendWidget(this.searchInfo, this.recommendInfo, this.rangeInfo, this.outerTabController, this.innerRecTabController, this.innerRangeTabController);
  final RangeModel rangeInfo;
  final GoodsRecModel recommendInfo;
  final GoodsRecommendSearchModel searchInfo;
  final TabController outerTabController;
  final TabController innerRecTabController;
  final TabController innerRangeTabController;

  @override
  Widget build(BuildContext context) {
    if (rangeInfo != null || recommendInfo != null || searchInfo != null) {
      return Card(
        elevation: 0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0))),
        child: Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(600),
            padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _search(context, searchInfo.data),
                _content(context, rangeInfo, recommendInfo)
              ],
            )),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _search(context, data) {
    return Container(
        width: ScreenUtil().setWidth(666),
        padding: EdgeInsets.only(bottom: 10.0),
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xfff1f1f1)))),
        child: Row(
          children: [
            Text('相关商品:', style: TextStyle(color: Color(0xff888888))),
            _searchConnection(context, data.connection)
          ],
        ));
  }

  Widget _searchConnection(context, data) {
    if (data.length != 0) {
      return Container(
        height: ScreenUtil().setHeight(80),
        margin: EdgeInsets.only(left: 6.0),
        child: Wrap(
          spacing: 5.0,
          children: [
            InputChip(
                label: Text(
              data.first.name,
              style: TextStyle(fontSize: 12),
            )),
            InputChip(
                label: Text(data[1].name, style: TextStyle(fontSize: 12))),
            InputChip(
              label: Text(data[2].name, style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      );
    } else {
      return Text('暂无数据');
    }
  }

  Widget _content(context, rangeData, recommendData) {
    return Container(
      width: ScreenUtil().setWidth(666),
      height: ScreenUtil().setHeight(466),
      child: Column(
        children: [_tabBar(), _tabView(), _button()],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      width: ScreenUtil().setWidth(666),
      height: ScreenUtil().setHeight(80),
      child: TabBar(
          onTap: (idx) {
            print('tab bar $idx');
          },
          controller: outerTabController,
          indicatorPadding: EdgeInsets.only(top: 3.0),
          indicatorColor: Color(0xfff5503a),
          indicatorWeight: 3.0,
          labelColor: Color(0xfff5503a),
          unselectedLabelColor: Color(0xff888888),
          tabs: [Text('为你推荐'), Text('排行榜')]),
    );
  }

  Widget _tabView() {
    var len = recommendInfo.data.listSkuRelation.length != 0 ? (recommendInfo.data.listSkuRelation.length / 6).ceil() : 1;
    print('recommendInfo.data.listSkuRelation.length: ${recommendInfo.data.listSkuRelation.length}');
    List<Widget> _recTabBarList = [];
    List<Widget> _recTabBarViewList = [];
    Widget recTabBarWidget = Container(
                  width: 8,
                  height: 5,
                  child: Text('——'),
                );
    
    Widget recTabBarViewWidget = Container(child: Text('aaa'),);
    if(len > 1) {
      for (var i = 0; i < len; i++) {
        _recTabBarList.add(recTabBarWidget);
        _recTabBarViewList.add(recTabBarViewWidget);
      }
    } else {
      _recTabBarList.add(recTabBarWidget);
      _recTabBarViewList.add(recTabBarViewWidget);
    }
    return Container(
      height: ScreenUtil().setHeight(306),
      width: ScreenUtil().setWidth(666),
      child: TabBarView(
        controller: outerTabController,
        children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(260),
          width: ScreenUtil().setWidth(666),
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
              children: [
                Flexible(child: TabBarView(
                  controller: innerRecTabController,
                  children: _recTabBarViewList)),
                Container(
                  width: 10,
                  height: 3,
                  child: TabBar(
                    indicatorColor: Color(0xfff5503a),
                  controller: innerRecTabController,
                  tabs: _recTabBarList),
                )
              ],
            ),
        ),
        Container(
          height: ScreenUtil().setHeight(260),
          width: ScreenUtil().setWidth(666),
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
              children: [
                Flexible(child: TabBarView(
                  controller: innerRangeTabController,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Text('a'),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Text('b'),
                    ),
                  ])),
                TabBar(
                  controller: innerRangeTabController,
                  tabs: [
                    Container(
                      width: 5,
                      height: 2,
                      child: Text('1'),
                    ),
                    Container(
                      width: 5,
                      height: 2,
                      child: Text('2'),
                    ),
                  ])
              ],
            ),
        )
      ]),
    );
  }

  Widget _button() {
    return Container(
      width: ScreenUtil().setWidth(666),
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.0),
      child: OutlineButton(
        onPressed: () {},
        child: Text(
          '查看更多为你推荐',
          style: TextStyle(color: Color(0xff666666)),
        ),
        shape: StadiumBorder(side: BorderSide(color: Color(0xfff5f5f5))),
      ),
    );
  }
}
