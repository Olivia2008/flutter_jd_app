import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:netease_news/components/icons/tipIcon.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoreWidget extends StatelessWidget {
  StoreWidget(this.data);
  final GoodsCommentDetailModel data;

  static const _kontFamWechat = 'Wechat';
  static const _kFontPkg = null;
  static const IconData wechat =
      IconData(0xf1d7, fontFamily: _kontFamWechat, fontPackage: _kFontPkg);
  @override
  Widget build(BuildContext context) {
    var store = data.data.result.store;
    var stockState = data.data.result.stockstate;
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      height: ScreenUtil().setHeight(530),
      width: ScreenUtil().setWidth(750),
      child: Stack(
        children: [_partOne(context, store, stockState), _partTwo(context, store)],
      ),
    );
  }

  Widget _partOne(context, store, stockState) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        height: ScreenUtil().setHeight(200),
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff20356a),
                Color(0xff5070ab),
                Color(0xff7371b7),
                Color(0xff9897b7)
              ],
              stops: [0.3, 0.5, 0.7, 1],
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: FadeInImage.assetNetwork(
                width: ScreenUtil().setWidth(140),
                height: ScreenUtil().setHeight(120),
                placeholder: 'assets/images/lazy.png',
                image: '${store.img}',
                fit: BoxFit.fill,
              ),
            ),
            Container(
                height: ScreenUtil().setHeight(80),
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Row(
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${store.name} ',
                            style: TextStyle(color: Color(0xffffffff))),
                        stockState.a == '1'
                            ? TipIcon(
                                alignment: Alignment.center,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0)),
                                padding: EdgeInsets.fromLTRB(3.0, 0, 3.0, 0),
                                stops: [0.7, 1.0],
                                child: Text('自营',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 10)),
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)
                            : null,
                        Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Icon(Icons.arrow_forward_ios,
                              size: 12, color: Color(0xffffffff)),
                        )
                      ],
                    )),
                    Text('${store.fans}万人关注',
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 12))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _partTwo(context, store) {
    return Positioned(
      top: ScreenUtil().setHeight(180),
      left: 0,
      height: ScreenUtil().setHeight(350),
      width: ScreenUtil().setWidth(750),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _name(context, store.name),
              _recommend(context, store.recommend),
              _buttons(context)
            ]),
      ),
    );
  }

  Widget _name(context, name) {
    return Row(
      children: [
        Icon(Icons.format_quote, size: 16),
        Text(
          ' $name  ',
        ),
        Icon(Icons.format_quote, size: 16),
      ],
    );
  }

  Widget _recommend(context, data) {
    List<Widget> list = data.map<Widget>((item) {
      return InkWell(
          onTap: () {
            print('你喜欢的');
          },
          child: Card(
            elevation: 0,
            color: Color(0xfffafafa),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/lazy.png',
                    image: item.imageUrl,
                    fit: BoxFit.fill,
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(80),
                  ),
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ));
    }).toList();
    return Container(
      height: ScreenUtil().setHeight(200),
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          children: list),
    );
  }

  Widget _buttons(context) {
    return Container(
        height: ScreenUtil().setHeight(60),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          OutlineButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(wechat, size: 14, color: Color(0xff666666)),
                Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Text(
                      '联系客服',
                      style: TextStyle(color: Color(0xff666666)),
                    ))
              ],
            ),
            shape: StadiumBorder(side: BorderSide(color: Color(0xfff5f5f5))),
          ),
          OutlineButton(
            onPressed: () {},
            child: Row(children: [
              Icon(Icons.store, color: Color(0xff666666), size: 16),
              Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: Text('进店逛逛', style: TextStyle(color: Color(0xff666666))),
              )
            ]),
            shape: StadiumBorder(side: BorderSide(color: Color(0xfff5f5f5))),
          )
        ]));
  }
}
