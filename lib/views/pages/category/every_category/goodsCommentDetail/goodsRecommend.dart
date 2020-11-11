import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/icons/tipIcon.dart';

class GoodsRecommentWidget extends StatelessWidget {
  GoodsRecommentWidget(this.recommendInfo);
  final List<Map> recommendInfo;
  @override
  Widget build(BuildContext context) {
    return recommendInfo.length != 0 ?  Card(
      elevation: 0,
      margin: EdgeInsets.only(top: 10, left: 0, bottom: 0, right: 0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            _title(context),
            SizedBox(height: 8),
            _wrap(context, recommendInfo)
          ]
        ),
      ),
    ) : Container();
  }

  Widget _wrap(context, data) {
    return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: List.generate(data.length, (index) {
            return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfff2f2f2)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                padding: EdgeInsets.all(10.0),
                width: ScreenUtil().setWidth(320),
                child: Column(
                  children: [
                    _image(context, data[index]),
                    _desc(context, data[index]),
                    _price(context, data[index])
                  ]
                ),
              );
          }),
        );
  }
  Widget _title(context) {
    return Container(
        height: ScreenUtil().setHeight(50),
        child: Row(
          children: [
            TipIcon(
                  width: 3.0,
                  height: 20.0,
                  colorList: [Color(0xfff5503a), Color(0xfffad1cb)],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('看了又看',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(36)))),
          ],
        ));
  }

  Widget _image(context, data) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: data['mainImgPath'], fit: BoxFit.fill,),
    );
  }
  Widget _desc(context, data) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(data['productName'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Color(0xff888888)),)
    );
  }

  Widget _price(context, data) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('￥${data['price']}.00', style: TextStyle(color: Theme.of(context).primaryColor),),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xfff2f2f2)),
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Text('看相似', style: TextStyle(color: Color(0xff888888,), fontSize: 12)),
          )
        ]
      )
    );
  }

}