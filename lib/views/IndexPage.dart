import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/pages/cart_page.dart';
import 'package:netease_news/views/pages/category_page.dart';
import 'package:netease_news/views/pages/home_page.dart';
import 'package:netease_news/views/pages/member_page.dart';
import 'package:netease_news/views/pages/search_page.dart';
import 'package:netease_news/views/pages/test_customSliverScrollView.dart';

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
  final List<Widget> tabBody = [HomePage(), CategoryPage(), SearchPage(),CustomScrollViewTestRoute(), MemberPage()];

  int activeIndex = 0;
  var currentPage;
  TextEditingController searchController = TextEditingController();
  Dio _dio = Dio();
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
        '设备的高: ${ScreenUtil.screenHeight}');
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
