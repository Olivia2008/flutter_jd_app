import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ADBanner extends StatefulWidget {
  ADBanner({this.secondsList});

//  final String bgImg;
//  final String secondsTitle;
//  final String arrowRight;
  final List secondsList;

  @override
  _ADBannerState createState() => _ADBannerState();
}

class _ADBannerState extends State<ADBanner> {
  final String bgImg = 'assets/images/bc1.png';
  final String secondsTitle = 'assets/images/seconds.png';
  final String arrowRight = 'assets/images/arrow_right.png';
  DateTime date = DateTime.now();
  bool isInt = false;
  Duration diffDate;
  List<Map> dataList;

  @override
  void initState() {
    // TODO: implement initState
    dataList = widget.secondsList;
    super.initState();
    if (date.hour % 2 == 0) {
      isInt = true;
    } else {
      isInt = false;
    }
  }

  // 秒杀banner
  Widget _banner() {
    return Stack(
      children: <Widget>[
        Image(
          // height: ScreenUtil().setHeight(70),
          alignment: Alignment.topLeft,
          image: AssetImage(bgImg),
          fit: BoxFit.fill,
        ),
        Positioned(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(secondsTitle),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: isInt
                    ? Text(
                  '${date.hour + 2}点专场',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(24)),
                )
                    : Text(
                  '${date.hour + 1}点专场',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(24)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  '${date.hour}: ${date.minute}: ${date.second}',
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(24)),
                ),
              )
            ],
          ),
          top: 5,
          left: 10,
          height: ScreenUtil().setHeight(50),
        ),
        Positioned(
          top: 6,
          right: 5,
          child: InkWell(
            onTap: () {
              print('arrowright');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '更多秒杀',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil().setSp(24)),
                ),
                Image.asset(
                  arrowRight,
                  width: ScreenUtil().setWidth(24),
                  height: ScreenUtil().setHeight(24),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  // 秒杀单独项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(280),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 1.0, color: Colors.black12), top: BorderSide(width: 1.0, color: Colors.black12), bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            // Image.network(dataList[index]['img']),
            FadeInImage.assetNetwork(fit: BoxFit.fill, placeholder: 'assets/images/lazy.png', image: dataList[index]['img']),
            Text('￥${dataList[index]['discount']}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),),
            Text(
              '￥${dataList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey,fontSize: ScreenUtil().setSp(24)),
            )
          ],
        ),
      ),
    );
  }

  // 横向滑动列表
  Widget _scrollHorList() {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(370),
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          _banner(),
          _scrollHorList()
        ],
      ),
    );
  }
}
