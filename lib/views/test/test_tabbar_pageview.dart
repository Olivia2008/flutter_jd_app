import 'package:flutter/material.dart';
import './test_tabone.dart';
import './test_tabtwo.dart';

class TestTabPage extends StatefulWidget {
  @override
  _TestTabPageState createState() => _TestTabPageState();
}

class TabTitle {
  String title;
  int id;

  TabTitle(this.title, this.id);
}

class _TestTabPageState extends State<TestTabPage> with TickerProviderStateMixin{
  // TabController _tabController;
  // PageController _pageController;
  // var currentPage = 0;
  // var isChangePage = true;
  // List<Widget> _pageList = [TestTabOne(), TestTabTwo()];
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  List<TabTitle> tabList;
  var currentPage = 0;
  var isPageCanChanged = true;
  
  @override
  void initState() {
    // _tabController = TabController(length: 2, vsync: this);
    // _pageController = PageController();

    // _tabController.addListener(() { 
    //   if(_tabController.indexIsChanging) {
    //     onChangePage(_tabController.index, p: _pageController);
    //   }
    // });

    initTabData();
    mTabController = TabController(
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {//TabBar的监听
      if (mTabController.indexIsChanging) {//判断TabBar是否切换
        print(mTabController.index);
        onPageChange(mTabController.index, p: mPageController);
      }
    });
    super.initState();
  }

  initTabData() {
    tabList = [
      new TabTitle('推荐', 10),
      new TabTitle('热点', 0),
      new TabTitle('社会', 1),
      new TabTitle('娱乐', 2),
      new TabTitle('体育', 3),
      new TabTitle('美文', 4),
      new TabTitle('科技', 5),
      new TabTitle('财经', 6),
      new TabTitle('时尚', 7)
    ];
  }
  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      await mPageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index);//切换Tabbar
    }
  }

  @override
  void dispose() {
    // _tabController.dispose();
    // _pageController.dispose();
    mTabController.dispose();
    mPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        backgroundColor: Color(0xffd43d3d),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.all_inclusive),
        backgroundColor: Color(0xffd43d3d),
        elevation: 2.0,
        highlightElevation: 2.0,
        onPressed: () {},
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: new Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: mTabController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: tabList.length,
              onPageChanged: (index) {
                if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                  onPageChange(index);
                }
              },
              controller: mPageController,
              itemBuilder: (BuildContext context, int index) {
                return Text(tabList[index].title);
              },
            ),
          )
        ],
      ),
    );
  }

  // onChangePage(int index, {PageController p, TabController t}) async{
  //   if(p != null) {
  //     isChangePage = false;
  //     await _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
  //     isChangePage = true;
  //   } else {
  //     _tabController.animateTo(index);
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('tab bar scroll vertical'),
  //       bottom: TabBar(
  //         controller: _tabController,
  //         isScrollable: true,
  //         tabs: [
  //           Text('tabone'),
  //           Text('tabtwo')
  //         ],
  //       )
  //     ),
  //     body: TabBarView(
  //       controller: _tabController,
  //       children: List.generate(2, (index) {
  //         return SafeArea(
  //           top: false,
  //           bottom: false,
  //           child: PageView.builder(
  //             controller: _pageController,
  //             onPageChanged: (index) {
  //               if(isChangePage) {
  //                 onChangePage(index);
  //               }
  //             },
  //             itemCount: 2,
  //             itemBuilder: (context, idx) {
  //               return _pageList[idx];
  //             },
  //           )
  //           );
  //       })
  //     ),
  //   );
  // }
}