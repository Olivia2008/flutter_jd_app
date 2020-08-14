import 'package:flutter/material.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class CategoryNavBarFilterProvide with ChangeNotifier {
  Map navBarFilterList = null;
  List navBarFilterMoreList = [];
  List navBarFilterOtherList = [];
  bool isShowInnerDrawer = false;
  String moreValue = '';
  Map navBarFilterCateActiveList = {'id': '', 'name': '', 'activeValue': '', 'activeTitle': ''};
  List navBarFilterAcitveList = [];
  Map priceRangeActiveList = {'id': '', 'name': '', 'min': null, 'max': null, 'activeValue': ''};
  Map serviceDiscountActiveList = {'id': '', 'name': '', 'activeValue': []};
  Map brandActiveList = {'id': '', 'name': '', 'titleList': [], 'valueList': []};
  Map tempBrandActiveList = {'titleList': [], 'valueList': []};
  List otherActiveList = [];
  List filterActiveList = [];
  getTempBrandActiveList(Map data) {
    tempBrandActiveList = data;
    notifyListeners();
  }

  getFilterServiceActiveList(Map data) {
    serviceDiscountActiveList = data;
    notifyListeners();
  }
  getFilterActiveList(List data) {
    navBarFilterAcitveList = data;
    notifyListeners();
  }

  getFilterBrandActiveLis(Map data) {
    brandActiveList = data;
    notifyListeners();
  }

  getFilterPriceActiveList(Map data) {
    priceRangeActiveList = data;
    notifyListeners();
  }
  getFilterCateActiveList(Map data) {
    navBarFilterCateActiveList = data;
    notifyListeners();
  }

  getFilterOtherActiveList(List data) {
    otherActiveList = data;
    notifyListeners();
  }
  
  getFilterOtherList(List data) {
    navBarFilterOtherList = data;
    notifyListeners();
  }
  resetActiveList() {
    serviceDiscountActiveList = {'id': '', 'name': '', 'activeValue': []};
    priceRangeActiveList = {'id': '', 'name': '', 'min': null, 'max': null, 'activeValue': ''};
    brandActiveList = {'id': '', 'name': '', 'titleList': [], 'valueList': []};
    navBarFilterCateActiveList = {'id': '', 'name': '', 'activeValue': '', 'activeTitle': ''};
    otherActiveList = [];
    notifyListeners();
  }
  confirmActiveList() {
    if(serviceDiscountActiveList['activeValue'].length != 0) filterActiveList.add(serviceDiscountActiveList);
    if(priceRangeActiveList['min'] != null || priceRangeActiveList['max'] != null) filterActiveList.add(priceRangeActiveList);
    if(brandActiveList['valueList'].length != 0) filterActiveList.add(brandActiveList);
    if(navBarFilterCateActiveList['activeValue'] != '') filterActiveList.add(navBarFilterCateActiveList);
    if(otherActiveList.length != 0 ) {
      otherActiveList.removeWhere((item) => item['valueList'].length == 0);
      filterActiveList.insertAll(filterActiveList.length, otherActiveList);
    }
    print('filterActiveList:$filterActiveList');
    notifyListeners();
  }
  getFilterList(Map data) async {
    await request('categoryNavTop',params: data).then((res) {
      var data = json.decode(res.toString());
      navBarFilterList = data['data']['result'];
      print('详情分类页头部过滤导航请求完成。。。。。。。');
      notifyListeners();
    });
  }

  getInnerDrawer(bool isShow) {
    isShowInnerDrawer = isShow;
    notifyListeners(); 
  }
  getNavTopFilterMore(Map data) async{
    await request('categoryNavTopMore', params: data).then((res) {
      var data = json.decode(res.toString());
      navBarFilterMoreList = (data['data']['result']['filterMore'] as List).cast();
      print('navBarFilterMoreList:$navBarFilterMoreList');
      print('详情分类页头部过滤导航右侧抽屉中更多分类数据请求完成.....');
      notifyListeners();
    });
    // return navBarFilterMoreList;
  }

  getFilterMoreList(List data) {
    navBarFilterMoreList = data;
    notifyListeners();
  }
  getMoreValue(String v) {
    moreValue = v;
    notifyListeners();
  }
}