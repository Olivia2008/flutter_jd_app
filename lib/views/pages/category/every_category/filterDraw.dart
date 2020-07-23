import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/components/varibleDecorationWidget/index.dart';

class NavFilterDraw extends StatefulWidget {
  NavFilterDraw(this.scaffoldKey, this.data);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final data;
  @override
  _NavFilterDrawState createState() => _NavFilterDrawState();
}

class _NavFilterDrawState extends State<NavFilterDraw> {
  List _list;
  bool _brandArrow = false;
  bool _cateArrow = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = widget.data['navList1'][3]['optionList'];
    // print(_list);
  }

  @override
  Widget build(BuildContext context) {
    return _list != null
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _mainWidget(context, _list),
              _footerWidget(context, _list)
            ],
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _mainWidget(context, data) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(120)),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return _listItemWidget(data, context, index);
          },
          itemCount: data.length,
        ));
  }

  Widget _footerWidget(context, data) {
    return Positioned(bottom: 0, child: _footerButtonsWidget(context, data));
  }

  Widget _footerButtonsWidget(context, data) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 * 3,
      height: ScreenUtil().setHeight(120),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Color(0xfff5f5f5)),
            bottom: BorderSide(color: Color(0xfff5f5f5)),
            left: BorderSide(color: Color(0xfff5f5f5)),
            right: BorderSide(color: Color(0xfff5f5f5))),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0)),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 4 * 3 / 2 - 1,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: ScreenUtil().setHeight(90),
              child: VaribleDecorations(
                width: ScreenUtil().setWidth(261),
                height: ScreenUtil().setHeight(90),
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                borderRadius: 50.0,
                fillActiveColor: Color(0xffdcdfe6),
                onPress: () {
                  print('reset');
                },
                child: Text('重置',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: ScreenUtil().setSp(32))),
              )),
          Container(
              // color: Colors.yellow,
              width: MediaQuery.of(context).size.width / 4 * 3 / 2 - 1,
              height: ScreenUtil().setHeight(90),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: VaribleDecorations(
                  width: ScreenUtil().setWidth(261),
                  height: ScreenUtil().setHeight(90),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                  fillDefaultColor: Theme.of(context).primaryColor,
                  fillActiveColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 50.0,
                  onPress: () {
                    print('confirm');
                  },
                  child: Text(
                    '确定(150万+件商品)',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(32)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ))),
        ],
      ),
    );
  }

  Widget _listItemWidget(data, context, index) {
    bool _otherArrow = false;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: index == 0
            ? _serviceDiscountWidget(data[index], context)
            : index == 1
                ? _priceRangeWidget(data[index], context)
                : index == 2
                    ? _brandWidget(data[index], context)
                    : index == 3
                        ? _categoryWidget(data[index], context)
                        : _commonWidget(data[index], context, _otherArrow));
  }

  Widget _serviceDiscountWidget(data, context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        // height: ScreenUtil().setHeight(800),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _serviceTitleWidget(data['title'], context),
                _serviceLocationWidget()
              ],
            ),
            _serviceGridViewWidget(data['list'], context)
            // _serviceListViewWidget(data['list'], context)
          ],
        ));
  }

  Widget _serviceTitleWidget(title, context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32))),
    );
  }

  Widget _serviceLocationWidget() {
    return GestureDetector(
        onTap: () {
          print('location');
        },
        child: Container(
            child: Row(
          children: <Widget>[
            Container(
                width: ScreenUtil().setWidth(60.0),
                height: ScreenUtil().setHeight(60.0),
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xfff2f2f7)),
                child:
                    Icon(Icons.pin_drop, color: Color(0xff888888), size: 20.0)),
            Container(
                margin: EdgeInsets.only(left: 10.0),
                width: ScreenUtil().setWidth(280),
                child: Text('北京昌平区环以内生命科学园38号国家蛋白质科学中心',
                    overflow: TextOverflow.ellipsis))
          ],
        )));
  }

  Widget _serviceGridViewWidget(data, context) {
    var _count = 3;
    return data.length != 0
        ? Container(
            height: ScreenUtil().setHeight(300),
            child: GridView.count(
              //
              crossAxisCount: _count,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2.0,
              children: data.map<Widget>((item) {
                return _serviceGridViewItem(item, context);
              }).toList(),
            ))
        : Center(child: Text('暂时无数据'));
  }

  Widget _serviceGridViewItem(data, context) {
    return VaribleDecorations(
        // width: ScreenUtil().setWidth(160),
        // height: ScreenUtil().setHeight(60),
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 0.0, bottom: 0.0),
        fillDefaultColor: Color(0xfff2f2f7),
        borderColor: Color(0xfff2f2f7),
        fillActiveColor: Color(0XFFC81623),
        borderRadius: 50.0,
        onPress: () {},
        child: Text(data['title'], style: TextStyle(color: Color(0xff333333))));
  }

  Widget _priceRangeWidget(data, context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // alignment: Alignment.center,
        child: Column(children: <Widget>[
          _priceRangeTitleWidget(data, context),
          _priceRangeInputWidget(data, context),
          _priceRangeChoiceWidget(data['list'], context)
        ]));
  }

  Widget _priceRangeTitleWidget(data, context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(data['title'],
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(32))),
    );
  }

  Widget _priceRangeInputWidget(data, context) {
    // final chips = [];
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Wrap(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(220),
              height: ScreenUtil().setHeight(80),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Color(0xfff2f2f7),
                    hintText: '最低价',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none)),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            Container(
                width: ScreenUtil().setWidth(25),
                height: ScreenUtil().setHeight(80),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text('--')),
            Container(
              width: ScreenUtil().setWidth(220),
              height: ScreenUtil().setHeight(80),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Color(0xfff2f2f7),
                    hintText: '最高价',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none)),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  print(value);
                },
              ),
            )
          ],
        ));
  }

  Widget _priceRangeChoiceWidget(data, context) {
    List<Widget> list = data.map<Widget>((item) {
      return InkWell(
        onTap: () {
          print('choice');
        },
        child: Container(
          width: ScreenUtil().setWidth(730 / data.length - 80),
          height: ScreenUtil().setHeight(100),
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xfff2f2f7),
              borderRadius: BorderRadius.circular(50.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(item['title'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black87)),
              Text(item['subTitle'],
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Color(0xff888888)))
            ],
          ),
        ),
      );
    }).toList();
    return data.length != 0
        ? Wrap(
            spacing: 2,
            children: list,
          )
        : Container();
  }


   Widget _commonWidget(data, context, arrow) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            _commonTitleWidget(data, context, arrow),
            _commonListWidget(data, context, arrow)
          ],
        ));
  }
  Widget _commonTitleWidget(data, context, arrow) {
    return InkWell(
        onTap: () {
          setState(() {
            arrow = !arrow;
          });
          print(arrow);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(data['title'],
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(32))),
            arrow ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down)
          ],
        ));
  }
  Widget _commonListWidget(data, context, arrow) {
    return Container();
  }


  Widget _brandWidget(data, context) {
    
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            _brandTitleWidget(data, context),
            _brandListWidget(data['list'], context)
          ],
        ));
  }

  Widget _brandTitleWidget(data, context) {
    return InkWell(
        onTap: () {
          setState(() {
            _brandArrow = !_brandArrow;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(data['title'],
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(32))),
            _brandArrow ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down)
          ],
        ));
  }

  Widget _brandListWidget(data, context) {
    var subList;
    _brandArrow ? subList = data : subList = data.sublist(0, 9);
    List<Widget> list = subList.map<Widget>((item) {
      return InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setHeight(140),
          child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/lazy.png',
              image: item['img'],
              fit: BoxFit.fill),
        ),
        // child: VaribleDecorations(
        //   onPress: () {print(item['title']);},
        //   margin: EdgeInsets.only(top: 10),
        //   width: ScreenUtil().setWidth(150),
        //   height: ScreenUtil().setWidth(80),
        //   borderColor: Colors.red,
        //   fillActiveColor: Colors.white,
        //   padding: EdgeInsets.only(
        //             left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
        //   borderRadius: 50.0,
        //   child: FadeInImage.assetNetwork(placeholder: 'assets/images/lazy.png', image: item['img'], fit: BoxFit.cover, width: ScreenUtil().setWidth(130), height: ScreenUtil().setHeight(80)),
        // )
      );
    }).toList();
    return data.length != 0 ? Wrap(spacing: 6.0, children: list) : Container();
  }

  Widget _categoryWidget(data, context) {
    
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            _cateTitleWidget(data, context),
            _categoryListWidget(data, context, _cateArrow)
          ],
        ));
  }
  Widget _cateTitleWidget(data, context) {
    return InkWell(
        onTap: () {
          setState(() {
            _cateArrow = !_cateArrow;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(data['title'],
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(32))),
            _cateArrow ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down)
          ],
        ));
  }
  Widget _categoryListWidget(data, context, _cateArrow) {
    return Container();
  }
  Widget _othersWidget(data, context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Text(data['title'],
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(32))));
  }
}
