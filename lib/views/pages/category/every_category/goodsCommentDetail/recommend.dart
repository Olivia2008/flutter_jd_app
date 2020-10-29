import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/model/goods_range.dart';
import 'package:netease_news/views/model/goods_rec.dart';
import 'package:netease_news/views/model/goods_search.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:netease_news/views/utils/index.dart';
import 'package:netease_news/components/icons/tipIcon.dart';

class RecommendWidget extends StatelessWidget {
  RecommendWidget(
      this.searchInfo,
      this.recommendInfo,
      this.rangeInfo,
      this.outerTabController,
      this.innerRecTabController,
      this.innerRangeTabController);
  final List<Map> rangeInfo;
  final List<Map> recommendInfo;
  final GoodsRecommendSearchModel searchInfo;
  final TabController outerTabController;
  final TabController innerRecTabController;
  final TabController innerRangeTabController;

  @override
  Widget build(BuildContext context) {
    if (rangeInfo.length != 0 ||
        recommendInfo.length != 0 ||
        searchInfo != null) {
      return Card(
        elevation: 0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0))),
        child: Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(900),
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
      height: ScreenUtil().setHeight(765),
      child: Column(
        children: [_tabBar(), _tabView(context, rangeData, recommendData), _button()],
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

  Widget _tabView(context, rangeData, recommendData) {
    var len = recommendData.length != 0 ? (recommendData.length / 6).ceil() : 1;
    var rangeLen = rangeData.length != 0 ? (rangeData.length / 6).ceil() : 1;
    return Container(
      height: ScreenUtil().setHeight(625),
      width: ScreenUtil().setWidth(666),
      child: TabBarView(controller: outerTabController, children: <Widget>[
        _swiper(context, recommendData, len),
        _swiper(context, rangeData, rangeLen)
      ]),
    );
  }

// 将数据分割为len组
  Widget _swiper(context, data, len) {
    var count = 6;
    var itemData = [];
    if (data.length != 0) {
      itemData = splitList(data, count);
      return Container(
          height: ScreenUtil().setHeight(625),
          width: ScreenUtil().setWidth(666),
          child: Swiper(
            outer: true,
            itemBuilder: (context, idx) {
              return _wrapItem(context, itemData[idx]);
            },
            itemCount: len,
            pagination: SwiperPagination(),
          ),
        );
    } else {
      return Center(
        child: Text('暂无数据'),
      );
    }
  }

  Widget _wrapItem(context, data) {
    List<Widget> list = data.map<Widget>((item) {
      return Container(
        height: ScreenUtil().setHeight(280),
        width: ScreenUtil().setWidth(200),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/lazy.png',
            image: item['mainImgPath'],
            fit: BoxFit.fill,
          ),
          Text(
            item['productName'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            '￥${item['price']}.00',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          )
        ]),
      );
    }).toList();
    return Container(
        height: ScreenUtil().setHeight(625),
        width: ScreenUtil().setWidth(666),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Wrap(spacing: 10.0, runSpacing: 4.0, children: list));
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
