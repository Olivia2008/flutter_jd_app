import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/model/category_detail_main.dart';
import 'package:netease_news/views/provides/category_detail_main.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'package:netease_news/views/provides/subList_category.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/router/staticRouter.dart';
import 'dart:convert';

// import 'main_widget/refreshWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainWidget extends StatefulWidget {
  MainWidget(this.params, this.scrollController, this.page);

  final Map params;
  ScrollController scrollController;
  int page;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  // ScrollController _listViewScrollController;
  EasyRefreshController _easyRefreshController;
  Map _params;
  List<Summary> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.scrollController = ScrollController();
    
    _easyRefreshController = EasyRefreshController();
    list = [];
    // id, subId, goodId all of them is String
    _params = {
      "id": widget.params['pareId'][0],
      "subId": widget.params['subId'][0],
      "goodId": widget.params['categoryId'][0],
      "page": widget.page,
      "pageSize": 10
    };
    _getSummaryList(_params);

  }

 
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.scrollController.dispose();
    _easyRefreshController.dispose();
  }

  void _getSummaryList(params) async {
    await request('categoryDetailMain', params: params).then((res) {
      setState(() {
        var data = json.decode(res.toString());
        CategoryDetailMainModel _result =
            CategoryDetailMainModel.fromJson(data);
        // list = _result.data.result.summary;
        if (_result.data.result.summary.length != 0)
          Provide.value<CategoryDetailMainProvide>(context)
              .getSummaryList(_result.data.result.summary);
      });
      print('详情分类页summary数据请求完成。。。。。。。');
    });
  }

  void _getMoreSummaryList() async {
    widget.page++;
    _params['page'] = widget.page;
    await request('categoryDetailMain', params: _params).then((res) {
      var data = json.decode(res.toString());
      CategoryDetailMainModel _result = CategoryDetailMainModel.fromJson(data);
      if (_result.data.result.summary.length != 0) {
        Provide.value<CategoryDetailMainProvide>(context)
            .getMoreSummaryList(_result.data.result.summary);
      } else {
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryDetailMainProvide>(
      builder: (context, child, data) {
        return data.summaryList.length != 0
            ? Container(
                margin: EdgeInsets.only(top: 10),
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setHeight(900),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    color: Colors.white),
                // child: RefreshWidget(_listViewScrollController, _easyRefreshController, _getMoreSummaryList)
                child: _easyRefreshWidget(data.summaryList, context))
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _easyRefreshWidget(data, context) {
    // print(data.summary[0].title);
    return EasyRefresh(
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      onLoad: () async {
        _getMoreSummaryList();
      },
      onRefresh: () async {
        Provide.value<CategoryDetailMainProvide>(context).summaryList.clear();
        widget.page = 1;
        _params['page'] = widget.page;
        print('onRefresh params:$_params');
        _getSummaryList(_params);
      },
      child: ListView(
          controller: widget.scrollController,
          shrinkWrap: true,
          children: <Widget>[_wrapList(data, context)]),
    );
  }

  Widget _wrapList(listData, context) {
    List<Widget> listWidget = listData.map<Widget>((item) {
      return InkWell(
          onTap: () {
           StaticRouter.router.navigateTo(context, '/cateGoodsDetail?goodsId=${item.skuId}').then((value) => {
             print('mainWidget staticRouter result:$value')
           });
          },
          child: Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: _rowWidget(item, context),
          ));
    }).toList();
    return Wrap(
      spacing: 1, // 水平方向间距
      runSpacing: 1,
      children: listWidget,
    );
  }

  Widget _rowWidget(item, context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _imageWidget(item),
        _descWidget(item, context),
      ],
    );
  }

// image widget
  Widget _imageWidget(item) {
    return Container(
        width: ScreenUtil().setWidth(240),
        height: ScreenUtil().setHeight(240),
        color: Color(0xfff5f5f5),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    placeholder: 'assets/images/lazy.png',
                    image: item.img)),
            item.sensitiveBook == 2
                ? Positioned(
                    bottom: 0,
                    child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(240),
                        height: ScreenUtil().setHeight(40),
                        // padding: EdgeInsets.all(3.0),
                        color: Color.fromRGBO(233, 59, 61, 0.7),
                        child:
                            Text('预订', style: TextStyle(color: Colors.white))))
                : item.sensitiveBook == 1
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(240),
                            height: ScreenUtil().setHeight(40),
                            // padding: EdgeInsets.all(3.0),
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            child: Text('北京无货',
                                style: TextStyle(color: Colors.white))))
                    : Container()
          ],
        ));
  }

// desc widget
  Widget _descWidget(item, context) {
    return Container(
      width: ScreenUtil().setWidth(490),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe5e5e5)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _descTitleWidget(item, context),
          _storageAndProperWidget(item, context),
          _descPriceWidget(item, context),
          _descVaribleWiget(item, context),
          _descCommentWidget(item, context),
          _descStoreWidget(item, context)
        ],
      ),
    );
  }

// desc->storage and proprerty put togetter
  Widget _storageAndProperWidget(item, context) {
    return Container(
        margin: EdgeInsets.only(bottom: 6),
        child: Column(
          children: <Widget>[
            _descProperWidget(item, context),
            _descStorageWidget(item, context),
          ],
        ));
  }

// desc -> title widget
  Widget _descTitleWidget(data, context) {
    var containerWrapper;
    if (int.parse(data.stockstate.e) == 1) {
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
        margin: EdgeInsets.only(bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                '京品手机',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
                child: Text(
              data.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff333333), fontSize: ScreenUtil().setSp(36)),
            ))
          ],
        ));
  }

  Widget _descJXIconTitleWidget(data, context) {
    return Container(
        margin: EdgeInsets.only(bottom: 3),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '京东',
                      style: TextStyle(
                          color: Colors.white,
                          background: Paint()..color = Colors.black)),
                  TextSpan(
                      text: '精选',
                      style: TextStyle(
                          color: Colors.black,
                          background: Paint()..color = Colors.orangeAccent))
                ])),
              ),
              Expanded(
                  child: Text(
                data.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff333333), fontSize: ScreenUtil().setSp(36)),
              ))
            ]));
  }

  Widget _descContextTitleWidget(data, context) {
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(bottom: 3),
        child: Text(data.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                color: Color(0xff333333), fontSize: ScreenUtil().setSp(36))));
  }

  // desc-> property widget
  Widget _descProperWidget(data, context) {
    return data.property.length != 0
        ? Container(
            margin: EdgeInsets.only(bottom: 3),
            width: ScreenUtil().setWidth(458),
            child: Row(
              children: _descProperItemWidget(data.property),
            ))
        : Container();
  }

  _descProperItemWidget(data) {
    List<Widget> listWidget = data.map<Widget>((item) {
      return Container(
          margin: EdgeInsets.only(right: 6),
          child: Text(item.des,
              style: TextStyle(
                  color: Color(0xff666666), fontSize: ScreenUtil().setSp(28))));
    }).toList();
    return listWidget;
  }

  // desc-> storage widget
  Widget _descStorageWidget(data, context) {
    return data.storage.length != 0
        ? Container(
            margin: EdgeInsets.only(bottom: 3),
            width: ScreenUtil().setWidth(458),
            child: Row(
              children: _descStorageItemWidget(data.storage),
            ))
        : Container();
  }

  _descStorageItemWidget(data) {
    List<Widget> listWidget = data.map<Widget>((item) {
      return Container(
          decoration: BoxDecoration(
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(2),
          ),
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.only(left: 3, right: 3),
          child: Text(item.des,
              style: TextStyle(
                  color: Color(0xff666666), fontSize: ScreenUtil().setSp(28))));
    }).toList();
    return listWidget;
  }

  // desc->price widget
  Widget _descPriceWidget(data, context) {
    var price = data.priceinfo.p;
    String plus = data.stockstate.i;
    String plusPrice = data.priceinfo.op;
    String plusImg = 'assets/images/plus.png';
    var dotIndex = price.indexOf('.');
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(bottom: 6),
        child: Row(children: <Widget>[
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '￥',
                style: TextStyle(
                    color: Color(0xFFF23030),
                    fontSize: ScreenUtil().setSp(26),
                    fontWeight: FontWeight.w600)),
            TextSpan(
                text: '${price.substring(0, dotIndex)}',
                style: TextStyle(
                    color: Color(0xFFF23030),
                    fontSize: ScreenUtil().setSp(38),
                    fontWeight: FontWeight.w600)),
            TextSpan(
                text: '${price.substring(dotIndex, price.length)}',
                style: TextStyle(
                    color: Color(0xFFF23030),
                    fontSize: ScreenUtil().setSp(26),
                    fontWeight: FontWeight.w600))
          ])),
          plus == '1'
              ? Container(
                  margin: EdgeInsets.only(left: 6.0),
                  child: Row(children: <Widget>[
                    Text('￥${plusPrice}',
                        style: TextStyle(color: Color(0xFFD2A448))),
                    Image.asset(
                      plusImg,
                      width: ScreenUtil().setWidth(62),
                      height: ScreenUtil().setHeight(36),
                    )
                  ]))
              : Container()
        ]));
  }

  // 自营，领券，新品，放心购，京东到家，商家自送，赠，商家免邮
  Widget _descVaribleWiget(data, context) {
    var stock = data.stockstate;
    return Container(
      child: Row(
        children: [
          _descSelfWidget(stock.a, context),
          _descInternationalWidget(stock.o, context),
          _descGreenBorderWidget(stock.c, '新品', context),
          _descBlueBorderWidget(stock.d, '放心购', context),
          _descBorderWidget(stock.g, stock.g, context),
          _descBorderWidget(stock.j, '商家免邮', context),
          _descBorderWidget(stock.k, '京东到家', context),
          _descBorderWidget(stock.l, '商家自送', context),
          _descBorderWidget(stock.f, '赠', context)
        ],
      ),
    );
  }

  // 自营
  Widget _descSelfWidget(self, context) {
    return self == '1'
        ? Container(
            margin: EdgeInsets.only(right: 8.0),
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              '自营',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
          )
        : Container();
  }

  // 京东国际
  Widget _descInternationalWidget(data, context) {
    return data != '-1'
        ? Container(
            margin: EdgeInsets.only(right: 8.0),
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.purpleAccent),
            child: Text(
              '京东国际',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(26)),
            ),
          )
        : Container();
  }

  // 新品 赠 券 免邮 到家 自送
  Widget _descBorderWidget(data, text, context) {
    return data != '-1'
        ? Container(
            margin: EdgeInsets.only(right: 6.0),
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Color(0xFFE4393C))),
            child: Text(text,
                style: TextStyle(
                    color: Color(0xFFE4393C),
                    fontSize: ScreenUtil().setSp(26))))
        : Container();
  }

  // 新品
  Widget _descGreenBorderWidget(data, text, context) {
    return data != '-1'
        ? Container(
            margin: EdgeInsets.only(right: 6.0),
            padding: EdgeInsets.only(left: 2.0, right: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Color(0xFF19BE6B))),
            child: Text(text,
                style: TextStyle(
                    color: Color(0xFF19BE6B),
                    fontSize: ScreenUtil().setSp(26))))
        : Container();
  }

  // 放心购
  Widget _descBlueBorderWidget(data, text, context) {
    return data != '-1'
        ? Container(
            margin: EdgeInsets.only(right: 6.0),
            padding: EdgeInsets.only(left: 2.0, right: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Color(0xFF2D8CF0))),
            child: Text(text,
                style: TextStyle(
                    color: Color(0xFF2D8CF0),
                    fontSize: ScreenUtil().setSp(26))))
        : Container();
  }

  // 评价
  Widget _descCommentWidget(data, context) {
    return Container(
        margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('${data.commentCountStr}条评价',
                      style: TextStyle(color: Color(0xff666666)))),
              Text('${data.goodRateShow}%好评',
                  style: TextStyle(color: Color(0xff666666)))
            ]));
  }

  // 店铺
  Widget _descStoreWidget(data, context) {
    return data.store != ''
        ? InkWell(
            onTap: () {
              print('店铺');
            },
            child: Container(
                alignment: Alignment.topLeft,
                child: Text('${data.store}  >',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: ScreenUtil().setSp(30)))))
        : Container();
  }
}
