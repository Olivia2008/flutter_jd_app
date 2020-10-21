import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

class PriceRange extends StatefulWidget {
  PriceRange(this.data);
  final Map data;
  @override
  _PriceRangeState createState() => _PriceRangeState();
}

class _PriceRangeState extends State<PriceRange> {
  final minTextController = TextEditingController();
  final maxTextController = TextEditingController();
  // Map rangeList = {
  //   'id': '',
  //   'name': '',
  //   'min': null,
  //   'max': null,
  //   'activeValue': ''
  // };
  String activeValue = '';
  @override
  void initState() {
    // TODO: implement initState
    // rangeList['id'] = widget.data['id'];
    // rangeList['name'] = widget.data['name'];

    // minTextController.addListener(() {
    //   rangeList['min'] = minTextController.text;
    // });
    // maxTextController.addListener(() {
    //   rangeList['max'] = maxTextController.text;
    // });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    minTextController.dispose();
    maxTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // alignment: Alignment.center,
        child: Column(children: <Widget>[
          _priceRangeTitleWidget(widget.data, context),
          _priceRangeInputWidget(widget.data, context),
          _priceRangeChoiceWidget(widget.data['list'], context)
        ]));
  }

  Widget _priceRangeTitleWidget(data, context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(data['title'],
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32))),
    );
  }

  Widget _priceRangeInputWidget(data, context) {
    // final chips = [];
    // Provide.value<CategoryNavBarFilterProvide>(context)
    //     .getFilterPriceActiveList(rangeList);
    // print(Provide.value<CategoryNavBarFilterProvide>(context).navBarFilterAcitveList);
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Provide<CategoryNavBarFilterProvide>(
            builder: (context, child, provider) {
          return Wrap(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(220),
                height: ScreenUtil().setHeight(50),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Color(0xfff2f2f7),
                      hintText: '最低价',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none)),
                  textAlign: TextAlign.center,
                  controller: minTextController,
                  onChanged: (value) {
                    provider.priceRangeActiveList['id'] = widget.data['id'];
                    provider.priceRangeActiveList['name'] = widget.data['name'];
                    provider.priceRangeActiveList['min'] = value;
                    print('priceRangeActiveList:${provider.priceRangeActiveList}');
                  },
                ),
              ),
              Container(
                  width: ScreenUtil().setWidth(25),
                  height: ScreenUtil().setHeight(50),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text('--')),
              Container(
                width: ScreenUtil().setWidth(220),
                height: ScreenUtil().setHeight(50),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Color(0xfff2f2f7),
                      hintText: '最高价',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none)),
                  textAlign: TextAlign.center,
                  controller: maxTextController,
                  onChanged: (value) {
                    provider.priceRangeActiveList['id'] = widget.data['id'];
                    provider.priceRangeActiveList['name'] = widget.data['name'];
                    provider.priceRangeActiveList['max'] = value;
                    print('priceRangeActiveList:${provider.priceRangeActiveList}');
                  },
                  onEditingComplete: () {},
                  onSubmitted: (v) {
                    print('onsubMitted: $v');
                  },
                ),
              )
            ],
          );
        }));
  }

  Widget _priceRangeChoiceWidget(data, context) {
    List<Widget> list = data.map<Widget>((item) {
      return Provide<CategoryNavBarFilterProvide>(
        builder: (context, child, provider) {
          return InkWell(
            onTap: () {
              // print('${textController.text}');
              var arr = item['value'].split('-');
              setState(() {
                minTextController.text = arr.first;
                maxTextController.text = arr.last;
                provider.priceRangeActiveList['id'] = widget.data['id'];
                provider.priceRangeActiveList['name'] = widget.data['name'];
                provider.priceRangeActiveList['activeValue'] = item['value'];
                provider.priceRangeActiveList['max'] = maxTextController.text;
                provider.priceRangeActiveList['min'] = minTextController.text;
              });
              print('priceRangeActiveList:${provider.priceRangeActiveList}');
            },
            child: Container(
              width: ScreenUtil().setWidth(730 / data.length - 80),
              height: ScreenUtil().setHeight(80),
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: provider.priceRangeActiveList['activeValue'] == item['value']
                      ? Color(0XFFFDF0F0)
                      : Color(0xfff2f2f7),
                  border: Border.all(
                      color: provider.priceRangeActiveList['activeValue'] == item['value']
                          ? Color(0XFFC81623)
                          : Color(0xfff2f2f7)),
                  borderRadius: BorderRadius.circular(50.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(item['title'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: provider.priceRangeActiveList['activeValue'] == item['value']
                              ? Color(0XFFC81623)
                              : Colors.black87)),
                  Text(item['subTitle'],
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          color: provider.priceRangeActiveList['activeValue'] == item['value']
                              ? Color(0XFFC81623)
                              : Color(0xff888888)))
                ],
              ),
            ),
          );
        },
      );
    }).toList();
    return data.length != 0
        ? Wrap(
            spacing: 3,
            children: list,
          )
        : Container();
  }
}
