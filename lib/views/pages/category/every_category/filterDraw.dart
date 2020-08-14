import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/serviceDiscountWidget.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/priceRangeWidget.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/brandWidget.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/categoryWidget.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/otherWidget.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/footerWidget.dart';
import 'package:netease_news/views/pages/category/every_category/filterDraw/innerDrawer.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

 
class NavFilterDraw extends StatefulWidget {
  NavFilterDraw(this.scaffoldKey, this.data);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final data;
  @override
  _NavFilterDrawState createState() => _NavFilterDrawState();
}

class _NavFilterDrawState extends State<NavFilterDraw> {
  List _list;
  List _newList;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = widget.data['navList1'][3]['optionList'];
    var list1 = _list.sublist(0, 4);
    var list2 = _list.sublist(4, _list.length);
    var arr = {
      'title': '',
      'name': '',
      'id': '',
      'arrow': false,
      'list': list2
    };
    list1.insert(4, arr);
    _newList = list1;
    // Provide.value<CategoryNavBarFilterProvide>(context).getFilterOtherList(_newList[4]['list']);
    // print('newlist:${_newList[4]}');
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<CategoryNavBarFilterProvide>(context).navBarFilterOtherList = _newList[4]['list'];
    // if(_newList != null && _newList.length != 0) Provide.value<CategoryNavBarFilterProvide>(context).getFilterOtherList(_newList[4]['list']);
    return _newList != null
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _mainWidget(context, _newList),
              FooterWidget(_newList),
              Provide<CategoryNavBarFilterProvide>(
                builder: (context, child, provider) {
                  // provider.getFilterOtherList(_newList[4]['list']);
                  return provider.isShowInnerDrawer ? InnerDrawer() : Container();
                },
              )
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
          itemBuilder: (BuildContext ctx, int idx) {
            return _listItemWidget(data, context, idx);
          },
          itemCount: data.length,
        ));
  }

  Widget _listItemWidget(data, context, index) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: index == 0
            ? ServiceDiscount(data[index])
            : index == 1
                ? PriceRange(data[index])
                : index == 2
                    ? BrandWidget(data[index])
                    : index == 3
                        ? CategoryWidget(data[index], widget.scaffoldKey)
                        : Provide<CategoryNavBarFilterProvide>(
                          builder: (context, child, provider) {
                            
                            // print('filterDraw activelist:${provider.navBarFilterCateActiveList}');
                            var id = data[3]['id']+'_4_1';
                            var activeSubId = provider.navBarFilterCateActiveList['activeValue'];
                            var subId = '';
                            var _list = data[index]['list'];
                            if(activeSubId != '') {
                              subId = activeSubId.split('_').sublist(0, activeSubId.split('_').length - 1).join('_');
                              activeSubId == (id+'_2') ? _list = _list.sublist(0,1) : activeSubId == (id+'_1') ? _list = data[index]['list'] : _list = [];
                            } else {
                              id = '';
                            }
                            // print('index=3 data: $_list');
                            return id == subId ? OtherWidget(_list) : Container();
                          }
                        ));
  }
}
