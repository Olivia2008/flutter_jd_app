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
  int tabIndex;
  bool tabActive = false;
  bool isFold = true;
  bool isVideoInit = false;
  Map selectedList = {
    'color': '黑色',
    'storage': '128GB',
    'methods': '公开版',
    'match': '官方标配',
    'weight': '0.47kg',
    'count': '1',
    'service': []
  };

  String addr = '';

  changeVideoInit(bool bo) {
    isVideoInit = bo;
    notifyListeners();
  }

  changeFold(bool fold) {
    isFold = fold;
    notifyListeners();
  }
  getGoodsCommentDetail(String goodsId)  async{
    var params = {'goodsId': goodsId};
    await request('cateGoodsCommentDetail', params: params).then((value) {
      var data = json.decode(value.toString());
      goodsInfo = GoodsCommentDetailModel.fromJson(data);
      print('goodsInfo数据请求完成 .............');
      notifyListeners();
    });
  }
  getGoodsInfo(GoodsCommentDetailModel data) {
    goodsInfo = data;
    notifyListeners();
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

  getSelectedList(Map list) {
    selectedList = list;
    notifyListeners();
  }
  getSelectedServiceList(List list) {
    selectedList['service'] = list;
    notifyListeners();
  }

  getAddress(String ad) {
    addr = ad;
    notifyListeners();
  }

}
