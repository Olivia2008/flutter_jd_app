import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'handler.dart';

class Routes {
  static String home = '/';
  static String categoryDetailsPage = '/categoryDetails';
  static String cateGoodsCommentDetailPage = '/cateGoodsDetail';
  static String cateGoodsCommentDetailSearchPage = cateGoodsCommentDetailPage + '/goodsSearch';
  static void configureRoutes(Router router){
    // 找不到路由时
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR==>ROUTES WAS NOT FOUND!!');
      }
    );
    // 配置category details 页面路由categoryDetailHandler是handler.dart中
    router.define(categoryDetailsPage, handler: categoryDetailHandler);
    // 分类-每类-商品详情评价
    router.define(cateGoodsCommentDetailPage, handler: cateGoodsCommentDetailHandler);
    router.define(cateGoodsCommentDetailSearchPage, handler: cateGoodsCommentDetailSearchHandler);
  }
}