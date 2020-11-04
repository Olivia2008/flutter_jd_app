import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuController.dart';
import 'package:netease_news/components/customDropdownMenu/index.dart';
import 'package:netease_news/components/searchDelegate.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_main.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'package:netease_news/views/pages/category/every_category/filterWidget1.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw.dart';
import 'dart:convert';

import 'every_category/mainWidget.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDetails(this.params);
  final Map params;
  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final controller = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _stackKey = new GlobalKey();
  var navData;
  var optionList;
  // Map _brandActiveList = {'titleList': [], 'valueList': []};
  CustomDropdownMenuController _dropdownMenuController =
      CustomDropdownMenuController();
  ScrollController _scrollController = ScrollController();
  bool confirmBool = false;
  bool showFloatBtn = false;
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 分类详情页头部请求数据参数
    var paramsData = {
      'id': widget.params['pareId'][0],
      'subId': widget.params['subId'][0],
      'goodId': widget.params['categoryId'][0]
    };
    // print(paramsData);
    _getNavData('categoryNavTop', paramsData);
    _scrollController.addListener(handleScrollController);
  }

   void handleScrollController() {
    var _screenHeight = MediaQuery.of(context).size.height - ScreenUtil().setHeight(500);
    if(_scrollController.offset < _screenHeight && showFloatBtn) {
      setState(() {
        showFloatBtn = false;
      });
    } else if(_scrollController.offset >= _screenHeight && showFloatBtn == false) {
      setState(() {
        showFloatBtn = true;
      });
    }
  }

  void _getNavData(path, params) async {
    await request(path, params: params).then((res) {
      var data = json.decode(res.toString());
      setState(() {
        navData = data['data']['result'];
        optionList = (navData['navList2'][2]['optionList'] as List).cast();
      });
      print('/category/detail/topbar请求完成。。。。。。。');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0XFFF5F5F5),
        appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0),
        ),
        endDrawer: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 4, top: 0),
            decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0))),
            child: NavFilterDraw(_scaffoldKey, navData)),
        endDrawerEnableOpenDragGesture: false,
        body: Stack(
          key: _stackKey,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(750),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                            colors: [Color(0xffff627c), Color(0xffff0d0d)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.2, 1])
                    ),
                    child: Row(
                      children: <Widget>[
                        _appBarLeading(context),
                        _appBarTitle(context)
                      ],
                    )),
                Container(
                    width: ScreenUtil().setWidth(750),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(200),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)),
                    ),
                    child: navData != null
                        ? FilterWidget(
                            data: navData,
                            scaffoldKey: _scaffoldKey,
                            stackKey: _stackKey,
                            customDropdownMenuController:
                                _dropdownMenuController,
                          )
                        : Container()),
                Expanded(
                    child: MainWidget(widget.params, _scrollController, page))
              ],
            ),
            // 下拉菜单
            CustomDropdownMenu(
                controller: _dropdownMenuController,
                animationMilliseconds: 300,
                dropdownMenuChanging: (isShow, index, checkedList) {
                  setState(() {
                    // print('正在${isShow ? '显示' : '隐藏'}$index, $checkedList');
                  });
                },
                dropDownMenuChanged: (isShow, index, checkedList) {
                  setState(() {
                    // print('已经${isShow ? '显示' : '隐藏'}$index, $checkedList');
                  });
                },
                menus: [
                  null,
                  null,
                  optionList != null
                      ? CustomDropDownMenuBuilder(
                          dropDownHeight: optionList.length != 0
                              ? 40 * (optionList.length / 4)
                              : 0,
                          dropDownWiget: optionList.length != 0
                              ? _brandWidget(optionList, context)
                              : Container())
                      : null,
                  null
                ]
                // menus: _customDropdownMenuBuilder(navList2)
                )
          ],
        ),
        floatingActionButton:
            showFloatBtn
                ? FloatingActionButton(
                    onPressed: () {
                      if (_scrollController.hasClients) {
                        page = 1;
                        // 可以看到页面滚动
                        // _scrollController.jumpTo(0.0);
                        // 添加滚动的动画
                        _scrollController.animateTo(0.0,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease);
                      }
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.arrow_upward))
                : null);
  }

  _appBarLeading(context) {
    return Container(
      width: ScreenUtil().setWidth(50),
      child: IconButton(
        color: Color(0xffffffff),
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // appBar title widget
  _appBarTitle(context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(660),
      // height: ScreenUtil().setHeight(90),
      margin: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            child: Container(
              height: 34,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 0),
              width: ScreenUtil().setWidth(600),
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Container(
                    child: Transform(
                      transform: Matrix4.identity()..scale(0.8),
                      alignment: Alignment.centerLeft,
                      child: InputChip(
                        backgroundColor: Color(0xff888888),
                        onPressed: () {
                          print('input chip');
                        },
                        onDeleted: () {},
                        label: Text(
                          '手机',
                        ),
                        labelStyle:
                            TextStyle(color: Colors.white),
                        deleteIcon: Icon(
                          Icons.close,
                          size: ScreenUtil().setSp(26),
                        ),
                        deleteIconColor: Colors.white)
                    ),
                  ),
                  Container(
                    child: IconButton(
                      color: Color(0xffF8F8F8),
                      icon: Icon(
                        Icons.camera_alt,
                        size: ScreenUtil().setSp(40),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(50),
            child: IconButton(
                alignment: Alignment.topCenter,
                color: Color(0xffffffff),
                icon: Icon(
                  Icons.more_horiz,
                  size: 22,
                ),
                onPressed: () {
                  print('bbbb');
                }),
          )
        ],
      ),
    );
  }

  _customDropdownMenuBuilder(data) {
    // print(data);
    List<CustomDropDownMenuBuilder> menuBuilder;
    if (data.length != 0) {
      menuBuilder = data.map<CustomDropDownMenuBuilder>((item) {
        return CustomDropDownMenuBuilder(
            dropDownHeight: item['optionList'] != null
                ? 40 * (item['optionList'].length / 2)
                : 0,
            dropDownWiget: item['optionList'] != null
                ? _brandWidget(
                    item['optionList'], 40 * (item['optionList'].length / 2))
                : Container());
      }).toList;
    }
    return menuBuilder;
  }

  // brand widdget
  Widget _brandWidget(data, context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 40),
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[_brandWrapList(data, context)],
          ),
        ),
        Positioned(
          bottom: 0,
          child: _buttons(data, context),
        )
      ],
    );
  }

  _brandWrapList(data, context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;
    List<Widget> list = data.map<Widget>((item) {
      return Provide<CategoryNavBarFilterProvide>(
          builder: (context, child, provider) {
        return InkWell(
            onTap: () {
              setState(() {
                if (provider.brandActiveList['valueList']
                        .indexOf(item['value']) ==
                    -1) {
                  provider.brandActiveList['valueList'].add(item['value']);
                  provider.brandActiveList['titleList'].add(item['name']);
                  provider.tempBrandActiveList['valueList'].add(item['value']);
                  provider.tempBrandActiveList['titleList'].add(item['name']);
                } else {
                  provider.brandActiveList['valueList'].remove(item['value']);
                  provider.brandActiveList['titleList'].remove(item['name']);
                  provider.tempBrandActiveList['valueList']
                      .remove(item['value']);
                  provider.tempBrandActiveList['titleList']
                      .remove(item['name']);
                }
              });
              // print('every category onTap item provide brandActiveLit:${provider.brandActiveList}, tempBrandList:${provider.tempBrandActiveList}');
            },
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                width: _screenWidth / 2 - 20,
                child: provider.brandActiveList['valueList']
                        .contains(item['value'])
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Container(
                                margin: EdgeInsets.only(right: 6),
                                child: Icon(Icons.done,
                                    color: Theme.of(context).primaryColor,
                                    size: ScreenUtil().setSp(36))),
                            Text(item['title'],
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(32),
                                    fontWeight: FontWeight.w600))
                          ])
                    : Text(item['title'],
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                        ))));
      });
    }).toList();
    return Wrap(
      runSpacing: 1,
      spacing: 1,
      children: list,
    );
  }

  _buttons(data, context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    // _brandActiveList = {'titleList': [], 'valueList': []};
                    Provide.value<CategoryDetailMainProvide>(context)
                        .changeConfirmBool(false);
                    Provide.value<CategoryNavBarFilterProvide>(context)
                        .brandActiveList['valueList'] = [];
                    Provide.value<CategoryNavBarFilterProvide>(context)
                        .brandActiveList['titleList'] = [];
                    Provide.value<CategoryNavBarFilterProvide>(context)
                        .getTempBrandActiveList(
                            {'titleList': [], 'valueList': []});
                  });
                  // print('every category reset provide brandList:${Provide.value<CategoryNavBarFilterProvide>(context).brandActiveList}, tempBrandList: ${Provide.value<CategoryNavBarFilterProvide>(context).tempBrandActiveList}');
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                        )),
                    child: Text('重置',
                        style: TextStyle(fontSize: ScreenUtil().setSp(36))))),
            InkWell(
                onTap: () {
                  print('confirm-------------------');
                  var _provideBrand =
                      Provide.value<CategoryNavBarFilterProvide>(context)
                          .brandActiveList;
                  var _tempBrand =
                      Provide.value<CategoryNavBarFilterProvide>(context)
                          .tempBrandActiveList;
                  setState(() {
                    Provide.value<CategoryDetailMainProvide>(context)
                        .changeConfirmBool(true);
                    _provideBrand['valueList'].insertAll(
                        _provideBrand['valueList'].length,
                        _tempBrand['valueList']);
                    _provideBrand['titleList'].insertAll(
                        _provideBrand['titleList'].length,
                        _tempBrand['titleList']);
                  });

                  Provide.value<CategoryNavBarFilterProvide>(context)
                      .getTempBrandActiveList(
                          {'titleList': [], 'valueList': []});
                  _dropdownMenuController.hide();
                  // print('every category confirm provide brandList:$_provideBrand, tempBrandList: $_tempBrand');
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.0),
                        )),
                    child: Text('确定',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            color: Colors.white))))
          ],
        ));
  }
}
