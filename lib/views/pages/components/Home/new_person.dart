import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NewPerson extends StatelessWidget {
  NewPerson({this.dataList, this.floorData});
  final List dataList;
  final List floorData;

  // 新人专享组件
  Widget _newPerson(data) {
    return Row(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(200),
          width: ScreenUtil().setWidth(354),
          margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
          child: InkWell(
            onTap: () {print('新人专享');},
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
              // child: Image.network(data[0]['img'], fit: BoxFit.fill, width: ScreenUtil().setWidth(376), height: ScreenUtil().setHeight(240),),
              child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: data[0]['img'], fit: BoxFit.fill,)
            ) ,
          ),),
        Container(
          height: ScreenUtil().setHeight(200),
          width: ScreenUtil().setWidth(354),
          margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
          child: InkWell(
            onTap: () => print('新人专享'),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
              // child: Image.network(data[1]['img'], fit: BoxFit.fill,width: ScreenUtil().setWidth(376), height: ScreenUtil().setHeight(240))
              child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', fit: BoxFit.fill, image: data[1]['img'])
            ),
          ),
        )
      ],
    );
  }
  // 健康随行，一起联想组件
  Widget _healty(data) {
    return Container(
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image.network(data[2]['img'],fit: BoxFit.fill,),
          // Image.network(data[3]['img'],fit: BoxFit.fill,)
          FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: data[2]['img'], fit: BoxFit.fill),
          FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: data[3]['img'], fit: BoxFit.fill),
        ],
      ),
    );
  }
  // 秒杀栏底层广告单项组件
  Widget _floorBottomItem(BuildContext context, item) {
    return InkWell(
      onTap: () {print('floor item');},
      child: Container(
        // 设计稿是375*130, 转化为750*260, width=(750-20-8)/4
        width: ScreenUtil().setWidth(177),
        height: ScreenUtil().setHeight(180),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Color(0xFFF5F5F5), width: 1.0, style: BorderStyle.solid)
        ),
        // child: Image.network(item['img']),
        child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['img'],)
      ),
    );
  }
  // 秒杀栏底层广告
  Widget _floorBottom(BuildContext context, data) {
    return Row(
      children: floorData.map((item) {
        return _floorBottomItem(context, item);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _newPerson(dataList),
        // _healty(dataList)
        _floorBottom(context, floorData)
      ],
    );
  }
}
