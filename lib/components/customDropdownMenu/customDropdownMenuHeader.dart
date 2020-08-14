import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuController.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_main.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

typedef OnItemTap<T> = void Function(T value);

class CustomDropdownMenuHeader extends StatefulWidget {
  CustomDropdownMenuHeader(
      {this.decorationColor = const Color(0XFFF5F5F5),
      this.activeColor = const Color(0XFFC81623),
      this.iconColor = const Color(0XFF666666),
      this.radiusCircle = 10.0,
      this.controller,
      @required this.onItemTap,
      @required this.headerItems,
      @required this.stackKey});

  final Color decorationColor;
  final Color activeColor;
  final Color iconColor;
  final double radiusCircle;
  final OnItemTap onItemTap;
  final List headerItems;
  final GlobalKey stackKey;
  final CustomDropdownMenuController controller;

  @override
  _CustomDropdownMenuHeaderState createState() =>
      _CustomDropdownMenuHeaderState();
}

class _CustomDropdownMenuHeaderState extends State<CustomDropdownMenuHeader> {
  List<String> checkActiveList = [];
  // bool checkActive = false;
  GlobalKey _keyDropDownHeader = GlobalKey();
  double _screenWidth;
  int _menuCount;
  double _height = ScreenUtil().setHeight(100);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _menuCount = widget.headerItems.length;
    var checkedData = Provide.value<CategoryDetailMainProvide>(context)
        .navBarBrandCheckedList;

    return Container(
      key: _keyDropDownHeader,
      height: _height,
      width: ScreenUtil().setWidth(730),
      alignment: Alignment.center,
      child: GridView.count(
        crossAxisCount: _menuCount,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: (_screenWidth / _menuCount) / _height,
        children: widget.headerItems.map<Widget>((item) {
          return _headerMenus(item, checkedData, context);
        }).toList(),
      ),
    );
  }

  _headerMenus(item, brandCheckedList, context) {
    int index = widget.headerItems.indexOf(item);
    //int menuIndex = widget.controller.menuIndex;
    return InkWell(
      onTap: () {
        final RenderBox overlay =
            widget.stackKey.currentContext.findRenderObject();
        final RenderBox dropDownItemRenderBox =
            _keyDropDownHeader.currentContext.findRenderObject();
        var position =
            dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
        var size = dropDownItemRenderBox.size;
        widget.controller.dropDownHeaderHeight = size.height + position.dy;
        setState(() {
          widget.controller.changeIndex(index);
          // menuIndex = index;
        });
        
        var activeList = Provide.value<CategoryNavBarFilterProvide>(context)
            .serviceDiscountActiveList['activeValue'];
        var activeBrandList = Provide.value<CategoryNavBarFilterProvide>(context)
            .brandActiveList['valueList'];
        Provide.value<CategoryNavBarFilterProvide>(context)
            .brandActiveList['id'] = item['filDetailId'];
        Provide.value<CategoryNavBarFilterProvide>(context)
            .brandActiveList['name'] = item['name'];
        if (index == widget.controller.menuIndex) {
          if (index == 2) {
            Provide.value<CategoryDetailMainProvide>(context).changeConfirmBool(false);
            if (widget.controller.isShow)
              widget.controller.hide();
            else
              widget.controller.show(index);
            if (activeBrandList.length != 0 &&
                activeList.contains(item['filDetailId']) == false)
              activeList.add(item['filDetailId']);
          } else {
            // if (checkActiveList.indexOf(item['filDetailId']) == -1) checkActiveList.add(item['filDetailId']);
            // else checkActiveList.remove(item['filDetailId']);
            if (activeList.contains(item['filDetailId']))
              activeList.remove(item['filDetailId']);
            else
              activeList.add(item['filDetailId']);

            widget.controller.hide();
          }
          // print(
          //     'navbar2checkedList: ${Provide.value<CategoryNavBarFilterProvide>(context).serviceDiscountActiveList},brandCheckedList: ${activeBrandList}');
        } else {
          if (widget.controller.isShow)
            widget.controller.hide(isShowHideAnimation: false);
          widget.controller.show(index);
        }
        if (widget.onItemTap != null) widget.onItemTap(index);
      },
      child: _list2ViewItem(item, index, context, brandCheckedList),
    );
  }

  Widget _list2ViewItem(item, index, context, brandCheckedList) {
    return Provide<CategoryNavBarFilterProvide>(
      builder: (context, child, provider) {
        return index == 2
        ? widget.controller.isShow
            ? Container(
                width: ScreenUtil().setWidth(158),
                height: ScreenUtil().setHeight(60),
                margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 0),
                decoration: BoxDecoration(
                    color: widget.decorationColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.radiusCircle),
                        topRight: Radius.circular(widget.radiusCircle))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item['title'],
                      style: TextStyle(color: widget.activeColor),
                    ),
                    Icon(Icons.arrow_drop_up,
                        size: ScreenUtil().setSp(40), color: widget.activeColor)
                  ],
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(158),
                margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                decoration: provider.brandActiveList['valueList'].length == 0
                    ? BoxDecoration(
                        color: widget.decorationColor,
                        borderRadius: BorderRadius.circular(50.0),
                      )
                    : BoxDecoration(
                        color: Color(0XFFFDF0F0),
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: widget.activeColor,
                        )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    provider.brandActiveList['valueList'].length == 0
                        ? Text(item['title'])
                        : Text(
                            item['title'],
                            style: TextStyle(color: widget.activeColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                    Icon(Icons.arrow_drop_down,
                        size: ScreenUtil().setSp(40),
                        color: provider.brandActiveList['valueList'].length == 0
                            ? widget.iconColor
                            : widget.activeColor)
                  ],
                ),
              )
        : Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(158),
                margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                decoration: provider.serviceDiscountActiveList['activeValue']
                        .contains(item['filDetailId'])
                    ? BoxDecoration(
                        color: Color(0XFFFDF0F0),
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: widget.activeColor,
                        ))
                    : BoxDecoration(
                        color: widget.decorationColor,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                child: Text(
                  item['title'],
                  style: provider.serviceDiscountActiveList['activeValue']
                          .contains(item['filDetailId'])
                      ? TextStyle(color: widget.activeColor)
                      : TextStyle(),
                ));
      }
    );
  }
}

//class CustomDropdownMenuHeaderItem {
//  CustomDropdownMenuHeaderItem(
//      {this.title, this.iconData, this.iconSize, this.style});
//
//  final String title;
//  final IconData iconData;
//  final double iconSize;
//  final TextStyle style;
//}
