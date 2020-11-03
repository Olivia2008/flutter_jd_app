import 'package:flutter/material.dart';
import 'package:netease_news/views/pages/components/Home/day_stroll.dart';
import 'package:netease_news/views/pages/components/Home/express.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './components/Home/SwiperDiy.dart';
import './components/Home/TopBar.dart';
import './components/Home/ad_banner.dart';

import 'components/Home/home_recommend.dart';
import 'components/Home/new_person.dart';
import 'components/Home/owner_yard.dart';
import 'components/Home/day_stroll.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 缓存
  String homePageContent = '正在获取数据';
  Map<String, dynamic> param = {'page': 1, 'pageSize': 20};
  List<Map> recommendList = [];
  EasyRefreshController _refreshController;
  TextEditingController searchController = TextEditingController();
  String globalSearchText = '';
  @override
  void initState() {
    // 获取后端数据
    _getRecommendData('homePageRecommend', param);
    // TODO: implement initState
    super.initState();
    _refreshController = EasyRefreshController();
  }

  // 获取推荐数据
  void _getRecommendData(url, params) {
    request(url, params: params).then((res) {
      // print('开始刷新');
      var data = json.decode(res.toString());
      List<Map> newRecommendList = (data['data']['list'] as List).cast();
      setState(() {
        recommendList.addAll(newRecommendList);
        param['page']++;
      });
      print('首页推荐数据请求完成........');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JD'),
      ),
      // SingleChildScrollView与Listview有冲突，不能同时使用
      backgroundColor: Color(0xFFF6F6F6),
      body: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: FutureBuilder(
            future: request('homePageContent'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // 数据处理
                List<Map> swiper = (snapshot.data['data']['carousel'] as List).cast();
                List<Map> topNavList = (snapshot.data['data']['category'][0]['page'] as List).cast();
                List<Map> seconds = (snapshot.data['data']['seconds']['list'] as List).cast();
                List<Map> newsData = (snapshot.data['data']['newPerson'] as List).cast();
                List<Map> floorData = (snapshot.data['data']['newAdds'] as List).cast();
                // Map<String, dynamic> ownerOne = (snapshot.data['data']['ownersGard'] as Map).cast();
                List<Map> ownerOne = (snapshot.data['data']['ownersGard']['listOne'] as List).cast();
                List<Map> ownerTwo = (snapshot.data['data']['ownersGard']['listTwo'] as List).cast();
                List<Map> dayStroll = (snapshot.data['data']['dayStroll'] as List).cast();
                List<Map> express = (snapshot.data['data']['express'] as List).cast();
                // print(express);
                return EasyRefresh(
                  controller: _refreshController,
                  footer: ClassicalFooter(
                    bgColor: Theme.of(context).primaryColor,
                    infoColor: Colors.white,
                    textColor: Colors.white, // 加载完成的信息颜色
                    showInfo: true,
                    noMoreText: '没有更多了',
                    // infoText: '更多信息加载中....',
                    loadReadyText: '上拉加载....',
                    loadingText: '加载中.....',
                    loadFailedText: '加载失败',
                    loadedText: '加载完成'

                  ),
                  child: ListView(
                    children: <Widget>[
                      SwiperDiy(swiper),
                      TopNav(navigatorList: topNavList,),
                      ADBanner(secondsList: seconds,),
                      NewPerson(dataList: newsData,floorData: floorData,),
                      OwnerYard(dataListOne: ownerOne, dataListTwo: ownerTwo,),
                      // OwnerYard(dataList: ownerOne,)
                      DayStroll(data: dayStroll,),
                      Express(data: express,),
                      HomeRecommend(param: param, recommendList: recommendList,)
                      // HomeRecommend()
                    ],
                  ),
                  onLoad: () async{
                    // print('开始加载.....');
                    request('homePageRecommend', params: param).then((res) {
                      // json.decode解析json为Iterable<Map<dynamic, dynamic>>
                      var data = json.decode(res.toString());
                      // print(data);
                      List<Map> newRecommendList = (data['data']['list'] as List).cast();
                      // print('加载前的数据:${recommendList.length};\npageNum:${param['page']}');
                      // List<Map> newRecommendList = recommendList;
                      // 将新数据与原数据合并，并++page
                      setState(() {
                        recommendList.addAll(newRecommendList);
                        param['page']++;
                      });
                      // print('加载完成后的数据：${recommendList.length};\n pageNum: ${param['page']}');
                      if (param['page'] > 5) {
                        _refreshController.finishLoad(noMore: true, success: false);
                      } else {
                        _refreshController.finishLoad(noMore: param['page'] > 5,);
                      }
                      print('首页推荐部分上拉加载数据请求完成.......');
                    });
                  },
                  onRefresh: () async{
                    // print('开始刷新....');
                    recommendList.clear();
                    param['page'] = 0;
                    // print('刷新完成后的数据:${recommendList.length}');
                    _refreshController.finishLoad(noMore: param['page'] > 5,);
                    // _refreshController.callLoad(duration: Duration(milliseconds: 500));
//                    param['page'] = 1;
//                    print(param);
//                    // 重新获取第一页
//                    request('homePageRecommend', params: param).then((res) {
//                      // json.decode解析json为Iterable<Map<dynamic, dynamic>>
//                      var data = json.decode(res.toString());
//                      // print(data);
//                      List<Map> newRecommendList = (data['data']['list'] as List).cast();
//                      // 将新数据与原数据合并，并++page
//                      recommendList = newRecommendList;
//                      print('刷新后再请求的第一页数据:$recommendList');
//                    });
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
