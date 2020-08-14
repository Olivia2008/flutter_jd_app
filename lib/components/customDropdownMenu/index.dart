import 'package:flutter/material.dart';
import 'customDropdownMenuController.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/category_detail_main.dart';
import 'package:netease_news/views/provides/category_detail_navBar.dart';

class CustomDropDownMenuBuilder {
  CustomDropDownMenuBuilder({this.dropDownWiget, this.dropDownHeight, this.confirmButton});
  final Widget dropDownWiget;
  final double dropDownHeight;
  bool confirmButton;
}
typedef DropdownMenuChange = void Function(bool isShow, int index, List data);
class CustomDropdownMenu extends StatefulWidget {
  CustomDropdownMenu({@required this.controller,@required this.menus, this.animationMilliseconds = 500, this.maskColor = const Color.fromRGBO(0, 0, 0, 0.5), this.dropdownMenuChanging, this.dropDownMenuChanged});
  final CustomDropdownMenuController controller;
  final List<CustomDropDownMenuBuilder> menus;
  final int animationMilliseconds;
  final Color maskColor;
  final DropdownMenuChange dropdownMenuChanging;
  final DropdownMenuChange dropDownMenuChanged;
  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> with SingleTickerProviderStateMixin{
  bool _isShowDropdownItemWidget = false;
  bool _isControllerDisposed = false;
  Animation<double> _animation;
  AnimationController _controller;
  double _maskColorOpacity;
  double _dropdownHeight;
  int _currentMenuIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(_onController);
    _controller = new AnimationController(duration: Duration(milliseconds: widget.animationMilliseconds), vsync: this);
  }
  _onController() {
    _currentMenuIndex = widget.controller.menuIndex;
    if (_currentMenuIndex >= widget.menus.length || widget.menus[_currentMenuIndex] == null) {
      return;
    }

    _isShowDropdownItemWidget = !_isShowDropdownItemWidget;
    if (widget.dropdownMenuChanging != null) {
      widget.dropdownMenuChanging(_isShowDropdownItemWidget, _currentMenuIndex, Provide.value<CategoryDetailMainProvide>(context).navBarBrandCheckedList);
    }


    _dropdownHeight = widget.menus[_currentMenuIndex].dropDownHeight;

    _animation?.removeListener(_handleAnimationAddListener);
    _animation?.removeStatusListener(_handleAnimationAddStatusListener);
    _animation = new Tween(begin: 0.0, end: _dropdownHeight).animate(_controller)
      ..addListener(_handleAnimationAddListener)
      ..addStatusListener(_handleAnimationAddStatusListener);

    if (_isControllerDisposed) return;

    if (widget.controller.isShow) {
      _controller.forward();
    } else if (widget.controller.isHide) {
      _controller.reverse();
    } else {
      _controller.value = 0;
    }
  }
  // 监听mask颜色透明度的变化
  void _handleAnimationAddListener() {
    setState(() {
      var heightRatio = _animation.value / _dropdownHeight;
      _maskColorOpacity = widget.maskColor.opacity * heightRatio;
    });

  }
  // 监听动画不同状态时下拉框的显示与否
  void _handleAnimationAddStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        if (widget.dropDownMenuChanged != null) {
          widget.dropDownMenuChanged(false, _currentMenuIndex, Provide.value<CategoryDetailMainProvide>(context).navBarBrandCheckedList);
        }
        break;
      case AnimationStatus.forward:
      // TODO: Handle this case.
        break;
      case AnimationStatus.reverse:
      // TODO: Handle this case.
        break;
      case AnimationStatus.completed:
        if (widget.dropDownMenuChanged != null) {
          widget.dropDownMenuChanged(true, _currentMenuIndex, Provide.value<CategoryDetailMainProvide>(context).navBarBrandCheckedList);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.duration = Duration(milliseconds: widget.animationMilliseconds);
    return widget.controller.isShow ? _buildDropdownWidget() : Container();
  }
  @override
  // 组件销毁移除所有监听事件
  void dispose() {
    _animation ?.removeListener(_handleAnimationAddListener);
    _animation ?.removeStatusListener(_handleAnimationAddStatusListener);
    widget.controller ?.removeListener(_onController);
    _controller ?.dispose();
    _isControllerDisposed = true;
    super.dispose();
  }
  Widget _buildDropdownWidget() {
    int menuIndex = widget.controller.menuIndex;
    if(menuIndex >= widget.menus.length) return Container();
    return Positioned(
      width: MediaQuery.of(context).size.width,
      top: widget.controller.dropDownHeaderHeight,
      left: 0,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: _animation == null ? 0 : _animation.value,
                color: widget.maskColor.withOpacity(_maskColorOpacity),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0XFFF5F5F5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)
                    )
                ),
                child: widget.menus[menuIndex].dropDownWiget,
              )
            ),
            _maskContanier()
          ],
        )
      ),
    );
  }
  Widget _maskContanier() {
    return GestureDetector(
      onTap: () {
        widget.controller.hide();
        // Provide.value<CategoryDetailMainProvide>(context).changeConfirmBool(false);
        var tempActiveBrandList = Provide.value<CategoryNavBarFilterProvide>(context).tempBrandActiveList;
        var brandActiveList = Provide.value<CategoryNavBarFilterProvide>(context).brandActiveList;
        // print('customDropdownMenu provide confirmbool:${Provide.value<CategoryDetailMainProvide>(context).confirmBool}');
        setState(() {
          if(Provide.value<CategoryDetailMainProvide>(context).confirmBool == false) {
            if(brandActiveList['valueList'].length != 0 && tempActiveBrandList['valueList'].length != 0) {
              tempActiveBrandList['valueList'].forEach((item) {
                brandActiveList['valueList'].remove(item);
                brandActiveList['titleList'].remove(item);
              });
              // print('custom header brandActiveList:$brandActiveList');
            }
            
            Provide.value<CategoryNavBarFilterProvide>(context).getTempBrandActiveList({'titleList': [], 'valueList': []});

          }
        });
        // print('customDropdownMenu provide brandActiveList:$brandActiveList, tempBrandList:$tempActiveBrandList');

      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: widget.controller.menuIndex == 2 ? MediaQuery.of(context).size.height : 0,
          color: widget.maskColor.withOpacity(_maskColorOpacity),
      ),
    );
  }
}




