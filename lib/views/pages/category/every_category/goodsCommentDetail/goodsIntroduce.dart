import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
// import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:ui';
import 'package:netease_news/views/model/goods_comment_detail.dart';

class IntroduceWidget extends StatelessWidget {
  IntroduceWidget(this.data, this.introKey);
  final GoodsCommentDetailModel data;
  final GlobalKey introKey;

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
    return Container(
      key: introKey,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(1324),
      child: Column(children: [
        _firstCard(context, data),
        _secondCard(context, data.data.result.discount),
        _thirdCard(context, data.data.result)
      ]),
    );
  }

  // first card
  Widget _firstCard(context, data) {
    return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(560),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            color: Color(0xffffffff)),
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(children: <Widget>[
          _price(context, data.data.result.priceinfo),
          _descTitle(context, data.data.result),
          _descSubtitle(context, data.data.result.subTitle),
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
          Container(
            child: Column(
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
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [Icon(iconMoney), Text('降价通知')],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [Icon(iconHeartPlus), Text('收藏')],
                      ))
                ]),
          )
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
                  color: Color(0xffffffff),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              TextSpan(
                  text: ' ${data.title}',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(32)))
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
                    color: Color(0xffffffff),
                    background: Paint()..color = Color(0xff000000))),
            TextSpan(
                text: '精选 ',
                style: TextStyle(
                    color: Color(0xff000000),
                    background: Paint()..color = Color(0xffff9900))),
            TextSpan(
                text: '  ${data.title}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333),
                    fontSize: ScreenUtil().setSp(32)))
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
                color: Color(0xff333333), fontSize: ScreenUtil().setSp(32))));
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
          _showSizeBottomSheet(context);
        },
        child: Container(
            // height: ScreenUtil().setHeight(300),
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

  void _showSizeBottomSheet(context) {
    List _list = [
      {'label': '上市时间', 'value': '2019年9月'},
      {'label': '屏幕尺寸', 'value': '6.1英寸'},
      {'label': '机身厚度', 'value': '8.3'},
      {'label': '双卡机类型', 'value': '双卡双待'}
    ];
    showModalBottomSheet(
        context: context,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  '商品参数',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Column(
                    children: List.generate(_list.length, (index) {
                  return Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _list[index]['label'],
                          style:
                              TextStyle(color: Color(0xff888888), fontSize: 12),
                        ),
                        Text(_list[index]['value'],
                            style: TextStyle(
                                color: Color(0xff333333), fontSize: 12.0))
                      ],
                    ),
                  );
                })),
              )
            ]),
          );
        });
  }

  // second card
  Widget _secondCard(context, data) {
    return Container(
        alignment: Alignment.centerLeft,
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(320),
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.0),
                    ))),
            Expanded(child: Text(item.dis, overflow: TextOverflow.ellipsis))
          ]));
    }).toList();
    return InkWell(
      onTap: () {
        _showMoreDiscountBottomSheet(context);
      },
      child: Container(
          height: ScreenUtil().setHeight(320),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('优惠',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            fontWeight: FontWeight.w600)),
                    Icon(Icons.more_horiz)
                  ],
                )),
                Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _list))
              ])),
    );
  }

  void _showMoreDiscountBottomSheet(context) {
    List _list = [
      {'title': null, 'desc': '购买1件可优惠换购热销商品', 'num': null},
      {
        'title': '推广体验-无实物仅权益',
        'desc': 'Apple Music新用户三个月免费试用(IOS&Android用户均可使用)(赠完即止)',
        'num': '1'
      },
      {'title': '免费体验', 'desc': 'Apple产品“上手无忧”服务(赠完即止)', 'num': '1'},
      {
        'title': null,
        'desc':
            '中国电信 星卡 全年360G大流量 覆盖抖音、快手等近百款APP专属免流3人互打免费 4G电话卡 低月租 流量卡 手机号卡(需签收后7日内按提示完成信息上传)',
        'num': '1'
      },
      {
        'title': null,
        'desc':
            '中国移动 流量卡 手机卡 移动宝藏卡 月租19元 年享专属流量360G 4G网络 低月租 电话卡 手机号卡(需签收后7日内按提示完成信息上传)',
        'num': '1'
      },
      {'title': '点击领取', 'desc': '限量送超大流量卡', 'num': '1'}
    ];
    showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 5 * 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0)),
                  color: Color(0xffffffff)),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        '优惠',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  Container(
                    child: Column(
                      children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text('白条新人专项', style: TextStyle(color: Color(0xff888888))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('领立减70元优惠券'),
                      Container(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color: Theme.of(context).primaryColor)
                        ),
                        child: Text('立即开通', style:TextStyle(color: Theme.of(context).primaryColor, fontSize: 10.0))
                      )
                    ]),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('促销', style: TextStyle(color: Color(0xff888888))),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(_list.length, (index) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 6),
                                      child: index == 0 ? _showBottomIcon(context, '换购') : index ==1 ? _showBottomIcon(context, '赠品') : Container(width: 35),
                                    ),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(_list[index]['title'] != null ? '【${_list[index]['title']}】${_list[index]['desc']}' : _list[index]['desc'], maxLines: 3, overflow: TextOverflow.ellipsis,),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: _list[index]['num'] != null ? Text('x${_list[index]['num']}') : Text('')
                                        )
                                      ],
                                    ),),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward_ios, size: 10.0,),
                                      onPressed: () {print('优惠条目');},
                                    )
                                  ],
                                ),
                              );
                            })
                          )
                        ]
                      )
                    )
                  ]))
                ],
              ));
        });
  }

  Widget _showBottomIcon(context, title) {
    return Container(
                padding: EdgeInsets.only(left: 3.0, right: 3.0),
                child: Text(title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,)),
                decoration: BoxDecoration(
                    color: Color(0xfffdf0f0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.0),
                    )));
  }
  // third card
  Widget _thirdCard(context, data) {
    return Container(
        width: ScreenUtil().setWidth(750),
        // padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(400),
        margin: EdgeInsets.only(bottom: 6.0),
        child: Column(
          children: [
            Card(
                elevation: 0,
                margin: EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 6),
                    child: Column(children: <Widget>[
                      _selected(context, data.selected),
                      _underLine(),
                      _delivery(context, data.destination),
                    ]))),
            _annotation(context, data.destination.dis)
          ],
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
    var selectedText =
        '$_color, $_storage, $_methods, $_match, $_weight, $_count, $_service';

    return InkWell(
        onTap: () {
          print('已选 ');
        },
        child: Container(
            height: ScreenUtil().setHeight(90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('已选',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(32))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            Text(selectedText, softWrap: true),
                            Text('')
                          ],
                        ))),
                Icon(Icons.more_horiz)
              ],
            )));
  }

  Widget _delivery(context, data) {
    return InkWell(
        onTap: () {
          print('送至');
        },
        child: Container(
            height: ScreenUtil().setHeight(80),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('送至',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(32))),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: Column(children: [
                        Container(
                            child: Row(children: [
                          Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: Icon(Icons.pin_drop,
                                color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                            child: Text(data.addr,
                                overflow: TextOverflow.ellipsis),
                          )
                        ])),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: '${data.cate},',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                text: '${data.res},',
                              ),
                              TextSpan(text: data.time)
                            ]),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis)
                      ]))),
              Icon(Icons.more_horiz)
            ])));
  }

  Widget _annotation(context, data) {
    List _list = data.map<Widget>((item) {
      return Container(
          width: ScreenUtil().setWidth(220),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline,
                  color: Theme.of(context).primaryColor,
                  size: ScreenUtil().setSp(28)),
              Text(item.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: ScreenUtil().setSp(28)))
            ],
          ));
    }).toList();
    return Container(
        height: ScreenUtil().setHeight(150),
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 6.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            color: Color(0xfff9f9f9)),
        child: Wrap(spacing: 3, runSpacing: 3, children: _list));
  }
}
