import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:netease_news/views/model/goods_accessory.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class GoodsCommentDetailProvide with ChangeNotifier {
  GoodsCommentDetailModel goodsInfo;
  AccessoryModel accessoryInfo;
  String searchResultText;
  int tabIndex = 0;
  bool tabActive = false;
  getGoodsCommentDetail(String goodsId)  async{
    var params = {'goodsId': goodsId};
    await request('cateGoodsCommentDetail', params: params).then((value) {
      var data = json.decode(value.toString());
      goodsInfo = GoodsCommentDetailModel.fromJson(data);
      print('goodsInfo数据请求完成 .............');
      notifyListeners();
    });
  }

  getGoodsAccessory(String goodsId) async{
    var params = {'goodsId': goodsId};
    await request('goodsAccessory', params: params).then((value) {
      var data = json.decode(value.toString());
      accessoryInfo = AccessoryModel.fromJson(data);
      print('goods accessory数据请求完成.................');
      notifyListeners();
    });
  }

  changeTabIndex(int idx) {
    tabIndex = idx;
    notifyListeners();
  }
  changeTabActive(bool b) {
    tabActive = b;
    notifyListeners();
  }
  getSearchResultText(String txt) {
    searchResultText = txt;
    notifyListeners();
  }
}
