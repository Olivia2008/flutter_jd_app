import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/GradientText.dart';
//class OwnerYard extends StatelessWidget {
//  OwnerYard({this.dataList});
//  final Map dataList;
////  final List dataOne;
////  final List dataTwo;
//
//  // 第一层单项组件
//  Widget _firstFloorItem(context, item) {
//    return InkWell(
//      onTap: () {print('owner yard first floor');},
//      child: Column(
//        children: <Widget>[
//          Text('${item['title']}', style: TextStyle(color: C),)
//        ],
//      ),
//    );
//  }
//  Widget _firstFloor() {
//    return Row(
//      children: <Widget>[],
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
//      height: ScreenUtil().setHeight(480),
//      decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.circular(5.0)
//      ),
//      child: Column(),
//    );
//  }
//}

class OwnerYard extends StatefulWidget {
  OwnerYard({this.dataListOne, this.dataListTwo});
  final List dataListOne;
  final List dataListTwo;
  @override
  _OwnerYardState createState() => _OwnerYardState();
}

class _OwnerYardState extends State<OwnerYard> with SingleTickerProviderStateMixin{
  // 只有一个AnimationController时用SingleTickerProviderStateMixin,否则vsync: this会报错
  Map<String, dynamic> data;
  List<Map> dataOne;
  List<Map> dataTwo;
  String fontFamily1 = 'PosterCircle';
  String fontFamlily2 = 'KING-OF-PIRATE';
  @override
  void initState() {
    // TODO: implement initState
    dataOne = widget.dataListOne;
    dataTwo = widget.dataListTwo;
    super.initState();
  }
  // 标题组件
  Widget _wonerTitle() {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      child: Image.asset('assets/images/owners.jpg'),
    );
  }
  // 第一层单项组件
  Widget _firstFloorItem(context, item) {
    Size size = MediaQuery.of(context).size;
    Gradient gradient = LinearGradient(colors: [Color(0xFF45CAFF), Color(0xFF1471FB)]);
    Shader shader = gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height));
    return InkWell(
      onTap: () {print('owner yard first floor item');},
      child: Container(
        width: ScreenUtil().setWidth(350),
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: <Widget>[
              Text(
                item['title'],
                style: TextStyle(
                    fontFamily: fontFamlily2,
                    foreground: Paint()..shader=shader,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true)
                ),
              ),
              Text(
                item['desc'],
                style: TextStyle(
                    color: Color(0xFF666771),
                  fontSize: ScreenUtil().setSp(24)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(150),
                      child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['img1'], fit: BoxFit.fill)
                    ),
                    Container(
                      height: ScreenUtil().setHeight(150),
                      child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['img2'], fit: BoxFit.fill)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget _firstFloor(context, data) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: data.map<Widget>((item) {
            return _firstFloorItem(context, item);
          }).toList(),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFF5F5F5))
          )
        ),
      ),
    );
  }
  Widget _seondFloorItem(context, item) {
    return InkWell(
      onTap: () {print('owner yard second floor item');},
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(item['title'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, letterSpacing: 0.58),),
              Text(item['desc'], style: TextStyle(color: Color(0xFF666771), fontSize: ScreenUtil().setSp(24)),),
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Container(
                  width: ScreenUtil().setWidth(150), height: ScreenUtil().setHeight(150),
                  child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['img'], fit: BoxFit.fill,),
                )
              )
            ],
          ),
        ),
      )
    );
  }
  Widget _secondFloor(context, data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: data.map<Widget>((item) {
        return _seondFloorItem(context, item);
      }).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _wonerTitle(),
        InkWell(
          onTap: () {print('探知时代');},
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: ScreenUtil().setHeight(560),
            width: ScreenUtil().setWidth(750),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: Column(
              children: <Widget>[
                _firstFloor(context, dataOne),
                _secondFloor(context, dataTwo)
              ],
            ),
          ),
        )
      ],
    );
  }
}

