import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopNav extends StatelessWidget {
  final List navigatorList;

  TopNav({this.navigatorList});

  @override
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('click topNav');
      },
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(80),
            height: ScreenUtil().setHeight(70),
            child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['icon'], fit: BoxFit.fill)
          ),
          Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Text(
              item['title'],
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(260),
      padding: EdgeInsets.only(top: 10.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        // padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}
