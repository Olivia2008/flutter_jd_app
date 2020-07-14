import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayStroll extends StatelessWidget {
  DayStroll({this.data});

  final List<Map> data;
  final String titleImage = 'assets/images/day_stroll.jpg';
  String fontFamlily2 = 'KING-OF-PIRATE';

  // 标题组件
  Widget _title() {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      child: Image.asset(titleImage),
    );
  }
  // list item组件
  Widget _item(context, item) {
    Size size = MediaQuery.of(context).size;
    Gradient gradient = LinearGradient(colors: [Color(0xFFFF2A2A), Color(0xFFF139D2)]);
    Shader shader = gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height));
    return InkWell(
      onTap: () {print('day stroll item');},
      child: Container(
        width: ScreenUtil().setWidth(183),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFF5F5F5), width: 1.0
//            right: BorderSide(width: 1.0, color: Color(0xFFF5F5F5)),
//            bottom: BorderSide(width: 1.0, color: Color(0xFFF5F5F5))
          )
        ),
        child: Column(
          children: <Widget>[
            Text(item['title'], style: TextStyle(
                fontFamily: fontFamlily2,
                foreground: Paint()..shader=shader,
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true)
            ),),
            Text(item['desc'], style: TextStyle(color: Color(0xFF222222), fontSize: ScreenUtil().setSp(22)),),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              width: ScreenUtil().setWidth(150), height: ScreenUtil().setHeight(150),
              child: FadeInImage.assetNetwork(fit: BoxFit.fill, placeholder: 'assets/images/lazy.png', image: item['img'],),
            )
          ],
        ),
      ), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _title(),
        Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(510),
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            // 宽高比例
            childAspectRatio: 1/1.4,
            crossAxisCount: 4,
            children: data.map((item) {
              return _item(context, item);
            }).toList(),
          ),
        )
      ],
    );
  }
}
