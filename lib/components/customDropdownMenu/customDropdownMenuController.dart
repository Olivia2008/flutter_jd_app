import 'package:flutter/foundation.dart';

// enum 来自foundation库
enum DropDownType {current, another}

class CustomDropdownMenuController with ChangeNotifier {
  double dropDownHeaderHeight;
  int menuIndex = 0;
  bool isShow = false;
  bool isHide = false;
  DropDownType dropDownType;
  void show(int index){
    isShow = true;
    menuIndex = index;
    notifyListeners();
  }
  void hide({bool isShowHideAnimation = true}) {
    isHide = isShowHideAnimation;
    isShow = false;
    notifyListeners();
  }
  void changeIndex(int index) {
    menuIndex = index;
    notifyListeners();
  }
}
