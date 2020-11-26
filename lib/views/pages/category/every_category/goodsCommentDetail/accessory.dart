import 'package:flutter/material.dart';
import 'package:netease_news/components/icons/tipIcon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_accessory.dart';

class AccessoryWidget extends StatelessWidget {
  AccessoryWidget(this.accessoryInfo);
  final AccessoryModel accessoryInfo;

  @override
  Widget build(BuildContext context) {
    if (accessoryInfo != null) {
      return Card(
        elevation: 0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(350),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _title(context),
                _gridView(context, accessoryInfo.result.accessories.accList)
              ],
            )),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  _title(context) {
    return InkWell(
        onTap: () {
          print('热门配件');
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TipIcon(
                      width: 3.0,
                      height: 20.0,
                      colorList: [Color(0xfff5503a), Color(0xfffad1cb)],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Text(
                        '热门配件',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              )
            ],
          ),
        ));
  }

  _gridView(context, data) {
    if (data.length != 0) {
      return Container(
          height: ScreenUtil().setHeight(220),
          width: ScreenUtil().setWidth(666),
          margin: EdgeInsets.only(top: 6.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print('热门配件${data[index].typeName}');
                },
                child: Container(
                  margin: index == data.length - 1
                      ? EdgeInsets.only(right: 0)
                      : EdgeInsets.only(right: 6.0),
                  padding: EdgeInsets.all(6.0),
                  width: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/images/lazy.png',
                        image: data[index].accessoryShows[0].imageUrl,
                        fit: BoxFit.fill,
                      ),
                      Expanded(child: Text(data[index].typeName), flex: 1)
                    ],
                  ),
                ),
              );
            },
            itemCount: data.length,
          ));
    } else {
      return Text('暂无数据！');
    }
  }
}
