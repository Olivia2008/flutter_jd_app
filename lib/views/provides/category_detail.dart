import 'package:flutter/material.dart';
import 'package:netease_news/views/model/categoryDetail.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class CategoryDetailProvide with ChangeNotifier {
  CategoryDetailModel cateDetailList = null;
  getCategoryDetailList(Map data) {
    request('categoryListDetail',params: data).then((res) {
      var data = json.decode(res.toString());
      // print(data);
      cateDetailList = CategoryDetailModel.fromJson(data);
      notifyListeners();
    });
  }
}