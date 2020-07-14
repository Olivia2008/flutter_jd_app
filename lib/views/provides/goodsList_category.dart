import 'package:flutter/material.dart';
import 'package:netease_news/views/model/category_goods_list.dart';
class GoodsListProvide extends ChangeNotifier {
  List<Result> goodsList = [];
  // 点击横向导航更换商品列表
  getGoodsList(List list) {
    goodsList = list;
    notifyListeners();
  }
  getMoreGoodsList(List<Result> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}