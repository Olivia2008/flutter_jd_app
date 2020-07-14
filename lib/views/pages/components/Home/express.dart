import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Express extends StatelessWidget {
  Express({this.data});

  final List<Map> data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('express');
      },
      child: Container(
        height: ScreenUtil().setHeight(60),
        width: ScreenUtil().setWidth(730),
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Image.asset(
                'assets/images/express.jpg',
                width: ScreenUtil().setWidth(126),
                height: ScreenUtil().setHeight(36),
                fit: BoxFit.fill,
              ),
            ),
            // Text("${data[1]['title']}")
            Expanded(
              child: Swiper(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
//                  return Text("${data[index]['title']}");
                  return InkWell(
                    onTap: () {
                      print('第$index个express item');
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Text(
                            '${data[index]['title']}',
                            style: TextStyle(color: Color(0xFFF32030), fontSize: ScreenUtil().setSp(24)),
                          ),
                        ),
                        Expanded(
                          // padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            '${data[index]['desc']}',
                            style: TextStyle(
                                color: Color(0xFF181818),
                                fontSize: ScreenUtil().setSp(24)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: data.length,
                autoplay: true,
              ),
            ),
            Text(
              '|',
              style: TextStyle(color: Color(0xFFECECEC)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text('更多', style: TextStyle(color: Color(0xFF181818))),
            )
          ],
        ),
      ),
    );
  }
}
