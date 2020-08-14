import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';
import 'package:provide/provide.dart';

class BrandWidget extends StatefulWidget {
  BrandWidget(this.data);
  final Map data;
  @override
  _BrandWidgetState createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            _brandTitleWidget(widget.data, context),
            _brandListWidget(widget.data['list'], context, widget.data['arrow'])
          ],
        ));
  }

  Widget _brandTitleWidget(data, context) {
    return Provide<CategoryNavBarFilterProvide>(
      builder: (context, child, provider) {
        return InkWell(
        onTap: () {
          setState(() {
            data['arrow'] = !data['arrow'];
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(data['title'],
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(32))),
            Row(children: <Widget>[
              provider.brandActiveList['titleList'].length != 0
                  ? Container(
                      alignment: Alignment.centerRight,
                      width: ScreenUtil().setWidth(200),
                      child: Text('${provider.brandActiveList['titleList'].join(',')}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Color(0XFFC81623))))
                  : Container(),
              data['arrow']
                  ? Icon(Icons.keyboard_arrow_up)
                  : Icon(Icons.keyboard_arrow_down)
            ])
          ],
        ));
      }
    );
  }

  Widget _brandListWidget(data, context, arrow) {
    var subList;
    arrow ? subList = data : subList = data.sublist(0, 9);
    List<Widget> list = subList.map<Widget>((item) {
      return Provide<CategoryNavBarFilterProvide>(
          builder: (context, child, provider) {
        return InkWell(
          onTap: () {
            
            setState(() {
              provider.brandActiveList['id'] = widget.data['id'];
              provider.brandActiveList['name'] = widget.data['name'];
              if (provider.brandActiveList['valueList'].contains(item['value'])) {
                provider.brandActiveList['valueList'].remove(item['value']);
                provider.brandActiveList['titleList'].remove(item['title']);
              } else {
                provider.brandActiveList['valueList'].add(item['value']);
                provider.brandActiveList['titleList'].add(item['title']);
              }
            });
            print('brandActiveList:${provider.brandActiveList}');
          },
          child: provider.brandActiveList['valueList'].contains(item['value'])
              ? Container(
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setHeight(80),
                  padding: EdgeInsets.all(3.0),
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFFC81623)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: FadeInImage.assetNetwork(
                      width: ScreenUtil().setWidth(100),
                      // height: ScreenUtil().setHeight(100),
                      placeholder: 'assets/images/lazy.png',
                      image: item['img'],
                      fit: BoxFit.cover))
              : Container(
                  margin: EdgeInsets.all(6.0),
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setHeight(80),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/lazy.png',
                      image: item['img'],
                      fit: BoxFit.cover),
                ),
        );
      });
    }).toList();
    return data.length != 0 ? Wrap(spacing: 6.0, children: list) : Container();
  }
}
