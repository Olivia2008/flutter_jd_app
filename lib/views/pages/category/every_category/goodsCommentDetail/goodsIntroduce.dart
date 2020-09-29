import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class IntroduceWidget extends StatelessWidget {
  static const _iconMoney = 'CnMoney';
  static const _iconMoneyPkg = null;
  static const IconData iconMoney =
      IconData(0xe800, fontFamily: _iconMoney, fontPackage: _iconMoneyPkg);
  static const _iconHeartPlus = 'HeartPlus';
  static const _iconHeartPlustPkg = null;
  static const IconData iconHeartPlus = IconData(0xe901,
      fontFamily: _iconHeartPlus, fontPackage: _iconHeartPlustPkg);
  static const List _sizeList = [
    {'label': '上市时间', 'value': '2019年9月'},
    {'label': '屏幕尺寸', 'value': '6.1英寸'},
    {'label': '机身厚度', 'value': '8.3'},
    {'label': '双卡机类型', 'value': '双卡双待'}
  ];
  static const Map _plusInfo = {
    'title': 'PLUS会员 享更多优惠',
    'desc': '实际优惠金额请以结算页下单结果为准',
    'price': '29.49元',
    'bean': '京豆返利规则：返豆数量=商品实付金额（扣除促销、优惠券等各项优惠后的金额）x50%,以最终到账为准，详细规则可在PLUS会员专区查看'
  };
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsCommentDetailProvide>(
      builder: (context, child, data) {
        print('introduce info: ${data.goodsInfo}');
        if (data.goodsInfo != null) {
          print(
              'goods introduce widget:${data.goodsInfo.data.result.priceinfo}');
          return Column(children: [
            _firstCard(context, data),
            _secondCard(context, data.goodsInfo.data.result.discount),
            _thirdCard(context, data.goodsInfo.data.result)
          ]);
        } else {
          return Center(child: Text('数据正在加载中...'));
        }
      },
    );
  }

  // first card
  Widget _firstCard(context, data) {
    return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(790),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            color: Color(0xffffffff)),
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(children: <Widget>[
          _price(context, data.goodsInfo.data.result.priceinfo),
          _descTitle(context, data.goodsInfo.data.result),
          _descSubtitle(context, data.goodsInfo.data.result.subTitle),
          _plusAccount(context, _plusInfo),
          _contract(context),
          _underLine(),
          _size(context, _sizeList)
        ]));
  }

  Widget _price(context, price) {
    var dotIndex = price.op.indexOf('.');
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Column(
            children: [
              Text.rich(TextSpan(children: [
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
              ])),
              Text(
                '￥${price.p}',
                style: TextStyle(
                    color: Color(0xff888888),
                    decoration: TextDecoration.lineThrough),
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [Icon(iconMoney), Text('降价通知')],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [Icon(iconHeartPlus), Text('收藏')],
                    ))
              ])
        ]));
  }

  Widget _descTitle(context, data) {
    return InkWell(
        onTap: () {
          print('title tap');
        },
        child: _descTitleWidget(context, data));
  }

  // desc -> title widget
  Widget _descTitleWidget(context, data) {
    var containerWrapper;
    if (int.parse(data.stockstate.a) == 1) {
      containerWrapper = _descJPIconTitleWidget(data, context);
    } else if (int.parse(data.stockstate.h) == 1) {
      containerWrapper = _descJXIconTitleWidget(data, context);
    } else {
      containerWrapper = _descContextTitleWidget(data, context);
    }
    return containerWrapper;
  }

  Widget _descJPIconTitleWidget(data, context) {
    return Container(
        // color: Colors.green,
        margin: EdgeInsets.only(bottom: 6, top: 6),
        width: ScreenUtil().setWidth(670),
        child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '自营',
                style: TextStyle(
                  wordSpacing: 10.0,
                  color: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              TextSpan(
                  text: ' ${data.title}',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(36)))
            ]),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 3));
  }

  Widget _descJXIconTitleWidget(data, context) {
    return Container(
        margin: EdgeInsets.only(bottom: 6, top: 6),
        width: ScreenUtil().setWidth(670),
        child: Text.rich(
          TextSpan(children: [
            TextSpan(
                text: ' 京东',
                style: TextStyle(
                    color: Colors.white,
                    background: Paint()..color = Colors.black)),
            TextSpan(
                text: '精选 ',
                style: TextStyle(
                    color: Colors.black,
                    background: Paint()..color = Colors.orangeAccent)),
            TextSpan(
                text: '  ${data.title}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333),
                    fontSize: ScreenUtil().setSp(36)))
          ]),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ));
  }

  Widget _descContextTitleWidget(data, context) {
    return Container(
        width: ScreenUtil().setWidth(670),
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(bottom: 6, top: 6),
        child: Text(data.title,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
                color: Color(0xff333333), fontSize: ScreenUtil().setSp(36))));
  }

  Widget _descSubtitle(context, data) {
    List _list = data.split(',').map<Widget>((item) {
      return Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(
          Icons.fiber_manual_record,
          size: 12,
          color: Color(0xff666666),
        ),
        Text(item, style: TextStyle(color: Color(0xff666666)))
      ]));
    }).toList();
    return Container(
        child: Row(
      children: _list,
    ));
  }

  Widget _plusAccount(context, data) {
    return InkWell(
        onTap: () {},
        child: Container(
            width: ScreenUtil().setWidth(670),
            margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                color: Color(0xfffff3c0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '0元开PLUS年卡, 预估额外返',
                    style: TextStyle(fontSize: ScreenUtil().setSp(24))),
                TextSpan(
                  text: '29.49元',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil().setSp(24)),
                ),
                TextSpan(text: '...')
              ])),
              Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Icon(Icons.info_outline, color: Color(0xff888888))),
              Text('立即开通 >', style: TextStyle(fontSize: ScreenUtil().setSp(24)))
            ])));
  }

  Widget _contract(context) {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('合约立减至高直降3840元详情请猛戳链接！', style: TextStyle(color: Color(0xff888888))),
      InkWell(
          onTap: () {
            print('合约立减');
          },
          child: Text('请查看>',
              style: TextStyle(color: Theme.of(context).primaryColor)))
    ]));
  }

  Widget _underLine() {
    return Container(
        margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xfff5f5f5)))));
  }

  Widget _size(context, data) {
    List<IconData> _icons = [
      Icons.timeline,
      Icons.aspect_ratio,
      Icons.view_day,
      Icons.sd_card
    ];
    List _list = data.map<Widget>((item) {
      var idx = data.indexOf(item);
      return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: Icon(_icons[idx], size: ScreenUtil().setSp(32.0)),
              ),
              Text(item['label'],
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text(item['value'],
                  style: TextStyle(fontSize: ScreenUtil().setSp(24.0)))
            ],
          ));
    }).toList();
    return InkWell(
        onTap: () {
          print('规格');
        },
        child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    '规格',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(32)),
                  ),
                ),
                Row(
                  children: _list,
                )
              ],
            )));
  }

  // second card
  Widget _secondCard(context, data) {
    return Container(
        alignment: Alignment.centerLeft,
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(450),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xffffffff)),
        margin: EdgeInsets.only(bottom: 10.0),
        child: _discount(context, data));
  }

  Widget _discount(context, data) {
    List _list = data.map<Widget>((item) {
      return Padding(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: Row(children: [
        Container(
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
            margin: EdgeInsets.only(left: 20.0, right: 6.0),
            child: Text(item.title,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(28))),
            decoration: BoxDecoration(
              color: Color(0xfffdf0f0),
              borderRadius: BorderRadius.all(Radius.circular(3.0),
            ))),
        Expanded(child: Text(item.dis, overflow: TextOverflow.ellipsis))
      ])
      );
    }).toList();
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      InkWell(
        onTap: () {print('更多优惠');},
        child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('优惠',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w600)),
          Icon(Icons.more_horiz)
        ],
      ))
      ),
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _list))
    ]);
  }

  // third card
  Widget _thirdCard(context, data) {
    return Container(
        width: ScreenUtil().setWidth(750),
        // padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(610),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(15.0),
        //         bottomRight: Radius.circular(15.0)),
        //     color: Color(0xffffffff)),
        margin: EdgeInsets.only(bottom: 10.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
          _selected(context, data.selected),
          _underLine(),
          _delivery(context, data.destination)
        ])
          )
        ));
  }

  Widget _selected(context, data) {
    String _color = data.colors.colorList[0].label;
    String _storage = data.storage.versionList[0].label;
    String _methods = data.methods.methodsList[0].label;
    String _match = data.standMatch.matchList[0].label;
    String _weight = '0.47kg';
    String _count = '${data.count.dis}件';
    String _service = '可选服务';
    var selectedText = '$_color, $_storage, $_methods, $_match, $_weight, $_count, $_service';

    return InkWell(
      onTap: () {print('已选 ');},
      child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('已选', style: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32))),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Column(
              children: [
               Text(selectedText, softWrap: true),
                Text('')
              ],
            )
            )
          ),
          Icon(Icons.more_horiz)
        ],
      )
    )
    );
  }

  Widget _delivery(context, data) {
    return InkWell(
      onTap: () {print('送至');},
      child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('送至', style: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32))),
           Expanded(
             child: Container(
             margin: EdgeInsets.only(left: 20.0),
             child: Column(
            children: [
              Container(
                child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Icon(Icons.pin_drop, color: Theme.of(context).primaryColor),
                  ),
                  Expanded(
                    child: Text(data.addr, overflow: TextOverflow.ellipsis),
                  )
                ]
              )
              ),
              Text.rich(
                TextSpan(
                children: [
                  TextSpan(
                    text: '${data.cate},',
                    style: TextStyle(color: Theme.of(context).primaryColor)
                  ),
                  TextSpan(
                    text: '${data.res},',
                  ),
                  TextSpan(
                    text: data.time
                  )
                ]
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis
              )
            ]
          )
           )
           ),
          Icon(Icons.more_horiz)
        ]
      )
    )
    );
  }
}
