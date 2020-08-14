import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

class OtherWidget extends StatefulWidget {
  OtherWidget(this.data);
  final List data;
  // final List activeData;
  @override
  _OtherWidgetState createState() => _OtherWidgetState();
}

class _OtherWidgetState extends State<OtherWidget> {
  // List _activeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.data.length != 0) {
    //   widget.data.forEach((item) {
    //    _activeList.add({'id': item['id'], 'name': item['name'], 'titleList': [], 'valueList': []});
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.length != 0
        ? Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
                children: widget.data.map<Widget>((item) {
              Provide.value<CategoryNavBarFilterProvide>(context)
                  .otherActiveList
                  .add({
                'id': item['id'],
                'name': item['name'],
                'titleList': [],
                'valueList': []
              });
              return _commonItemWidget(item, context);
            }).toList()))
        : Container();
  }

  _commonItemWidget(data, context) {
    var i = widget.data.indexOf(data);
    return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(children: <Widget>[
          _commonTitleWidget(data, context, i),
          data['arrow']
              ? _commonListWidget(data['list'], context, i)
              : Container()
        ]));
  }

  Widget _commonTitleWidget(data, context, idx) {
    return Provide<CategoryNavBarFilterProvide>(
      builder: (context, child, provider) {
        return InkWell(
            onTap: () {
              setState(() {
                data['arrow'] = !data['arrow'];
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(data['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(32))),
                Row(children: <Widget>[
                  provider.otherActiveList[idx]['titleList'].length != 0
                      ? Container(
                          alignment: Alignment.centerRight,
                          width: ScreenUtil().setWidth(200),
                          child: Text(
                              '${provider.otherActiveList[idx]['titleList'].join(',')}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )))
                      : Container(),
                  data['arrow']
                      ? Icon(Icons.keyboard_arrow_up)
                      : Icon(Icons.keyboard_arrow_down)
                ])
              ],
            ));
      },
    );
  }

  Widget _commonListWidget(data, context, idx) {
    var _count = 3;
    var d = data.length / _count;
    return data.length != 0
        ? Container(
            height: ScreenUtil().setHeight(100) * (d is int ? d : d.ceil()),
            alignment: Alignment.center,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _count, childAspectRatio: 2.0),
                itemBuilder: (BuildContext context, int i) {
                  return _commonGridViewItem(data[i], context, idx);
                },
                itemCount: data.length))
        : Center(child: Text('暂无数据'));
  }

  Widget _commonGridViewItem(data, context, idx) {
    // var test = [];
    return Provide<CategoryNavBarFilterProvide>(
        builder: (context, child, provider) {
      return InkWell(
          onTap: () {
            setState(() {
              if (provider.otherActiveList[idx]['valueList']
                  .contains(data['value'])) {
                provider.otherActiveList[idx]['valueList']
                    .remove(data['value']);
                provider.otherActiveList[idx]['titleList']
                    .remove(data['title']);
              } else {
                provider.otherActiveList[idx]['valueList'].add(data['value']);
                provider.otherActiveList[idx]['titleList'].add(data['title']);
              }
              // provider.otherActiveList.removeWhere((item) => item['valueList'].length == 0);
            });
            // print('otherActiveList:${provider.otherActiveList}');
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(6.0),
              padding: EdgeInsets.only(left: 6.0, right: 6.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: provider.otherActiveList[idx]['valueList']
                          .contains(data['value'])
                      ? Color(0XFFC81623)
                      : Color(0xfff2f2f7),
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: provider.otherActiveList[idx]['valueList']
                        .contains(data['value'])
                    ? Color(0XFFFDF0F0)
                    : Color(0xfff2f2f7),
              ),
              child: Text('${data['title']}',
                  style: TextStyle(
                      color: provider.otherActiveList[idx]['valueList']
                              .contains(data['value'])
                          ? Color(0XFFC81623)
                          : Color(0xff333333)),
                  overflow: TextOverflow.ellipsis)));
    });
  }
}
