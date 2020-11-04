import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/router/staticRouter.dart';
import 'package:fluro/fluro.dart';

class SwiperDiy extends StatelessWidget {
  final swiperDataList;

  SwiperDiy(this.swiperDataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top: 6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                StaticRouter.router.navigateTo(context, '/categoryDetails?pareId=1&subId=1&categoryId=10001', transition: TransitionType.fadeIn);
              },
              child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: '${swiperDataList[index]['imgUrl']}', fit: BoxFit.fill,)
            );
          },
          itemCount: swiperDataList.length,
          pagination: SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
  }
}
