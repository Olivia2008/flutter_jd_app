import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:netease_news/views/pages/category/every_category.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail.dart';
import 'package:netease_news/components/commentsSearch.dart';
// import 'package:netease_news/views/pages/components/Home/category/category_detail.dart';
// import 'package:netease_news/views/pages/category/every_category/goodsDetail.dart';
// 引入使用路由的组件页面

Handler categoryDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  // String goodsId = params['id'].first;
  // print('category_detail_params: $params');
  return CategoryDetails(params);
});

// 分类-某类-商品详情
Handler cateGoodsCommentDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return GoodsCommentDetail(params);
});

// 分类-某类-商品详情-商品历史搜索
Handler cateGoodsCommentDetailSearchHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  // print('router params:$params');
  var id = params['goodsId'].first;
  return CustomCommentsSearch(goodsId: id);
});