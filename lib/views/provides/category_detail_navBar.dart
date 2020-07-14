import 'package:flutter/material.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class CategoryNavBarFilterProvide with ChangeNotifier {
  Map navBarFilterList = null;
  getFilterList(Map data) {
    request('categoryNavTop',params: data).then((res) {
      var data = json.decode(res.toString());
      navBarFilterList = data['data']['result'];
      print('详情分类页头部过滤导航请求完成。。。。。。。');
      notifyListeners();
    });
  }
}