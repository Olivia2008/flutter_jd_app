import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/model/category_goods_list.dart';
import 'package:netease_news/views/model/category_nav_list.dart';
import 'package:netease_news/views/provides/goodsList_category.dart';
import 'package:netease_news/views/provides/subList_category.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';
import 'package:provide/provide.dart';

class LeftNav extends StatefulWidget {
  @override
  _LeftNavState createState() => _LeftNavState();
}

class _LeftNavState extends State<LeftNav> {
  List list = [];
  List mainList = [];
  bool active = false;
  var listIndex = 0;
  var sublistIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNavData(listIndex);
    _getCategoryMainList({"id": 1, "subId": 1, "page": 1, "pageSize": 20});
  }

  void _getNavData(index) async {
    await postRequestPlain('categoryNavList').then((res) {
      // print(res);
      var data = json.decode(res.toString());
      CategoryNavModel dataList = CategoryNavModel.fromJson(data);
      setState(() {
        list = dataList.data.result;
        active = true;
        var childList = list[index].subList;
        var id = int.parse(list[index].id);
        var subId = int.parse(childList[sublistIndex].id);
        Provide.value<SubchildCategory>(context)
            .getSubListCategoryList(childList, id, sublistIndex, subId);
      });
      print('分类页左侧导航数据请求完成........');
    });
  }

  void _getCategoryMainList(paramData) async {
    mainList = [];
    await request('categoryMainList', params: paramData).then((res) {
      var data = json.decode(res.toString());
      GoodsListModel list = GoodsListModel.fromJson(data);
      setState(() {
        mainList = list.data.result;
        Provide.value<GoodsListProvide>(context).getGoodsList(mainList);
      });
      print('分类页主体数据请求完成.......');
    });
  }

  Widget _leftNavBar(int index) {
    active = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
          sublistIndex = 0;
          var id = int.parse(list[index].id);
          _getNavData(listIndex);
          _getCategoryMainList(
              {"id": id, "subId": 1, "page": 1, "pageSize": 20});
          // Provide.value<SubchildCategory>(context).getSubListCategoryList(list[listIndex].subList, id, sublistIndex, int.parse(list[listIndex].subList[sublistIndex].id));
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(92),
        color: active ? Colors.white : Color(0xFFF8F8F8),
        child: Text(
          list[index].title,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: active ? Color(0xFFE93B3D) : Color(0xFF333333),
              fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(170),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.white))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _leftNavBar(index);
        },
        itemCount: list.length,
      ),
    );
  }
}
