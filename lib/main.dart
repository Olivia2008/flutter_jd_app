import 'package:flutter/material.dart';
import 'package:netease_news/router/index.dart';
import 'package:netease_news/views/RecentPage.dart';
import 'package:netease_news/views/IndexPage.dart';

import 'package:provide/provide.dart';
import 'router/staticRouter.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'package:netease_news/views/provides/counter.dart';
import 'package:netease_news/views/provides/goodsList_category.dart';
import 'views/provides/category_detail.dart';
import 'views/provides/category_detail_main.dart';
import 'views/provides/subList_category.dart';
import 'views/provides/goods/comment_detail.dart';
import 'views/provides/cart/cart.dart';
import 'package:fluro/fluro.dart';

void main() {
  var counter = Counter();
  var providers = Providers();
  var subListCategory = SubchildCategory();
  var goodListCategory = GoodsListProvide();
  var categoryDetail = CategoryDetailProvide();
  var categoryNavBarFilter = CategoryNavBarFilterProvide();
  var categoryDetailMain = CategoryDetailMainProvide();
  var cateGoodsCommentDetail = GoodsCommentDetailProvide();
  var cartProvide = CartProvide();

  // ..用于多个状态管理时使用
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<SubchildCategory>.value(subListCategory))
    ..provide(Provider<GoodsListProvide>.value(goodListCategory))
    ..provide(Provider<CategoryNavBarFilterProvide>.value(categoryNavBarFilter))
    ..provide(Provider<CategoryDetailProvide>.value(categoryDetail))
    ..provide(Provider<CategoryDetailMainProvide>.value(categoryDetailMain))
    ..provide(Provider<GoodsCommentDetailProvide>.value(cateGoodsCommentDetail))
    ..provide(Provider<CartProvide>.value(cartProvide));
  runApp(ProviderNode(
    providers: providers,
    child: MyHomePage(title: 'Flutter Demo Home Page'),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 页面控制
  PageController _pageController;

  // 页面的index值
  int PageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: PageIndex);
  }

  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
////      body: PageView(
////        controller: _pageController,
////        onPageChanged: (int index) {
////          print('当前点击的页面是$index');
////          setState(() {
////            PageIndex = index;
////          });
////        },
////        children: <Widget>[
////          RecentPage()
////        ],
////      ) // This trailing comma makes auto-formatting nicer for build methods.
//    body: Column(
//      children: <Widget>[
//        RaisedButton(onPressed: () {
//          Navigator.of(context).pushNamed('/recent');
//        },
//        child: Text('Recent Page'),)
//      ],
//    ),
//    );
    final router = Router();
    // index.dart中的Routes类
    Routes.configureRoutes(router);
    // staticRouter.dart中的StaticRouter类
    StaticRouter.router = router;
    return Container(
      child: MaterialApp(
        onGenerateRoute: StaticRouter.router.generator,
        theme: ThemeData(primaryColor: Colors.red),
        title: '网易',
        home: IndexPage(),
        routes: {
          '/recent': (BuildContext context) => RecentPage(),
        },
      ),
    );
  }
}
