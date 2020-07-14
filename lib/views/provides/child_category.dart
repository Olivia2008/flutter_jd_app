import 'package:flutter/material.dart';
import 'package:netease_news/views/model/category_nav_list.dart';
class ChildCategory extends ChangeNotifier {
  List<Result> hotCategoryList = [];
  getHotCategoryData(List list) {
    hotCategoryList = list;
    notifyListeners();
  }
}