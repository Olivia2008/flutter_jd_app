import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class HomeRecommend extends StatefulWidget {
  HomeRecommend({this.param, this.recommendList});

  final Map<String, dynamic> param;
  final List<Map> recommendList;

  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> {
//  Map<String, dynamic> param = {'page': 1, 'pageSize': 20};
//  List<Map> recommendList = [];
  List<Map> recommendList;
  Map param;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recommendList = widget.recommendList;
    param = widget.param;
    // print('recommend组件中的数据:${recommendList}');
    //  _getRecommendData('homePageRecommend', param);
  }

  // 获取推荐数据
  void _getRecommendData(url, params) {
    request(url, params: params).then((res) {
      // json.decode解析json为Iterable<Map<dynamic, dynamic>>
      var data = json.decode(res.toString());
      // print(data);
      List<Map> newRecommendList = (data['data']['list'] as List).cast();
      // 将新数据与原数据合并，并++page
      setState(() {
        recommendList.addAll(newRecommendList);
        param['page']++;
      });
    });
  }

  // 标题组件
  Widget _title = Container(
    // alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1, color: Color(0xFFF5F5F5), style: BorderStyle.solid))),
    child: Image.asset('assets/images/recommend.png'),
  );

  // 内容为流式布局
  Widget _wrapList() {
    // 将请求的数据类型List<Map>改为List<Widget>
    if (recommendList.length != 0) {
      List<Widget> listWidget = recommendList.map((item) {
        String price = (double.parse(item['jp']) / 100).toStringAsFixed(2);
        int index = price.indexOf('.');
        String intPrice = price.substring(0, index);
        String doublePrice = price.substring(index, index + 3);
        String plusIcon = item['dpicon']['icon'];
        String plusImg = 'assets/images/plus.png';
        return InkWell(
          onTap: () {
            print('为你推荐');
          },
          child: Container(
            width: ScreenUtil().setWidth(352),
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 3.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Column(
              children: <Widget>[
                // Image.network(
                //   item['img'],
                //   width: ScreenUtil().setWidth(372),
                //   height: ScreenUtil().setHeight(372),
                // ),
                Container(
                  width: ScreenUtil().setWidth(372),
                  height: ScreenUtil().setHeight(372),
                  child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['img'], fit: BoxFit.fill)
                ),
                // 描述
                Container(
                  margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Row(
                    // textBaseline: TextBaseline.ideographic,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    // verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: item['icon'] == '1'
                              ? Image.asset('assets/images/market.png',
                                  width: ScreenUtil().setWidth(102),
                                  height: ScreenUtil().setHeight(28),
                                  matchTextDirection: true)
                              : item['icon'] == '2'
                                  ? Image.asset('assets/images/self-com.png',
                                      width: ScreenUtil().setWidth(48),
                                      height: ScreenUtil().setHeight(28),
                                      matchTextDirection: true)
                                  : item['icon'] == '4'
                                      ? Image.asset('assets/images/express.jpg',
                                          width: ScreenUtil().setWidth(98),
                                          height: ScreenUtil().setHeight(28),
                                          matchTextDirection: true)
                                      : item['icon'] == '11'
                                          ? Image.asset(
                                              'assets/images/choice.png',
                                              width: ScreenUtil().setWidth(100),
                                              height:
                                                  ScreenUtil().setHeight(28),
                                              matchTextDirection: true)
                                          : Text('')
                      ),
                      Expanded(
                        child: Text(
                          '${item['t']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: Color(0xFF232326),
                              fontSize: ScreenUtil().setSp(24)),
                        ),
                      ),
                    ],
                  ),
                ),
                // 价格
                Container(
                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // width: ScreenUtil().setWidth(352),
                        margin: EdgeInsets.only(right: 3),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(4, 0, 5, 0),
                              // child: Text('￥${(double.parse(item['jp']) / 100).toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFF23030), fontSize: ScreenUtil().setSp(30)),),
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: '￥$intPrice',
                                    style: TextStyle(
                                        color: Color(0xFFF23030),
                                        fontSize: ScreenUtil().setSp(30))),
                                TextSpan(
                                    text: '$doublePrice',
                                    style: TextStyle(
                                        color: Color(0xFFF23030),
                                        fontSize: ScreenUtil().setSp(26)))
                              ])),
                            ),
                            item['paicon'] == '1'
                                ? Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0,
                                    color: Color(0xFFE4393C),
                                    style: BorderStyle.solid),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.0, right: 2.0),
                                  child: Text('满减',
                                      style: TextStyle(
                                          color: Color(0xFFE4393C),
                                          fontSize:
                                          ScreenUtil().setSp(20)))),
                            )
                                : item['paicon'] == '3'
                                ? Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0,
                                    color: Color(0xFFE4393C),
                                    style: BorderStyle.solid),
                              ),
                              child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text('闪购',
                                      style: TextStyle(
                                          color: Color(0xFFE4393C),
                                          fontSize: ScreenUtil()
                                              .setSp(20)))),
                            )
                                : item['paicon'] == '6'
                                ? Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0,
                                    color: Color(0xFFE4393C),
                                    style: BorderStyle.solid),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      2, 0, 2, 0),
                                  child: Text(
                                    '拼购',
                                    style: TextStyle(
                                        color: Color(0xFFE4393C),
                                        fontSize: ScreenUtil()
                                            .setSp(20)),
                                  )),
                            )
                                : Text(''),
                          ],
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(98),
                        height: ScreenUtil().setHeight(48),
                        margin: EdgeInsets.only(right: 8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFBFBFBF), width: 1.0)),
                        child: Text(
                          '看相似',
                          style: TextStyle(
                              color: Color(0xFF686868),
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                      )
                    ],
                  ),
                ),
                // 会员
                plusIcon == '2'
                    ? Container(
                        height: ScreenUtil().setHeight(52),
                        padding: EdgeInsets.only(left: 11.0, right: 11.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                                '￥${(int.parse(item['dpicon']['p']) / 100).toStringAsFixed(2)}',
                                style: TextStyle(color: Color(0xFF232326))),
                            Image.asset(
                              plusImg,
                              width: ScreenUtil().setWidth(58),
                              height: ScreenUtil().setHeight(20),
                            )
                          ],
                        ))
                    : Container(
                        height: ScreenUtil().setHeight(52),
                      )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2, // 水平方向间距
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(730),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Color(0xFFF5F5F5)),
      child: Column(
        children: <Widget>[_title, _wrapList()],
      ),
    );
  }
}
