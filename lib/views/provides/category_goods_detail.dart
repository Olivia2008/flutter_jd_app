 import 'package:flutter/material.dart';
 import 'package:netease_news/views/model/GoodsDetailModel.dart';
 import 'package:netease_news/views/service/service_method.dart';
 import 'dart:convert';
 class GoodsDetailProvide with ChangeNotifier {
   GoodsDetailModel goodsInfo = null;
   // 从后台获取商品信息数据
   getGoodsInfo(String goodsId) {
     var params = {'goodsId': goodsId};
     request('goodsDetail', params: params).then((val) {
       var data = json.decode(val.toString());
       goodsInfo = GoodsDetailModel.fromJson(data);
       // print('goodsDetail info:${data}');
       print('goodsInfo加载完成....');
       notifyListeners();
     });
   }
 }