import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuController.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'package:provide/provide.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterWidget extends StatefulWidget {
  FilterWidget({this.customDropdownMenuController, this.stackKey});
  final GlobalKey stackKey;
  final CustomDropdownMenuController customDropdownMenuController;
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> with SingleTickerProviderStateMixin{

  String value = '1';
  bool change = false;
  int active = 0;
  String priceController = 'ASC';
  int list2Active = 0;
  List<int> checkActiveList = [0];
  bool checkActive = false;
  GlobalKey _keyDropDownHeader = GlobalKey();
  bool _isShowDropDownItemWidget = false;
  @override
  void initState() {
    // TODO: implement initState
    // widget.customDropdownMenuController.addListener(_handleCustomDropmenuAddListener);
    super.initState();
  }
  _handleCustomDropmenuAddListener() {
    if(mounted) {
      setState(() {
        print(widget.customDropdownMenuController.menuIndex);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryNavBarFilterProvide>(
      builder: (context, child, val) {
        var data = Provide.value<CategoryNavBarFilterProvide>(context)
            .navBarFilterList;
        if (data != null) {
          var list1 = (data['navList1'] as List).cast();
          var list2 = (data['navList2'] as List).cast();
          return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  list1.length != 0
                      ? Container(
                          height: ScreenUtil().setHeight(80),
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
                  list2.length != 0
                      ? Container(
                          // padding: checkActive ? EdgeInsets.only(top: 8, bottom: 0) : EdgeInsets.only(top: 8, bottom: 8),
                          height: ScreenUtil().setHeight(100),
                          width: ScreenUtil().setWidth(730),
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _List2(list2, index, context);
                            },
                            itemCount: list2.length,
                          ),
                        )
                      : Text('暂无数据'),
                ],
              ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
                                    fontSize: ScreenUtil().setSp(32)),
                              )
                            : Text(data[index]['title']),
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
                                    fontSize: ScreenUtil().setSp(32)),
                              )
                            : Text(data[index]['title']),
                      )
                    : index == 2
                        ? GestureDetector(
                            onTapDown: (tapDownDetail) {
                              setState(() {
                                if (active == index) {
                                  if (priceController == 'ASC')
                                    priceController = 'DES';
                                  else
                                    priceController = 'ASC';
                                } else {
                                  priceController = 'ASC';
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
                                            fontSize: ScreenUtil().setSp(32)),
                                      )
                                    : Text(data[index]['title']),
                                Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: active != index
                                        ? FaIcon(FontAwesomeIcons.sort,
                                            color: Color(0XFF666666),
                                            size: ScreenUtil().setSp(22))
                                        : (priceController == 'ASC')
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
                                          fontSize: ScreenUtil().setSp(32)),
                                    )
                                  : Text(data[index]['title']),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: active != index
                                    ? FaIcon(FontAwesomeIcons.filter,
                                        size: ScreenUtil().setSp(16),
                                        color: Theme.of(context).primaryColor)
                                    : FaIcon(
                                        FontAwesomeIcons.filter,
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
      },
      child: _list1ViewItem(data, index, context),
    );
  }

  // 过滤多选
  Widget _List2(data, index, context) {

    return InkWell(
      onTap: () {

        final RenderBox overlay = widget.stackKey.currentContext.findRenderObject();
        print('currentContext:$overlay');
//        final RenderBox dropDownItemRenderBox = _keyDropDownHeader.currentContext.findRenderObject();
//        var position = dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
//        var size = dropDownItemRenderBox.size;
//        widget.customDropdownMenuController.dropDownHeaderHeight = size.height + position.dy;
        setState(() {
          list2Active = index;
        });
        if (list2Active == index) {

//          if (widget.customDropdownMenuController.isShow) {
//            widget.customDropdownMenuController.hide();
//          } else {
//            widget.customDropdownMenuController.show(index);
//          }

          if (checkActiveList.indexOf(list2Active) == -1)
            checkActiveList.add(list2Active);
          else
            checkActiveList.remove(list2Active);

          if (index == 2) {
            checkActive = !checkActive;
//            int menuIndex = widget.customDropdownMenuController.menuIndex;
//            checkActive = index == menuIndex && widget.customDropdownMenuController.isShow;
          }
          print('checkActive:$checkActive');
        } else {
//          if (widget.customDropdownMenuController.isShow) {
//            widget.customDropdownMenuController.hide(isShowHideAnimation: false);
//          }
//          widget.customDropdownMenuController.show(index);
        }
      },
      child: _list2ViewItem(data, index, context),
    );
  }

  Widget _list2ViewItem(data, index, context) {
    // print(data);
    return index == 2
        ? checkActive
            ? Container(
                width: ScreenUtil().setWidth(158),
                height: ScreenUtil().setHeight(60),
                margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 0),
                decoration: BoxDecoration(
                  color: Color(0XFFF5F5F5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data[index]['title'],
                      style: checkActiveList.contains(index)
                          ? TextStyle(color: Theme.of(context).primaryColor)
                          : TextStyle(),
                    ),
                    list2Active != index
                        ? Icon(Icons.arrow_drop_down,
                            size: ScreenUtil().setSp(40),
                            color: Color(0XFFF666666))
                        : checkActive
                            ? Icon(Icons.arrow_drop_up,
                                size: ScreenUtil().setSp(40),
                                color: Theme.of(context).primaryColor)
                            : Icon(Icons.arrow_drop_down,
                                size: ScreenUtil().setSp(40),
                                color: Color(0XFFF666666))
                  ],
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(158),
                margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Color(0XFFF5F5F5),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(data[index]['title']),
                    Icon(Icons.arrow_drop_down,
                        size: ScreenUtil().setSp(40), color: Color(0XFFF666666))
                  ],
                ),
              )
        : Container(
            alignment: Alignment.center,
            // height: ScreenUtil().setHeight(60),
            width: ScreenUtil().setWidth(158),
            margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
            decoration: checkActiveList.contains(index)
                ? BoxDecoration(
                    color: Color(0XFFFDF0F0),
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ))
                : BoxDecoration(
                    color: Color(0XFFF5F5F5),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
            child: Text(
              data[index]['title'],
              style: checkActiveList.contains(index)
                  ? TextStyle(color: Theme.of(context).primaryColor)
                  : TextStyle(),
            ));

//      Container(
//      alignment: Alignment.center,
//      height: ScreenUtil().setHeight(30),
//      width: ScreenUtil().setWidth(158),
//      margin: EdgeInsets.only(left: 5, right: 5),
//      decoration: checkActiveList.contains(index) ? BoxDecoration(
//          color: Color(0XFFFDF0F0),
//          borderRadius: BorderRadius.circular(50.0),
//          border: Border.all(color: Theme.of(context).primaryColor,)
//      ) : BoxDecoration(
//          color: Color(0XFFF5F5F5),
//          borderRadius: BorderRadius.circular(50.0),
//      ),
//      child: index == 2 ? Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Text(
//            data[index]['title'],
//            style: checkActiveList.contains(index) ? TextStyle(color: Theme.of(context).primaryColor) : TextStyle(),
//          ),
//          list2Active != index ? Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(40),color: Color(0XFFF666666)) :
//              checkActive ? Icon(Icons.arrow_drop_up, size: ScreenUtil().setSp(40),color: Theme.of(context).primaryColor)
//        : Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(40),color: Color(0XFFF666666))
//        ],
//      ) : Text(data[index]['title'],style: checkActiveList.contains(index) ? TextStyle(color: Theme.of(context).primaryColor) : TextStyle(),),
//    );
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
