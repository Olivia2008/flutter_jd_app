import 'package:flutter/material.dart';
import 'package:netease_news/views/model/category_nav_list.dart';
class SubchildCategory extends ChangeNotifier {
  List<SubList> subList = [];
  int pareId = 0;
  int subListIndex = 0; // 横向导航的index
  int subId = 0;
  int page = 1; // 列表页数
  String noMoreText = ''; // 显示没有数据
  getSubListCategoryList(List list, int id, int subIndex, int subid) {
    subId = subid;
    page = 1;
    noMoreText = '';
    pareId = id;
    subList = list;
    subListIndex = subIndex;
    notifyListeners();
  }
  // 增加page
  addPage() {
    page++;
  }
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
  changePage(int num) {
    page = num;
    notifyListeners();
  }
}