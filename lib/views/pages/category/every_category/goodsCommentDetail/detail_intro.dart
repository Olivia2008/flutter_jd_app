import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';

class DetailIntro extends StatelessWidget {
  DetailIntro(this.data);
  final Introduce data;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Column(
          children: List.generate(data.introList.length, (index) {
            return FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: data.introList[index], fit: BoxFit.fill,);
          })
        ),
      ),
    );
  }
}