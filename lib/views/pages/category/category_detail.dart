import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/searchDelegate.dart';
import 'package:netease_news/views/provides/category_detail.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'package:provide/provide.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDetails(this.params);

  Map params;

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  Map _params;
  final controller = TextEditingController();
  String value = '1';
  bool change = false;
  int active = 1;
  String priceController = 'ASC';
  List<Map> filterNavList1 = [];
  List<Map> filterNavList2 = [];

  @override
  void initState() {
    // TODO: implement initState
    _params = widget.params;
    // print(_params);
    // _getNavFilterList('categoryNavTop', {'id': _params['pareId'][0], 'subId': _params['subId'][0], 'goodId': _params['categoryId'][0]});
    super.initState();
  }

  void _getNavFilterList(url, params) async{
    await request(url, params: params).then((res) {
      // print('2222');
      var data = json.decode(res.toString());
      filterNavList1 = (data['data']['result']['navList1'] as List).cast();
      filterNavList2 = (data['data']['result']['navList2'] as List).cast();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provide.value<CategoryNavBarFilterProvide>(context).navBarFilterList;
    print(data);
    filterNavList1 = (data['navList1'] as List).cast();
    filterNavList2 = (data['navList2'] as List).cast();
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          // backgroundColor: Theme.of(context).primaryColor,
          leading: _appBarLeading(),
          title: _appBarTitle(),
          // bottom: _appBarBottom()
          ),
      body: Text('aaa'),
//      body: FutureBuilder(
//        future: _getBackInfo(context),
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          if (snapshot.hasData) {
//            return Center();
//          } else {
//            return CircularProgressIndicator();
//          }
//        },
//      ),
    );
  }

  _appBarLeading() {
    return IconButton(
      color: Color(0xffffffff),
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  _appBarTitle() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(68),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            child: Container(
              height: 32,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 0),
              width: ScreenUtil().setWidth(460),
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
                    height: 26,
                    // padding: EdgeInsets.only(top: 4, bottom: 4),
                    // rheight: 26,
                    // child: Text('手机', style: TextStyle(color: Color(0xff888888),fontSize: ScreenUtil().setSp(30)),),
                    child: InputChip(
                        backgroundColor: Color(0xff888888),
                        // labelPadding: EdgeInsets.only(bottom: 20),
                        onPressed: () {
                          print('input chip');
                        },
                        onDeleted: () {},
                        label: Text(
                          '手机',
                        ),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 12),
                        deleteIcon: Icon(
                          Icons.close,
                          size: ScreenUtil().setSp(26),
                        ),
                        deleteIconColor: Colors.white),
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
          IconButton(
              alignment: Alignment.topCenter,
              color: Color(0xffffffff),
              icon: Icon(
                Icons.more_horiz,
                size: 22,
              ),
              onPressed: () {
                print('bbbb');
              })
        ],
      ),
    );
  }

  _appBarBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: Container(
        width: ScreenUtil().setWidth(750),
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(120),
        padding: EdgeInsets.only(left: 11, right: 11),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(120),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: _bottomRow(),
              )
//              child: ListView.builder(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                // padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                itemBuilder: (context, index) {
//                  return _listViewItem(filterNavList1, index);
//                },
//                itemCount: filterNavList1.length,
//              ),
            )
          ],
        ),
      ),
    );

  }
  _listViewItemChild(data, index) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(182),
      height: ScreenUtil().setHeight(120),
      // padding: EdgeInsets.only(left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(182),
            alignment: Alignment.center,
            child: index == 0
                ? GestureDetector(
              onTapDown: (tapDownDetail) {
                if (active == index) {
                  change = !change;
                  if (change) _showMenu(context, data[index]['optionList']);
                }
              },
              child: Row(
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
                  active != index ? Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(40),color: Color(0XFFF666666)) :
                  change
                      ? Icon(Icons.arrow_drop_up, size: ScreenUtil().setSp(42),color: Color(0XFFF666666))
                      : Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(42),color: Color(0XFFF666666))
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
                    if (priceController == 'ASC') priceController = 'DES';
                    else priceController = 'ASC';
                  } else {
                    priceController = 'ASC';
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                  active != index ? Padding(padding: EdgeInsets.only(left: 3),child: FaIcon(FontAwesomeIcons.sort, color: Color(0XFF666666),size: ScreenUtil().setSp(26)),) :
                  (priceController == 'ASC') ? Icon(Icons.arrow_drop_up, size: ScreenUtil().setSp(42),color: Color(0XFF666666)) : Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(42),color: Color(0XFF666666))
                ],
              ),
            )
                : Row(
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
                  child: active != index ? FaIcon(FontAwesomeIcons.filter,size: ScreenUtil().setSp(18),color: Color(0XFFF666666),) : FaIcon(FontAwesomeIcons.filter,size: ScreenUtil().setSp(20),color: Color(0XFFF666666),),
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

  _listViewItem(data, index) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          active = index;
        });
      },
      child: _listViewItemChild(data, index),
    );
  }

  _bottomRow() {
    if (filterNavList1.length != 0) {
      List<Widget> list = filterNavList1.map<Widget>((item){
        var str = item['filId'].split("_").last;
        var id = str.substring(1);
        return InkWell(
          onTapDown: (tapDownDetails) {
            setState(() {
              active = int.parse(id);
            });
          },
        child: _RowItems(item, id)
        );
          }).toList();
      return list;
    }
  }

  _RowItems(item, index) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(182),
      height: ScreenUtil().setHeight(120),
      // padding: EdgeInsets.only(left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(182),
            alignment: Alignment.center,
            child: index == 0
                ? GestureDetector(
              onTapDown: (tapDownDetail) {
                if (active == index) {
                  change = !change;
                  if (change) _showMenu(context, item['optionList']);
                }
              },
              child: Row(
                children: <Widget>[
                  active == index
                      ? Text(
                    item['title'],
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(32)),
                  )
                      : Text(item['title']),
                  active != index ? Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(40),color: Color(0XFFF666666)) :
                  change
                      ? Icon(Icons.arrow_drop_up, size: ScreenUtil().setSp(42),color: Color(0XFFF666666))
                      : Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(42),color: Color(0XFFF666666))
                ],
              ),
            )
                : index == 1
                ? Container(
              child: active == index
                  ? Text(
                item['title'],
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(32)),
              )
                  : Text(item['title']),
            )
                : index == 2
                ? GestureDetector(
              onTapDown: (tapDownDetail) {
                setState(() {
                  if (active == index) {
                    if (priceController == 'ASC') priceController = 'DES';
                    else priceController = 'ASC';
                  } else {
                    priceController = 'ASC';
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  active == index
                      ? Text(
                    item['title'],
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(32)),
                  )
                      : Text(item['title']),
                  active != index ? Padding(padding: EdgeInsets.only(left: 3),child: FaIcon(FontAwesomeIcons.sort, color: Color(0XFF666666),size: ScreenUtil().setSp(26)),) :
                  (priceController == 'ASC') ? Icon(Icons.arrow_drop_up, size: ScreenUtil().setSp(42),color: Color(0XFF666666)) : Icon(Icons.arrow_drop_down, size: ScreenUtil().setSp(42),color: Color(0XFF666666))
                ],
              ),
            )
                : Row(
              children: <Widget>[
                active == index
                    ? Text(
                  item['title'],
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(32)),
                )
                    : Text(item['title']),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: active != index ? FaIcon(FontAwesomeIcons.filter,size: ScreenUtil().setSp(18),color: Color(0XFFF666666),) : FaIcon(FontAwesomeIcons.filter,size: ScreenUtil().setSp(20),color: Color(0XFFF666666),),
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
      List<PopupMenuEntry<String>> list = data.map<PopupMenuEntry<String>>((item) {
        return PopupMenuItem<String>(
          child: Container(
            width: double.infinity,
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
                      color: value == item['value'] ? Colors.black87 : Colors.grey),
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

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<CategoryDetailProvide>(context)
        .getCategoryDetailList(_params);
    return '加载完成';
  }

//  Widget _body(context) {
//    return Column(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.fromLTRB(0,MediaQueryData.fromWindow(window).padding.top,20, 0),
//          height: 72.0,
//          width: ScreenUtil().setWidth(750),
//          decoration: BoxDecoration(
//              color: Colors.white,
//              boxShadow: [BoxShadow(color: Color(0xFFEEEEEE), offset: Offset(1.0, 1.0),blurRadius: 5.0, spreadRadius: 1.0), BoxShadow(color: Color(0xFFF5F5F5), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0xFFF5F5F5))],
//              border: Border(bottom: BorderSide(style: BorderStyle.solid, color: Color(0xFFF5F5F5)))
//          ),
//          child: Row(
//            children: <Widget>[
//              Container(
//                width: ScreenUtil().setWidth(80),
//                child: IconButton(
//                  color: Color(0xff888888),
//                  icon: Icon(Icons.arrow_back_ios),
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                ),
//              ),
//              Container(
//                height: 32,
//                alignment: Alignment.center,
//                width: ScreenUtil().setWidth(580),
//                decoration: BoxDecoration(
//                  color: Color(0xFFF7F7F7),
//                  borderRadius: BorderRadius.circular(50.0),
//                ),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(left: 10),
//                      child: Icon(Icons.search, color: Colors.grey, size: ScreenUtil().setSp(46),),
//                    ),
//                    Expanded(
//                      child: Container(
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.only(left: 6),
//                        width: ScreenUtil().setWidth(440),
//                        child: TextField(
//                          textAlignVertical: TextAlignVertical.center,
//                          controller: controller,
//                          decoration: InputDecoration(
//                            // contentPadding: EdgeInsets.only(top: 0.0),
//                              hintText: 'Search', border: InputBorder.none),
//                          // onChanged: onSearchTextChanged,
//                        ),
//                      ),
//                    ),
//                    IconButton(
//                      icon: new Icon(Icons.cancel),
//                      color: Colors.grey,
//                      iconSize: ScreenUtil().setSp(36),
//                      onPressed: () {
//                        controller.clear();
//                        // onSearchTextChanged('');
//                      },
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                width: ScreenUtil().setWidth(20),
//                child: InkWell(
//                  onTap: () {
//                    print('aaaaa');
//                  },
//                  child: IconButton(
//                      color: Color(0xff888888),
//                      icon: Icon(Icons.category),
//                      onPressed: (){
//                        print('bbbb');
//                      }
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
////              FutureBuilder(
////                future: _getBackInfo(context),
////                builder: (context, snapshot) {
////                  if(snapshot.hasData) {
////                    return Container(
////                      child: Column(
////                        children: <Widget>[
////                          Text('${params['categoryId'].first}')
////                        ],
////                      ),
////                    );
////                  } else {
////                    return CircularProgressIndicator();
////                  }
////                },
////              ),
//      ],
//    );
//  }
}
