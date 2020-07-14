import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'handler.dart';

class Routes {
  static String home = '/';
  static String categoryDetailsPage = '/categoryDetails';
  static void configureRoutes(Router router){
    // 找不到路由时
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR==>ROUTES WAS NOT FOUND!!');
      }
    );
    // 配置category details 页面路由categoryDetailHandler是handler.dart中
    router.define(categoryDetailsPage, handler: categoryDetailHandler);
  }
}