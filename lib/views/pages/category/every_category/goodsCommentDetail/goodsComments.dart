import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:netease_news/views/model/goods_accessory.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/storeInfo.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/goodsQuestions.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/accessory.dart';
import 'package:netease_news/components/icons/tipIcon.dart';

class CommentsWidget extends StatelessWidget {
  CommentsWidget(this.data, this.accessoryInfo);
  final GoodsCommentDetailModel data;
  final AccessoryModel accessoryInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            _comment(context),
            StoreWidget(data),
            AccessoryWidget(accessoryInfo)
          ],
        ));
  }

  Widget _comment(context) {
    return Card(
            elevation: 0,
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  _title(
                      context, data.data.result.comments.productCommentSummary),
                  _hotCommentTags(context,
                      data.data.result.comments.hotCommentTagStatistics),
                  _userInfo(context, data.data.result.comments.commentsList),
                  _buttons(context)
                ]),
              ),
              Container(
                  height: 1,
                  width: ScreenUtil().setWidth(750),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Color(0xfff2f2f2))))),
              QuestionWidget(data.data.result.question)
            ]));
  }

  Widget _title(context, data) {
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
                    padding: EdgeInsets.only(left: 10),
                    child: Text('评价',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(36)))),
                Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(data.commentCountStr))
              ],
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('好评度 ${data.goodRateShow}%',
                    style: TextStyle(
                        color: Color(0xff8c8c8c),
                        fontSize: ScreenUtil().setSp(32))),
                Icon(Icons.arrow_forward_ios, size: 14)
              ],
            ))
          ],
        ));
  }

  Widget _hotCommentTags(context, data) {
    if (data.length != 0) {
      List<Widget> list = data.map<Widget>((item) {
        var idx = data.indexOf(item);
        return Container(
            margin: idx != data.length - 1
                ? EdgeInsets.only(right: 8.0)
                : EdgeInsets.all(0),
            child: InputChip(
              label: Text(item.name),
              backgroundColor: Color(0xfffcedeb),
              showCheckmark: false,
              selected: true,
              selectedColor: Color(0xfffcedeb),
            ));
      }).toList();
      return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(670),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: list,
          ));
    } else {
      return Container();
    }
  }

  Widget _userInfo(context, data) {
    if (data.length != 0) {
      List<Widget> list = data.map<Widget>((item) {
        return Container(
          width: ScreenUtil().setWidth(670),
          height: ScreenUtil().setHeight(450),
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 10,
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xfff2f2f2)))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _avatar(context, item),
                _disc(context, item),
                _imgs(context, item),
                _subdisc(context, item)
              ]),
        );
      }).toList();
      return Container(
        // padding: EdgeInsets.only(top: 10.0),
        // height: ScreenUtil().setHeight(700),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: list,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _avatar(context, data) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(Icons.person, color: Color(0xfffcc4bc), size: 38),
          backgroundColor: Color(0xfffcedeb),
        ),
        Container(
            margin: EdgeInsets.only(left: 8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(data.nickname),
                _userInfoScore(context, int.parse(data.score)),
              ],
            ))
      ],
    );
  }

  Widget _userInfoScore(context, scores) {
    if (scores > 0) {
      List<Widget> _list = [];
      for (var i = 0; i < scores; i++) {
        _list.add(
            Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16));
      }
      return Padding(
          padding: EdgeInsets.only(top: 6.0), child: Row(children: _list));
    } else {
      return Container();
    }
  }

  Widget _disc(context, data) {
    return Padding(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: Text(
          data.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget _imgs(context, data) {
    if (data.commentImages.length != 0) {
      List<Widget> list = data.commentImages.map<Widget>((item) {
        var idx = data.commentImages.indexOf(item);
        return Container(
            padding: EdgeInsets.only(right: 3.0),
            child: ClipRRect(
                borderRadius: idx == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0))
                    : idx == data.commentImages.length - 1
                        ? BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))
                        : BorderRadius.zero,
                child: InkWell(
                    onTap: () {
                      print('comment image');
                    },
                    child: FadeInImage.assetNetwork(
                        width: ScreenUtil().setWidth(192),
                        height: ScreenUtil().setHeight(192),
                        placeholder: 'assets/images/lazy.png',
                        image: item.imgUrl,
                        fit: BoxFit.fill))));
      }).toList();
      return Container(
          height: ScreenUtil().setHeight(192),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: list,
          ));
    } else {
      return Container();
    }
  }

  Widget _subdisc(context, data) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 6.0),
        child: Text('${data.productColor}, ${data.productSize}',
            style: TextStyle(color: Color(0xff8c8c8c))));
  }

  Widget _buttons(context) {
    return Container(
        height: ScreenUtil().setHeight(60),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          OutlineButton(
            onPressed: () {},
            child: Text('查看全部评价',style: TextStyle(color: Color(0xff666666)),),
            shape: StadiumBorder(side: BorderSide(color: Color(0xfff5f5f5))),
          ),
          OutlineButton(
            onPressed: () {},
            child: Text('购买咨询', style: TextStyle(color: Color(0xff666666))),
            shape: StadiumBorder(side: BorderSide(color: Color(0xfff5f5f5))),
          )
        ]));
  }
}
