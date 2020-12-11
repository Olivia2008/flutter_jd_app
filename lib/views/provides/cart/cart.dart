
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:netease_news/views/model/cart.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double allPrice = 0;
  int allCount = 0;
  bool isAllCheck = true;

  save(goodsId, goodsName, count, price, images, selectedString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    // String -> List<Map>
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    // index
    int ival = 0;
    allPrice = 0;
    allCount = 0;

    // tempList, cartList 添加Map
    // 商品加入了购物车，数量++
    tempList.forEach((item) {
      if(item['goodsId'] == goodsId) {
        tempList[ival]['count']++;
        cartList[ival].count++;
        isHave = true;
      }

      // 如果选中,allcount, allprice相应变化
      if(item['isCheck']) {
        allPrice += (cartList[ival].count * cartList[ival].price);
        allCount += cartList[ival].count;
      }
      ival++;
    });

    // 如果商品没有加入购物车,加入商品信息
    if(!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'price': price,
        'count': count,
        'images': images,
        'selectedString': selectedString,
        'isCheck': true
      };

      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      allPrice += (count * price);
      allCount += count; 
    }

    // 持久化set，String类型
    cartString = json.encode(tempList).toString();
    print('字符串类型>>>>>>>>>>>$cartString');
    print('model类型>>>>>>>>>>>$cartList');
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  getCartInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if(cartString == null) {
      cartList = [];
    } else {
      // String --> List<Map>
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

      // reset init data
      allCount = 0;
      allPrice = 0;
      isAllCheck = true;

      // 如果每条商品选中或未选中更改全选状态及allPrice, allCount
      tempList.forEach((item) {
        if(item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
}