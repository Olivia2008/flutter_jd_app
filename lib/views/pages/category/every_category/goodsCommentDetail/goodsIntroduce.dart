import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroduceWidget extends StatelessWidget {
  static const _iconMoney = 'CnMoney';
  static const _iconMoneyPkg = null;
  static const IconData iconMoney = IconData(0xe800, fontFamily: _iconMoney, fontPackage: _iconMoneyPkg);
  static const _iconHeartPlus = 'HeartPlus';
  static const _iconHeartPlustPkg = null;
  static const IconData iconHeartPlus = IconData(0xe901, fontFamily: _iconHeartPlus, fontPackage: _iconHeartPlustPkg);
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsCommentDetailProvide>(
      builder: (context, child, data) {
        if(data.goodsInfo != null) {
          print('goods introduce widget:${data.goodsInfo.data.result.priceinfo}');
          return Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
              color: Color(0xffffffff)
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                _price(context, data.goodsInfo.data.result.priceinfo)
              ]
            )
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  Widget _price(context, price) {
    var dotIndex = price.op.indexOf('.');
    return Container(
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: '￥',
                      style: TextStyle(
                          color: Color(0xFFF23030),
                          fontSize: ScreenUtil().setSp(26),
                          fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: '${price.op.substring(0, dotIndex)}',
                        style: TextStyle(
                            color: Color(0xFFF23030),
                            fontSize: ScreenUtil().setSp(38),
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: '${price.op.substring(dotIndex, price.op.length)}',
                        style: TextStyle(
                            color: Color(0xFFF23030),
                            fontSize: ScreenUtil().setSp(26),
                            fontWeight: FontWeight.w600))
                  ]
                )),
                Text(
                  '￥${price.p}',
                  style: TextStyle(color: Color(0xff888888), decoration: TextDecoration.lineThrough),
                )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Icon(iconMoney),
                        Text('降价通知')
                      ],
                    ),
                    Column(
                      children: [
                        Icon(iconHeartPlus),
                        Text('收藏')
                      ],
                    )
                  ]
                )
              ]
            )
      );
  }
}