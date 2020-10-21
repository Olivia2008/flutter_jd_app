import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/varibleDecorationWidget/index.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

class FooterWidget extends StatefulWidget {
  FooterWidget(this.data);
  final List data;
  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(bottom: 0, child: _footerButtonsWidget(context, widget.data));
  }

   Widget _footerButtonsWidget(context, data) {
    return Provide<CategoryNavBarFilterProvide>(
      builder: (context, child, provider) {
        return Container(
      width: MediaQuery.of(context).size.width / 4 * 3,
      height: ScreenUtil().setHeight(120),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Color(0xfff5f5f5)),
            bottom: BorderSide(color: Color(0xfff5f5f5)),
            left: BorderSide(color: Color(0xfff5f5f5)),
            right: BorderSide(color: Color(0xfff5f5f5))),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0)),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 4 * 3 / 2 - 1,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: ScreenUtil().setHeight(60),
              child: VaribleDecorations(
                width: ScreenUtil().setWidth(261),
                height: ScreenUtil().setHeight(60),
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                borderRadius: 50.0,
                fillActiveColor: Color(0xffdcdfe6),
                onPress: () {
                  print('reset........');
                  provider.resetActiveList();
                  print('serviceActiveList:${provider.serviceDiscountActiveList}\n'
                  'priceActiveList:${provider.priceRangeActiveList}\n'
                  'brandActiveList:${provider.brandActiveList}\n'
                  'otherActiveList:${provider.otherActiveList}');
                  Navigator.pop(context);

                },
                child: Text('重置',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: ScreenUtil().setSp(32))),
              )),
          Container(
              // color: Colors.yellow,
              width: MediaQuery.of(context).size.width / 4 * 3 / 2 - 1,
              height: ScreenUtil().setHeight(60),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: VaribleDecorations(
                  width: ScreenUtil().setWidth(261),
                  height: ScreenUtil().setHeight(60),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                  fillDefaultColor: Theme.of(context).primaryColor,
                  fillActiveColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 50.0,
                  onPress: () {
                    print('confirm.........................');
                    provider.confirmActiveList();
                    Navigator.pop(context);
                  },
                  child: Text(
                    '确定(150万+件商品)',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(32)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ))),
        ],
      ),
    );
      }
    );
  }
}