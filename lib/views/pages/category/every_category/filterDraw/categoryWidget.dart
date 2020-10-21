import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget(this.data, this.scaffoldKey);
  final Map data;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool isShowInnerDrawer = false;
  // Map _activeList = {'id': '', 'name': '', 'activeValue': '', 'activeTitle': ''};
  @override
  void initState() {
    // TODO: implement initState
    // _activeList['id'] = widget.data['id'];
    // _activeList['name'] = widget.data['name'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            _cateTitleWidget(widget.data, context),
            _categoryGridViewWidget(
                widget.data['list'], context, widget.data['arrow']),
          ],
        ));
  }

  Widget _cateTitleWidget(data, context) {
    return InkWell(
        onTap: () {
          setState(() {
            data['arrow'] = !data['arrow'];
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Text(data['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(32))),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('单选',
                        style: TextStyle(fontSize: ScreenUtil().setSp(28))))
              ],
            )),
            Container(
                child: Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                    right: 6.0,
                  ),
                  child: Provide<CategoryNavBarFilterProvide>(
                      builder: (context, child, provider) {
                    return Text(
                        provider.navBarFilterCateActiveList['activeTitle'],
                        style:
                            TextStyle(color: Theme.of(context).primaryColor));
                  })),
              data['arrow']
                  ? Icon(Icons.keyboard_arrow_up)
                  : Icon(Icons.keyboard_arrow_down)
            ])),
          ],
        ));
  }

  Widget _categoryGridViewWidget(data, context, _cateArrow) {
    // print(data);
    var subList;
    _cateArrow ? subList = data : subList = data.sublist(0, 3);
    var _count = 3;
    return subList.length != 0
        ? Container(
            height: _cateArrow
                ? ScreenUtil().setHeight(140)
                : ScreenUtil().setHeight(80),
            child: GridView.count(
              crossAxisCount: _count,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2.0,
              children: subList.map<Widget>((item) {
                return _categoryGridViewItem(
                    item, context, _cateArrow, subList.indexOf(item));
              }).toList(),
            ))
        : Center(child: Text('暂时无数据'));
  }

  Widget _categoryGridViewItem(data, context, _cateArrow, index) {
    return Provide<CategoryNavBarFilterProvide>(
      builder: (context, child, provider) {
        return index != 3
            ? InkWell(
                onTap: () {
                  setState(() {
                    provider.navBarFilterCateActiveList['id'] = widget.data['id'];
                    provider.navBarFilterCateActiveList['name'] = widget.data['name'];
                    provider.navBarFilterCateActiveList['activeValue'] =
                        data['value'];
                    provider.navBarFilterCateActiveList['activeTitle'] =
                        data['title'];
                  });
                  print(
                      'category widget activelist: ${provider.navBarFilterCateActiveList}');
                  var id = widget.data['id'] + '_4_1';
                  // var subId = '';
                  var _list = provider.navBarFilterOtherList;
                  var activeSubId =
                      provider.navBarFilterCateActiveList['activeValue'];
                  // print('category widget activeSubid:$activeSubId');
                  if (activeSubId != '') {
                    // activeSubId == (id + '_2')
                    //     ? _list = _list.sublist(0, 1)
                    //     : activeSubId == (id + '_1')
                    //         ? _list = provider.navBarFilterOtherList
                    //         : _list = [];
                    if(activeSubId == (id + '_2')) {
                      _list = _list.sublist(0, 1);
                      provider.otherActiveList = [];
                    } else if (activeSubId == (id + '_1')) {
                      _list = provider.navBarFilterOtherList;
                    } else {
                      _list = [];
                      provider.otherActiveList = [];
                    }
                  } else {
                    id = '';
                  }
                  // print('category widget other List:$_list');
                  provider.getFilterOtherList(_list);
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.only(left: 6.0, right: 6.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.navBarFilterCateActiveList[
                                    'activeValue'] ==
                                data['value']
                            ? Color(0XFFC81623)
                            : Color(0xfff2f2f7),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color:
                          provider.navBarFilterCateActiveList['activeValue'] ==
                                  data['value']
                              ? Color(0XFFFDF0F0)
                              : Color(0xfff2f2f7),
                    ),
                    child: Text(data['title'],
                        style: TextStyle(
                            color: Provide.value<CategoryNavBarFilterProvide>(
                                                context)
                                            .navBarFilterCateActiveList[
                                        'activeValue'] ==
                                    data['value']
                                ? Color(0XFFC81623)
                                : Color(0xff333333)),
                        overflow: TextOverflow.ellipsis)))
            : InkWell(
                onTap: () {
                  setState(() {
                    isShowInnerDrawer = true;
                    // provider.navBarFilterCateActiveList['id'] = widget.data['id'];
                    // provider.navBarFilterCateActiveList['name'] = widget.data['name'];
                  });
                  provider.getInnerDrawer(isShowInnerDrawer);
                  provider.getMoreValue(data['value']);
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.only(left: 6.0, right: 6.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Colors.white),
                    child: Text(data['title'],
                        style: TextStyle(color: Color(0xff333333)),
                        overflow: TextOverflow.ellipsis)));
      },
    );
  }
}
