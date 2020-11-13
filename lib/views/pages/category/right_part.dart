import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/router/staticRouter.dart';
import 'package:netease_news/views/model/category_goods_list.dart';
import 'package:netease_news/views/provides/goodsList_category.dart';
import 'package:netease_news/views/provides/subList_category.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RightPart extends StatefulWidget {
  @override
  _RightPartState createState() => _RightPartState();
}

class _RightPartState extends State<RightPart> {
  EasyRefreshController _controller;
  var scrollController = new ScrollController();
  ScrollController navBarController;
  bool active = true;
  int rightNavIndex = 0;
  Map params = {"id": 1, "subId": 1, "page": 1, "pageSize": 20};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    navBarController = ScrollController();
    active = true;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    navBarController.dispose();
  }

  void _getCategoryMainList(paramData) async {
    await request('categoryMainList', params: paramData).then((res) {
      var data = json.decode(res.toString());
      GoodsListModel list = GoodsListModel.fromJson(data);
      if (list.data.result != null) {
        Provide.value<GoodsListProvide>(context).getGoodsList(list.data.result);
      }
      print('右侧顶层导航index变化后请求主体数据完成.......');
    });
  }

  void _getMoreList() async {
    Provide.value<SubchildCategory>(context).addPage();
    params['id'] = Provide.value<SubchildCategory>(context).pareId;
    params['subId'] = Provide.value<SubchildCategory>(context).subId;
    params['page'] = Provide.value<SubchildCategory>(context).page;
    await request('categoryMainList', params: params).then((res) {
      var data = json.decode(res.toString());
      // print(data);
      GoodsListModel list = GoodsListModel.fromJson(data);
      if (list.data.result.length == 0) {
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Provide.value<SubchildCategory>(context).changeNoMore('没有更多了...');
        // print(Provide.value<SubchildCategory>(context).noMoreText);

      } else {
        Provide.value<GoodsListProvide>(context)
            .getMoreGoodsList(list.data.result);
        // print(Provide.value<GoodsListProvide>(context).goodsList.length);
        // _controller.finishLoad(noMore: true);
      }
      print('加载更多主体数据请求完成.....');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(564),
      margin: EdgeInsets.only(left: 6),
      child: Column(
        children: <Widget>[
          _navBar(),
          Container(
              height: ScreenUtil().setHeight(1334) - ScreenUtil.statusBarHeight * 2 - ScreenUtil().setHeight(230),
              // height: MediaQuery.of(context).size.height -
              //     ScreenUtil().setHeight(230) -
              //     ScreenUtil.statusBarHeight * 2,
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: Provide<GoodsListProvide>(builder: (context, child, list) {
                // 返回顶部
                if (scrollController.hasClients) {
                  if (Provide.value<SubchildCategory>(context).page == 1) {
                    scrollController.jumpTo(0.0);
                  }
                }
                return list.goodsList.length != 0
                    ? EasyRefresh(
                        // enableControlFinishLoad: true,
                        controller: _controller, // 控制easyRefresh
                        header: ClassicalHeader(),
                        footer: ClassicalFooter(
                          bgColor: Theme.of(context).primaryColor,
                          infoColor: Colors.white,
                          textColor: Colors.white,
                          // 加载完成的信息颜色
                          loadText: 'loadText',
                          noMoreText: Provide.value<SubchildCategory>(context)
                              .noMoreText,
                          // infoText: 'Success',
                          loadReadyText: '上拉加载....',
                          loadingText: '加载中.....',
                          loadFailedText: '加载失败',
                          loadedText: '加载完成',
                        ),
                        onRefresh: () async {
                          print('refresh');
                          Provide.value<GoodsListProvide>(context)
                              .goodsList
                              .clear();
                          // print(Provide.value<GoodsListProvide>(context).goodsList.length);
                          params['page'] = 1;
                          Provide.value<SubchildCategory>(context)
                              .changePage(1);
                          _getCategoryMainList(params);
                          _controller.finishLoad(noMore: false);
                        },
                        onLoad: () async {
                          print('onload');
                          // print(Provide.value<GoodsListProvide>(context).goodsList.length);
                          _getMoreList();
                        },
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: <Widget>[_wrapList(list.goodsList)],
                        ),
                      )
                    : Center(child: CircularProgressIndicator());
              }))
        ],
      ),
    );
  }

  Widget _navBar() {
    return Container(
        height: ScreenUtil().setHeight(92),
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Provide<SubchildCategory>(
          builder: (context, child, list) {
            if (navBarController.hasClients) {
              if (Provide.value<SubchildCategory>(context).subListIndex == 0) {
                navBarController.jumpTo(0.0);
              }
              // 另一种滚动方法
//              if(Provide.value<SubchildCategory>(context).subListIndex == 0) {
//                navBarController.animateTo(
//                  0.0,
//                  curve: Curves.easeOut,
//                  duration: const Duration(milliseconds: 300),
//                );
//              }
            }
            return ListView.builder(
              controller: navBarController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                active = (index == list.subListIndex) ? true : false;
                return InkWell(
                  onTap: () {
                    setState(() {
                      list.subListIndex = index;
                      params['id'] = list.pareId;
                      params['subId'] = int.parse(list.subList[index].id);
                      params['page'] = 1;
                      Provide.value<SubchildCategory>(context)
                          .getSubListCategoryList(list.subList, list.pareId,
                              index, int.parse(list.subList[index].id));
                      _getCategoryMainList(params);
                      // print(params);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(92),
                    padding: EdgeInsets.only(left: 3, right: 3),
                    margin: EdgeInsets.only(left: 3, right: 3),
                    decoration: BoxDecoration(
                        color: active == true
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3.0)),
                    child: Text(
                      list.subList[index].title,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: active ? Colors.white : Color(0xFF333333)),
                    ),
                  ),
                );
              },
              itemCount: list.subList.length,
            );
          },
        ));
  }

  Widget _wrapList(listData) {
    List<Widget> listWidget = listData.map<Widget>((item) {
      return InkWell(
        onTap: () {
          var pareId = Provide.value<SubchildCategory>(context).pareId,
              subId = Provide.value<SubchildCategory>(context).subId,
              categoryId = item.goodId;
          // print('pareId: ${pareId.runtimeType}, subId: ${subId.runtimeType}, categoryId: ${categoryId.runtimeType}');
          if (pareId == 1 && subId == 1 && categoryId == '10001') {
            StaticRouter.router.navigateTo(context,
                '/categoryDetails?pareId=$pareId&subId=$subId&categoryId=$categoryId', transition: TransitionType.fadeIn);
          } else {
            Fluttertoast.showToast(
                msg: "抱歉，只有热门推荐-热门分类-手机有数据",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: ScreenUtil().setWidth(180),
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/lazy.png',
                      image: item.img,
                      fit: BoxFit.fill)),
              Text(
                item.title,
                style: TextStyle(
                    color: Color(0xFF333333), fontSize: ScreenUtil().setSp(22)),
              )
            ],
          ),
        ),
      );
    }).toList();
    return Wrap(
      spacing: 3, // 水平方向间距
      runSpacing: 1,
      children: listWidget,
    );
  }
}
