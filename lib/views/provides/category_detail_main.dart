import 'package:flutter/material.dart';
import 'package:netease_news/views/model/category_detail_main.dart';

class CategoryDetailMainProvide with ChangeNotifier {

  List<Summary> summaryList = [];
  List navBarBrandCheckedList = [];
  bool confirmBool = false;
  getSummaryList(List list) {
    summaryList = list;
    notifyListeners();
  }
 getMoreSummaryList(List<Summary> list) {
    summaryList.addAll(list);
    notifyListeners();
  }
 getNavBarBrandCheckedList(List data) {
   navBarBrandCheckedList = data;
   notifyListeners();
 }
 changeConfirmBool (bool data) {
   confirmBool = data;
   notifyListeners();
 }

}