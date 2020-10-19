
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';

class CommentsWidget extends StatelessWidget {
  CommentsWidget(this.data);
  final Comments data;
  @override
  Widget build(BuildContext context) {
    print('comment widget data: ${data.productCommentSummary.skuId}');
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(500),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _title(context, data.productCommentSummary),
              _hotCommentTags(context, data.hotCommentTagStatistics),
              _userInfo(context, data.commentsList)
            ]
          ),
        )
      )
    );
  }

  Widget _title(context, data) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      )
    );
  }

  Widget _hotCommentTags(context, data) {
    return Container();
  }

  Widget _userInfo(context, data) {
    return Container();
  }
}