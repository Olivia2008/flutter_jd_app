import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'dart:convert';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:async';
import 'package:provide/provide.dart';

class InnerDrawer extends StatefulWidget {
  
  @override
  _InnerDrawerState createState() => _InnerDrawerState();
}

class _InnerDrawerState extends State<InnerDrawer> {
  List dataList = [];
  Map activeData = {'id': '', 'active': {'id': '', 'title': ''}};
  Map params = {
    'id': '',
    'subId': '',
    'goodId': '',
    'filId': '',
    'allCateId': '',
    'moreId': ''
  };
  @override
  void initState() {
    // _getListData();
    super.initState();
  }

  void _getListData() async {
    var arr = Provide.value<CategoryNavBarFilterProvide>(context)
        .moreValue
        .split('_');
    params['id'] = arr[0];
    params['subId'] = arr[1];
    params['goodId'] = arr[2];
    params['filId'] = arr[3];
    params['allCateId'] = arr[4];
    params['moreId'] = arr[5];
    await request('categoryNavTopMore', params: params).then((res) {
      var data = json.decode(res.toString());
      dataList = data['data']['result']['filterMore'];
      if (dataList.length != 0)
        Provide.value<CategoryNavBarFilterProvide>(context)
            .getFilterMoreList(dataList);
      print('详情分类页头部过滤导航右侧抽屉中更多分类数据请求完成.....');
    });
  }

  Future _getList() async {
    var arr = Provide.value<CategoryNavBarFilterProvide>(context)
        .moreValue
        .split('_');
    params['id'] = arr[0];
    params['subId'] = arr[1];
    params['goodId'] = arr[2];
    params['filId'] = arr[3];
    params['allCateId'] = arr[4];
    params['moreId'] = arr[5];
    await request('categoryNavTopMore', params: params).then((res) {
      var data = json.decode(res.toString());
      dataList = (data['data']['result']['filterMore'] as List).cast();
      print('详情分类页头部过滤导航右侧抽屉中更多分类数据请求完成.....');
      // return navBarFilterMoreList;
    });
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      width: MediaQuery.of(context).size.width / 4 * 3,
      height: MediaQuery.of(context).size.height,
      child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0)),
            color: Colors.white,
          ),
          child: Column(children: <Widget>[_titleWidget(), _mainWidget()])),
    );
  }

  Widget _titleWidget() {
    return Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(120),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: IconButton(
                alignment: Alignment.center,
                color: Color(0xff333333),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 4 * 3 - 90,
                  child: Text(
                    '更多分类',
                    style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                    textAlign: TextAlign.center,
                  ))
            ]));
  }

  Widget _mainWidget() {
    return FutureBuilder(
        future: _getList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? Container(
                      height: MediaQuery.of(context).size.height -
                          ScreenUtil().setHeight(120) -
                          40,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return _mainListView(snapshot.data[index]);
                          },
                          itemCount: snapshot.data.length))
                  : Center(child: Text('no data....'))
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget _mainListView(data) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(data['title'],
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    fontWeight: FontWeight.w600))),
        Container(
            width: MediaQuery.of(context).size.width / 4 * 3 - 40,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xfff5f5f5))))),
        Column(
            children: data['list'].map<Widget>((item) {
          return Provide<CategoryNavBarFilterProvide>(
            builder: (context, child, provider) {
              return InkWell(
              onTap: () {
                setState(() {
                  // activeData['id'] = data['value'];
                  // activeData['active']['id'] = item['value'];
                  // activeData['active']['title'] = item['title'];
                  provider.navBarFilterCateActiveList['activeValue'] = item['value'];
                  provider.navBarFilterCateActiveList['activeTitle'] = item['title'];
                });
                provider.getInnerDrawer(false);
                print('filter category more provide activedata: ${provider.navBarFilterCateActiveList}');
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    provider.navBarFilterCateActiveList['activeValue'] == item['value'] ? Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.done, color: Colors.red),
                    ) : Container(),
                    Text(item['title'], style: TextStyle(fontSize: ScreenUtil().setSp(28)))
                  ],
                ),
              ));
            }
          );
        }).toList())
      ],
    ));
  }
}
