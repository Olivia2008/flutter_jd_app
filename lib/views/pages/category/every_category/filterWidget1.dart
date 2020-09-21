import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuController.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuHeader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';


class FilterWidget extends StatefulWidget {
  FilterWidget({@required this.stackKey, @required this.scaffoldKey, @required this.customDropdownMenuController, @required this.data,});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey stackKey;
  final CustomDropdownMenuController customDropdownMenuController;
  final data;
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget>{

  String value = '1_1_10001_a1_1';
  bool change = false;
  int active = 0;
  String priceController = '1_1_10001_a3_1';
  // CustomDropdownMenuController _dropdownMenuController = CustomDropdownMenuController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    if (data != null) {
      var list1 = (data['navList1'] as List).cast();
      var list2 = (data['navList2'] as List).cast();
      return Container(
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            list1.length != 0
                ? Container(
              height: ScreenUtil().setHeight(80),
              margin: EdgeInsets.only(bottom: 6),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _List1(list1, index, context);
                },
                itemCount: list1.length,
              ),
            )
                : Text('暂无数据'),
            // 下拉菜单头部
            list2.length != 0
                ? CustomDropdownMenuHeader(
              headerItems: list2,
              onItemTap: (index) {
                // print('onItemTap:$index');
              },
              stackKey: widget.stackKey,
              controller: widget.customDropdownMenuController
            )
                : Text('暂无数据'),
          ],
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  // 过滤筛选器item
  Widget _list1ViewItem(data, index, context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(188),
      height: ScreenUtil().setHeight(100),
      // padding: EdgeInsets.only(left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            alignment: Alignment.center,
            child: index == 0
                ? GestureDetector(
                    onTapDown: (tapDownDetail) {
                      if (active == index) {
                        change = !change;
                        if (change)
                          _showMenu(context, data[index]['optionList']);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        active == index
                            ? Text(
                                data[index]['title'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(34)),
                              )
                            : Text(data[index]['title'], style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                        active != index
                            ? Icon(Icons.arrow_drop_down,
                                size: ScreenUtil().setSp(40),
                                color: Color(0XFFF666666))
                            : change
                                ? Icon(Icons.arrow_drop_up,
                                    size: ScreenUtil().setSp(42),
                                    color: Color(0XFFF666666))
                                : Icon(Icons.arrow_drop_down,
                                    size: ScreenUtil().setSp(42),
                                    color: Color(0XFFF666666))
                      ],
                    ),
                  )
                : index == 1
                    ? Container(
                        child: active == index
                            ? Text(
                                data[index]['title'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36)),
                              )
                            : Text(data[index]['title'], style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                      )
                    : index == 2
                        ? GestureDetector(
                            onTapDown: (tapDownDetail) {
                              setState(() {
                                if (active == index) {
                                  if (priceController == '1_1_10001_a3_1')
                                    priceController = '1_1_10001_a3_2';
                                  else
                                    priceController = '1_1_10001_a3_1';
                                } else {
                                  priceController = '1_1_10001_a3_1';
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                active == index
                                    ? Text(
                                        data[index]['title'],
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                            // textBaseline: TextBaseline.alphabetic,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(36)),
                                      )
                                    : Text(data[index]['title'], style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                                Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: active != index
                                        ? FaIcon(FontAwesomeIcons.sort,
                                            color: Color(0XFF666666),
                                            size: ScreenUtil().setSp(22))
                                        : (priceController == '1_1_10001_a3_1')
                                            ? Icon(Icons.arrow_drop_up,
                                                size: ScreenUtil().setSp(42),
                                                color: Color(0XFF666666))
                                            : Icon(Icons.arrow_drop_down,
                                                size: ScreenUtil().setSp(42),
                                                color: Color(0XFF666666)))
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              active == index
                                  ? Text(
                                      data[index]['title'],
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(36)),
                                    )
                                  : Text(data[index]['title'], style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: active != index
                                    ? FaIcon(FontAwesomeIcons.filter,
                                        size: ScreenUtil().setSp(16))
                                    : FaIcon(
                                        Icons.filter_1,
                                        size: ScreenUtil().setSp(20),
                                        color: Theme.of(context).primaryColor,
                                      ),
                              )
                            ],
                          ),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(63),
            height: 3.0,
            // padding: EdgeInsets.only(left: 52, right: 52),
            decoration: active == index
                ? BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.yellowAccent,
                        Colors.lightGreen
                      ],
                    ),
                  )
                : BoxDecoration(),
          )
        ],
      ),
    );
  }

  // 过滤筛选器
  _List1(data, index, context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          active = index;
        });
        if(index == 3) {
          widget.customDropdownMenuController.hide(isShowHideAnimation: false);
          widget.scaffoldKey.currentState.openEndDrawer();
          Provide.value<CategoryNavBarFilterProvide>(context).getInnerDrawer(false);
          // Provide.value<CategoryNavBarFilterProvide>(context).getFilterCateActiveList({'id': '', 'name': '', 'activeValue': '', 'activeTitle': ''});
        }
      },
      child: _list1ViewItem(data, index, context),
    );
  }

  // 综合推荐下拉框
  // 下拉框
  PopupMenuButton _popMenu(data) {
    return PopupMenuButton<String>(
        itemBuilder: (context) => _getPopMenuItem(context, data),
        onSelected: (String selectedValue) {
          setState(() {
            value = selectedValue;
          });
        },
        onCanceled: () {
          print('onCanceled');
        },
        elevation: 8.0,
        color: Colors.white,
        initialValue: value);
  }

  _getPopMenuItem(BuildContext context, data) {
    if (data.length != 0) {
      List<PopupMenuEntry<String>> list =
          data.map<PopupMenuEntry<String>>((item) {
        return PopupMenuItem<String>(
          child: Container(
            width: window.physicalSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                value == item['value']
                    ? Container(
                        margin: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.done,
                          color: Colors.red,
                        ),
                      )
                    : Text(''),
                Text(
                  item['title'],
                  style: TextStyle(
                      color: value == item['value']
                          ? Colors.black87
                          : Colors.grey),
                )
              ],
            ),
          ),
          value: item['value'],
        );
      }).toList();
      return list;
    }
  }

  _showMenu(BuildContext context, option) {
    var pop = _popMenu(option);
    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: RelativeRect.fromLTRB(0, 115, 0, 0),
    ).then<void>((String newValue) {
      setState(() {
        change = false;
      });
      if (newValue != null) value = newValue;
    });
  }
}
