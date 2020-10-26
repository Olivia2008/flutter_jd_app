import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/model/goods_range.dart';
import 'package:netease_news/views/model/goods_rec.dart';
import 'package:netease_news/views/model/goods_search.dart';

class RecommendWidget extends StatelessWidget {
  RecommendWidget(this.searchInfo, this.recommendInfo, this.rangeInfo);
  final RangeModel rangeInfo;
  final GoodsRecModel recommendInfo;
  final GoodsRecommendSearchModel searchInfo;
  @override
  Widget build(BuildContext context) {
    if (rangeInfo != null || recommendInfo != null || searchInfo != null) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(500),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InputChip(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            label: Text(
              '${data.selected.name}                                  ',
              style: TextStyle(color: Colors.grey),
            ),
            avatar: Icon(
              Icons.search,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
          Text('搜索')
        ],
      ),
    );
  }

  Widget _content(context, rangeData, recommendData) {
    return Container();
  }
}
