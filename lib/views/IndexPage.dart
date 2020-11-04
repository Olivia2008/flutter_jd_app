import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/pages/cart_page.dart';
import 'package:netease_news/views/pages/category_page.dart';
import 'package:netease_news/views/pages/home_page.dart';
import 'package:netease_news/views/pages/member_page.dart';
import 'package:netease_news/views/pages/search_page.dart';
import 'package:netease_news/views/test/test_customSliverScrollView.dart';
import 'package:netease_news/views/test/test_canvas.dart';
import 'package:netease_news/views/test/test_tabbar_pageview.dart';
import 'dart:ui';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
    BottomNavigationBarItem(title: Text('分类'), icon: Icon(Icons.select_all)),
    BottomNavigationBarItem(title: Text('发现'), icon: Icon(Icons.location_searching)),
    BottomNavigationBarItem(
        title: Text('购物车'), icon: Icon(Icons.shopping_cart)),
    BottomNavigationBarItem(
        title: Text('我的'), icon: Icon(Icons.perm_identity)),
    // BottomNavigationBarItem(title: Text('下拉菜单'), icon: Icon(Icons.location_searching))
  ];

// 注意tabBody里面的顺序要与设计一致，默认显示首页, CustomScrollViewTestRoute暂时代替CartPage
  final List<Widget> tabBody = [HomePage(), CategoryPage(), CanvasApp(),CustomScrollViewTestRoute(), TestTabPage()];

  int activeIndex = 0;
  var currentPage;
  TextEditingController searchController = TextEditingController();
  String globalSearchText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = tabBody[activeIndex];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    print('设备像素密度：${ScreenUtil.pixelRatio}\n'
        '设备的宽：${ScreenUtil.screenWidth}\n'
        '设备的高: ${ScreenUtil.screenHeight}\n'
        '实际window的width: ${window.physicalSize.width / window.devicePixelRatio}\n'
        '实际window的height: ${window.physicalSize.height / window.devicePixelRatio}\n'
        '状态栏高度：${ScreenUtil.statusBarHeight}px\n'
        '实际宽度dp与设计稿px的比例：${ScreenUtil().scaleWidth}\n'
        '实际高度dp与设计稿px的比例：${ScreenUtil().scaleHeight}\n'
        'iphone6 750*1334设计稿公式宽750=${MediaQuery.of(context).size.width} / ${ScreenUtil().scaleWidth}');
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        // 注意items是个list
        items: bottomTabs,
        currentIndex: activeIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            activeIndex = index;
            currentPage = tabBody[activeIndex];
          });
        },
      ),
//      appBar: AppBar(
//        title: Text('JD',style: TextStyle(color: Colors.white),),
//      ),
      // 注意页面的呈现用body
      body: IndexedStack(
        index: activeIndex,
        children: tabBody,
      ),
    );
  }
}
