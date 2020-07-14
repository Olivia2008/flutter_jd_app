import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
          Image.network(
            item['icon'],
            width: ScreenUtil().setWidth(80),
          ),
          Padding(padding: EdgeInsets.only(top: 6.0), child: Text(item['title']),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map> itemList = navigatorList.map((item) {
      return item['page'];
    }).toList();
    return Container(
      height: ScreenUtil().setHeight(350),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: ScreenUtil().setHeight(350),
            padding: EdgeInsets.all(3.0),
            child: GridView.count(
              crossAxisCount: 5,
              padding: EdgeInsets.all(10.0),
              children: itemList.map((item) {
                return _gridViewItemUI(context, item);
              }).toList(),
            ),
          );
        },
        itemCount: navigatorList.length,
        pagination: SwiperPagination(),
        autoplay: false,
      ),
    );
  }
}