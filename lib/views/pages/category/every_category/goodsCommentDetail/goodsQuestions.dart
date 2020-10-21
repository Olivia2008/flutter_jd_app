import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/icons/tipIcon.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(this.data);
  final List data;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [_title(), _content(context, data)],
        ));
  }

  Widget _title() {
    return Container(
        height: ScreenUtil().setHeight(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TipIcon(
                    width: 3.0,
                    height: 20.0,
                    colorList: [Color(0xfff5503a), Color(0xfffad1cb)],
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '问答',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(36)),
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          ],
        ));
  }

  Widget _content(context, data) {
    // var _list = _data.subList(0, 2);
    print(data.first.replay);
    if (data != null) {
      return Container(
          height: ScreenUtil().setHeight(100),
          child: Column(children: [
            _contentOne(context, data.first),
            _contentOne(context, data[1])
          ]));
    } else {
      return Container();
    }
  }

  Widget _contentOne(context, data) {
    return Container(
        height: ScreenUtil().setHeight(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: ScreenUtil().setWidth(500),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setHeight(40),
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.3, 0.7],
                          colors: [Color(0xff0000ef), Color(0xff409eff)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '问',
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 12),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Text('${data.question}', overflow: TextOverflow.ellipsis,),
                    ))
                  ],
                )),
            Text(
              '${data.replay.length}个回答',
              style: TextStyle(color: Color(0xff999999)),
            )
          ],
        ));
  }
}
