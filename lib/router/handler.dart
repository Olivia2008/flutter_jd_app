import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:netease_news/views/pages/category/every_category.dart';
// import 'package:netease_news/views/pages/components/Home/category/category_detail.dart';
// 引入使用路由的组件页面

Handler categoryDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  // String goodsId = params['id'].first;
  // print('category_detail_params: $params');
  return CategoryDetails(params);
});