import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuController.dart';

class ServiceDiscount extends StatefulWidget {
  ServiceDiscount(this.data);
  final Map data;
  @override
  _ServiceDiscountState createState() => _ServiceDiscountState();
}

class _ServiceDiscountState extends State<ServiceDiscount> {
  // Map _activeList = {'id': '', 'name': '', 'activeValue': []};
  CustomDropdownMenuController dropdownMenuController;
  @override
  void initState() {
    // TODO: implement initState
    // _activeList['id'] = widget.data['id'];
    // _activeList['name'] = widget.data['name'];
    // print('activeList:$_activeList');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        // height: ScreenUtil().setHeight(800),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _serviceTitleWidget(widget.data['title'], context),
                _serviceLocationWidget()
              ],
            ),
            _serviceGridViewWidget(widget.data['list'], context)
            // _serviceListViewWidget(data['list'], context)
          ],
        ));
  }

  Widget _serviceTitleWidget(title, context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32))),
    );
  }

  Widget _serviceLocationWidget() {
    return GestureDetector(
        onTap: () {
          print('location');
        },
        child: Container(
            child: Row(
          children: <Widget>[
            Container(
                width: ScreenUtil().setWidth(60.0),
                height: ScreenUtil().setHeight(60.0),
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xfff2f2f7)),
                child:
                    Icon(Icons.pin_drop, color: Color(0xff888888), size: 20.0)),
            Container(
                margin: EdgeInsets.only(left: 10.0),
                width: ScreenUtil().setWidth(280),
                child: Text('北京昌平区环以内生命科学园38号国家蛋白质科学中心',
                    overflow: TextOverflow.ellipsis))
          ],
        )));
  }

  Widget _serviceGridViewWidget(data, context) {
    var _count = 3;
    return data.length != 0
        ? Container(
            height: ScreenUtil().setHeight(300),
            child: GridView.count(
              //
              crossAxisCount: _count,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2.0,
              children: data.map<Widget>((item) {
                return _serviceGridViewItem(item, context);
              }).toList(),
            ))
        : Center(child: Text('暂时无数据'));
  }

  Widget _serviceGridViewItem(data, context) {
    // Provide.value<CategoryNavBarFilterProvide>(context).navBarFilterAcitveList.add(_activeList);
    return Provide<CategoryNavBarFilterProvide>(
        builder: (context, child, provider) {
      return InkWell(
          onTap: () {
            print('serviceWidget onTap value:${data['value']}');
            setState(() {
              provider.serviceDiscountActiveList['id'] = widget.data['id'];
              provider.serviceDiscountActiveList['name'] = widget.data['name'];
              if (provider.serviceDiscountActiveList['activeValue']
                  .contains(data['value'])) {
                switch (data['value']) {
                  case '1_1_10001_b1':
                    dropdownMenuController.changeIndex(0);
                    break;
                  case '1_1_10001_b2':
                    dropdownMenuController.changeIndex(1);
                    break;
                  case '1_1_10001_b3':
                    dropdownMenuController.changeIndex(2);
                    break;
                  case '1_1_10001_b4':
                    dropdownMenuController.changeIndex(3);
                    break;
                }
                provider.serviceDiscountActiveList['activeValue']
                    .remove(data['value']);
              } else {
                provider.serviceDiscountActiveList['activeValue']
                    .add(data['value']);
              }
            });
            print(
                'serviceDiscount ActiveList:${provider.serviceDiscountActiveList}');
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(6.0),
              padding: EdgeInsets.only(left: 6.0, right: 6.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: provider.serviceDiscountActiveList['activeValue']
                          .contains(data['value'])
                      ? Color(0XFFC81623)
                      : Color(0xfff2f2f7),
                ),
                color: provider.serviceDiscountActiveList['activeValue']
                        .contains(data['value'])
                    ? Color(0XFFFDF0F0)
                    : Color(0xfff2f2f7),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Text('${data['title']}',
                  style: TextStyle(
                      color: provider.serviceDiscountActiveList['activeValue']
                              .contains(data['value'])
                          ? Color(0XFFC81623)
                          : Color(0xff333333)))));
    });
  }
}
